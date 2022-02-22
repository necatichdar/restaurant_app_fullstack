import 'package:flutter/material.dart';
import 'package:restaurant_rating/app/controller/detail_controller.dart';
import 'package:restaurant_rating/app/controller/map_controller.dart';
import '../../core/extension/context_extension.dart';
import 'package:get/get.dart';

import 'widgets/text_field_input.dart';

class AddRestoranPage extends StatefulWidget {
  AddRestoranPage({Key? key}) : super(key: key);

  @override
  State<AddRestoranPage> createState() => _AddRestoranPageState();
}

class _AddRestoranPageState extends State<AddRestoranPage> {
  DetailController controller = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: context.paddingHigh,
          child: Column(children: [
            Padding(
                padding: context.paddingMedium,
                child: Text("label_texts_add".tr,
                    style: Theme.of(context).textTheme.headline6)),
            buildTextField(
                controller: nameController,
                hintText: "label_texts_restoran_name".tr,
                icon: Icon(Icons.restaurant)),
            context.emptylowWidget,
            buildTextField(
                controller: descriptionController,
                hintText: "label_texts_restoran_description".tr,
                icon: Icon(Icons.restaurant)),
            context.emptylowWidget,
            buildTextField(
                controller: controller.textEditingController,
                hintText: "label_texts_you_comment".tr,
                maxLines: 2,
                icon: Icon(Icons.comment)),
            ratingSlider(context),
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
            context.emptyMediumWidget,
            buildAddButton()
          ]),
        ),
      ),
    );
  }

  Obx ratingSlider(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Text(
            '  ${controller.sliderValue.value}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Expanded(
            child: Slider(
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
    );
  }

  TextFieldInput buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType type = TextInputType.name,
    required Icon icon,
  }) {
    return TextFieldInput(
      textEditingController: controller,
      hintText: hintText,
      textInputType: type,
      icon: icon,
      maxLines: maxLines,
    );
  }

  SizedBox buildAddButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (nameController.text.isEmpty ||
              descriptionController.text.isEmpty ||
              controller.textEditingController.text.isEmpty) {
            Get.snackbar(
              "error_texts_error".tr,
              "error_texts_validate_all".tr,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            Get.back();
            await controller.createRestoranWithComment(
                name: nameController.text,
                description: descriptionController.text);
            controller.clear();
            nameController.dispose();
            descriptionController.dispose();
            MapController.to.markerClose();
          }
        },
        child: Text("label_texts_send".tr),
      ),
    );
  }
}
