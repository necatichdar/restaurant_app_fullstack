import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:restaurant_rating/app/model/restoran_model.dart';

import 'map_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var pageController = PageController();
  var currentIndex = 0.obs;
  var restoranList = [];

  changePage(index, {Restoran? deger}) async {
    currentIndex(index);
    pageController.jumpToPage(index);
    if (deger != null) {
      await MapController.to.changeCameraMove(
          double.parse(deger.lat!), double.parse(deger.long!));
    }
  }
}
