import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_rating/app/model/user_model.dart';
import 'package:restaurant_rating/app/services/services.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final box = GetStorage();
  RxBool isLogin = false.obs;
  User currentUser = User();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLocalData();
  }

  getLocalData() {
    isLogin(box.read('login') ?? false);
    if (isLogin.value) {
      currentUser = User.fromJson(box.read('userData') ?? Map());
    }
  }

  //Çıkış yapma
  setData({required bool login, Map? userdata}) {
    box.write('login', login);
    isLogin(login);
    if (isLogin.value == false) {
      box.write('userData', null);
    } else {
      box.write('userData', userdata);
    }
    box.save();
  }

  Future login({required String email, required String password}) async {
    isLoading(true);
    var response = await DatabaseServices.instance
        .userLogin(email: email, password: password);
    if (response != null) {
      print(response);
      print("cevap");
      currentUser = response;
      if (currentUser.status == false) {
        showSnacbar("error_texts_banned".tr);
      } else {
        print("deneme");
        Future.delayed(Duration(seconds: 1), () {
          setData(login: true, userdata: currentUser.toJson());
          Get.offAllNamed('/');
        });
        // setData(login: true, userdata: currentUser.toJson());
      }
    } else {
      showSnacbar("error_texts_unvalid".tr);
    }

    isLoading(false);
  }

  Future register(
      {required String username,
      required String email,
      required String password}) async {
    isLoading(true);
    var response = await DatabaseServices.instance
        .userRegister(username: username, email: email, password: password);
    if (response.runtimeType == String) {
      showSnacbar('$response');
      isLoading(false);
      return;
    }
    currentUser = response;
    await Future.delayed(Duration(seconds: 1));
    setData(login: true, userdata: currentUser.toJson());
    isLoading(false);
  }

  showSnacbar(String message) {
    Get.closeCurrentSnackbar();
    Get.snackbar("error_texts_error".tr, message,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(
            top: Get.height * 0.1,
            left: Get.width * 0.1,
            right: Get.width * 0.1),
        duration: Duration(milliseconds: 1500));
  }
}
