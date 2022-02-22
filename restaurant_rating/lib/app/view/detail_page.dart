import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:restaurant_rating/app/controller/auth_controller.dart';
import 'package:restaurant_rating/app/controller/detail_controller.dart';
import 'package:restaurant_rating/app/model/comment_model.dart';
import 'package:restaurant_rating/core/consts.dart';
import 'package:restaurant_rating/core/extension/context_extension.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatefulWidget {
  String? parameter;
  DetailPage({Key? key, this.parameter}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ScreenshotController screenshotController = ScreenshotController();
  DetailController controller = Get.find();
  void izinKontrol() async {
    // Toast.show("Resmi kaydedebilmek için izin gereklidir.", context)
    if (await Permission.storage.isGranted) {
      takeScreenshot();
    } else {
      // Toast.show("Resmi kaydedebilmek için izin gereklidir.", context);
      await Permission.storage.request();
      if (await Permission.storage.isGranted) {
        takeScreenshot();
      }
    }
  }

  void takeScreenshot() async {
    if (await Permission.storage.isGranted == true) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = "${DateTime.now().microsecondsSinceEpoch}.png";
      String path = '$directory';
      final imageFile = await screenshotController.captureAndSave(
        path = path,
        fileName: fileName,
      );
      Share.shareFiles([imageFile!], text: 'Restoran');
    }
  }

  void postComment() async {
    if (controller.textEditingController.text.isEmpty) {
      showSnacbar("Lütfen doldurunuz");
      return;
    }
    var response = await controller.postComment();

    if (response != false) {
      await showSnacbar("Onay bekleyen gönderiniz bulunmaktadır!");
    } else {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.getRestoranDetail(widget.parameter.toString());
  }

  @override
  void dispose() {
    controller.isLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: context.paddingHighHorizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.black,
                      ),
                      buildTopText(context),
                      buildImages(),
                      context.emptylowWidget,
                      buildCommentTextAndAddButton(context),
                      context.emptylowWidget,
                      buildComments()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Row buildCommentTextAndAddButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "label_texts_comment".tr,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        controller.restoran.value.comments == null
            ? SizedBox()
            : controller.restoran.value.comments!.any(
                    (e) => e.userId == AuthController.to.currentUser.userId)
                ? SizedBox()
                : TextButton(
                    onPressed: () {
                      addShowDialog(context);
                    },
                    child: Text('label_texts_add1'.tr),
                  ),
      ],
    );
  }

  addShowDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Text('${controller.restoran.value.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {},
                    controller: controller.textEditingController,
                    decoration: InputDecoration(),
                  ),
                  Obx(
                    () => Slider(
                      value: controller.sliderValue.value,
                      onChanged: (value) {
                        controller.sliderValue.value = value;
                      },
                      min: 0,
                      max: 5,
                      divisions: 20,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Colors.grey,
                      label: '${controller.sliderValue.value}',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: controller.base64 == ""
                      ? Icon(Icons.camera)
                      : Text("label_texts_added".tr),
                  onPressed: () async {
                    // Get.back();
                    controller.base64 == ""
                        ? await controller.getImage()
                        : controller.base64 = "";
                    setState(() {});
                  },
                ),
                TextButton(
                  child: Text('Vazgeç',
                      style: Theme.of(context).textTheme.bodyText1),
                  onPressed: () {
                    controller.base64 = "";
                    Get.back();
                  },
                ),
                TextButton(
                  child: Text('Gönder'),
                  onPressed: () async {
                    postComment();
                  },
                ),
              ],
            ),
          );
        }).then((value) => controller.getRestoranDetail('${widget.parameter}'));
  }

  Row buildTopText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nameText(context),
              context.emptylowWidget,
              controller.restoran.value.comments == null ||
                      controller.restoran.value.comments!.length == 0
                  ? SizedBox()
                  : ratingText(context),
              context.emptylowWidget,
            ],
          ),
        ),
        qrAndShareButton()
      ],
    );
  }

  Text nameText(BuildContext context) {
    return Text(
      "${controller.restoran.value.name}",
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text ratingText(BuildContext context) {
    return Text(
      "${"label_texts_rating".tr}: ${controller.rating.value}/5(${controller.restoran.value.comments!.length})",
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  Row qrAndShareButton() {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Screenshot(
            controller: screenshotController,
            child: Container(
                color: Colors.white,
                child:
                    QrImage(data: "https://cuhadar.dev/${widget.parameter}")),
          ),
        ),
        IconButton(
            onPressed: () async {
              Clipboard.setData(ClipboardData(
                  text: "https://cuhadar.dev/${widget.parameter}"));
              izinKontrol();
            },
            icon: Icon(Icons.share)),
      ],
    );
  }

  SizedBox buildImages() {
    return SizedBox(
      height: Get.height * 0.15,
      child: controller.restoran.value.images == null ||
              controller.restoran.value.images!.length == 0
          ? Center(
              child: Text('error_texts_nodataimage'.tr),
            )
          : ListView.builder(
              itemCount: controller.restoran.value.images!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: context.lowMediumValue),
                  child: Card(
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(context.lowMediumValue),
                        child: CachedNetworkImage(
                          imageUrl: Constants.instance.apiUrl +
                              controller
                                  .restoran.value.images![index].imagePath!,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Expanded buildComments() {
    return Expanded(
      child: controller.restoran.value.comments == null ||
              controller.restoran.value.comments!.length == 0
          ? Center(
              child: Text('error_texts_nodata'.tr),
            )
          : ListView.builder(
              itemCount: controller.restoran.value.comments!.length,
              itemBuilder: (context, index) {
                return CommentWidget(
                  comment: controller.restoran.value.comments![index],
                );
              },
            ),
    );
  }

  showSnacbar(String message) {
    Get.closeCurrentSnackbar();
    Get.showSnackbar(GetSnackBar(
      title: "error_texts_error".tr,
      message: message,
      duration: Duration(milliseconds: 1500),
    ));
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comments comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.red,
        child: Text("${comment.rating}"),
      ),
      title: Text(
        "${comment.username}",
        style: Theme.of(context).textTheme.bodyText2,
      ),
      subtitle: Text("${comment.comment}"),
    );
  }
}
