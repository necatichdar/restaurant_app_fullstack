import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_rating/app/controller/auth_controller.dart';
import 'package:restaurant_rating/app/controller/local_manager.dart';
import 'package:restaurant_rating/app/controller/map_controller.dart';
import 'package:restaurant_rating/app/model/comment_model.dart';
import 'package:restaurant_rating/app/model/restoran_model.dart';
import 'package:restaurant_rating/app/services/services.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();

  var restoran = Restoran().obs;
  var rating = 4.0.obs;

  XFile image = XFile("");
  String base64 = "";
  RxBool isLoading = false.obs;
  var sliderValue = 4.0.obs;
  TextEditingController textEditingController = TextEditingController();

  getRestoranDetail(String id) async {
    isLoading.value = true;
    var response = await DatabaseServices.instance.getRestaurantDetail(id);
    restoran(response);
    if (restoran.value.comments != null) {
      avarageCalc(restoran.value.comments!);
    }
    isLoading.value = false;
  }

  avarageCalc(List<Comments> list) {
    var toplam = 0.0;
    for (var i = 0; i < list.length; i++) {
      print(list[i].rating);
      toplam += list[i].rating!;
    }
    rating(toplam / list.length);
  }

  clear() {
    base64 = "";
    image = XFile("");
    textEditingController.clear();
    sliderValue(4.0);
  }

  getImage() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      print(image);
      print(image!.name);
      final bytes = File(image.path).readAsBytesSync();
      String base64Image = //"data:image/png;base64," +
          base64Encode(bytes);
      base64 = base64Image;
      print(base64);
    } catch (e) {}
    update();
    // print("img_pan : $base64Image");
  }

  postComment() async {
    var cevap = await DatabaseServices.instance.postComment(
        comment: textEditingController.text,
        restoran_id: restoran.value.restoranId.toString(),
        user_id: AuthController.to.currentUser.userId.toString(),
        username: AuthController.to.currentUser.username.toString(),
        rating: sliderValue.value.toString(),
        imagePath: base64);
    print(cevap);
    print(cevap.runtimeType);
    clear();
    if (cevap.runtimeType == String) {
      return cevap;
    }
    return false;
  }

  createRestoranWithComment({
    required String name,
    required String description,
  }) async {
    if (await MapController.locationVerify()) {
      Restoran sonuc;
      sonuc = await DatabaseServices.instance.createRestoran(
        name: name,
        description: description,
        lat: MapController.to.marker.value.position.latitude,
        long: MapController.to.marker.value.position.longitude,
      );
      var degisken = false;
      if (sonuc.restoranId != null) {
        degisken = await DatabaseServices.instance.postComment(
            comment: textEditingController.text,
            restoran_id: sonuc.restoranId.toString(),
            user_id: AuthController.to.currentUser.userId.toString(),
            username: AuthController.to.currentUser.username.toString(),
            rating: sliderValue.value.toString(),
            imagePath: base64);
      }
      print("değişken $degisken");
      if (degisken) {
        Get.snackbar("error_texts_error".tr, "label_texts_later".tr,
            margin: EdgeInsets.only(
                top: Get.height * 0.1,
                left: Get.width * 0.1,
                right: Get.width * 0.1),
            duration: Duration(milliseconds: 1500));

        MapController.to.getRestoran();
      } else {
        Get.snackbar("error_texts_error".tr, "error_texts_unknown".tr,
            margin: EdgeInsets.only(
                top: Get.height * 0.1,
                left: Get.width * 0.1,
                right: Get.width * 0.1),
            duration: Duration(milliseconds: 1500));
      }
      clear();
    } else {
      await DatabaseServices.instance
          .banned(userId: AuthController.to.currentUser.userId.toString());
      Get.showSnackbar(GetSnackBar(
        title: "error_texts_error".tr,
        message: "error_texts_banned".tr,
        duration: Duration(milliseconds: 3000),
      ));
      LocaleManager.to.changeDeeplinkParameter("");
      Future.delayed(Duration(seconds: 3), () {
        AuthController.to.setData(login: false);
      });
    }
  }
}
