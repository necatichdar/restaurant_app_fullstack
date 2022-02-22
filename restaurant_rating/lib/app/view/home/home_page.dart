import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_rating/app/controller/auth_controller.dart';
import 'package:restaurant_rating/app/controller/home_controller.dart';
import 'package:restaurant_rating/app/controller/local_manager.dart';
import 'package:restaurant_rating/app/controller/map_controller.dart';
import 'package:restaurant_rating/app/view/admin_page.dart';
import 'package:restaurant_rating/app/view/detail_page.dart';
import 'package:restaurant_rating/app/view/home/map_page.dart';
import 'package:restaurant_rating/app/view/home/profile_page.dart';
import 'package:restaurant_rating/app/view/home/qr_page.dart';
import 'package:restaurant_rating/app/view/widgets/language_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      openDialog();
    });
    // openDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: PageView(
        controller: controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          controller.changePage(value);
        },
        children: [
          MapPage(),
          QrPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Future<void> openDialog() async {
    Get.back();
    if (LocaleManager.to.isDeeplink != "") {
      var restoran;
      for (var i = 0; i < MapController.to.restoranList.length; i++) {
        if (MapController.to.restoranList[i].restoranId.toString() ==
            LocaleManager.to.isDeeplink) {
          restoran = MapController.to.restoranList[i];

          break;
        }
      }
      if (restoran != null) {
        await MapController.to.googleMapsController!.animateCamera(
            CameraUpdate.newLatLngZoom(
                LatLng(double.parse(restoran.lat), double.parse(restoran.long)),
                16));
      }
      Future.delayed(Duration(seconds: 1), () async {
        await Get.bottomSheet(DetailPage(
          parameter: LocaleManager.to.isDeeplink,
        ));
        LocaleManager.to.changeDeeplinkParameter("");
      });
    }
  }

  Widget buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home_texts_bottom_bar_1'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_sharp),
              label: 'home_texts_bottom_bar_2'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'home_texts_bottom_bar_3'.tr,
            ),
          ],
          currentIndex: controller.currentIndex.value,
          onTap: (value) {
            controller.changePage(value);
          },
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Restaurant Rating'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [PopupButton()],
      leading: AuthController.to.currentUser.role == "admin"
          ? IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Get.to(AdminPage());
              },
            )
          : null,
      elevation: 0,
    );
  }
}
