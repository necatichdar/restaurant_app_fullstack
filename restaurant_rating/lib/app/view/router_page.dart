import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_rating/app/controller/auth_controller.dart';
import 'package:restaurant_rating/app/controller/local_manager.dart';
import 'package:restaurant_rating/app/view/home/home_page.dart';
import 'package:restaurant_rating/app/view/login/login_page.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find();
    if (Get.parameters['id'] != null) {
      LocaleManager.to.changeDeeplinkParameter(Get.parameters['id'].toString());
    }
    return Obx(() => controller.isLogin.value ? HomePage() : LoginPage());
  }
}
