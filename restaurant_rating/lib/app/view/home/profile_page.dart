import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_rating/app/controller/auth_controller.dart';
import 'package:restaurant_rating/app/controller/home_controller.dart';
import 'package:restaurant_rating/app/view/widgets/text_field_input.dart';
import 'package:restaurant_rating/core/extension/context_extension.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingHigh,
      child: Column(
        children: [
          Flexible(child: Container(), flex: 1),
          buildLogo(),
          Flexible(child: Container(), flex: 1),
          buildTextFieldUsername(),
          SizedBox(height: context.lowValue),
          buildTextFieldMail(),
          SizedBox(height: context.lowValue),
          SizedBox(height: context.mediumValue),
          buildExitButton(),
          Flexible(child: Container(), flex: 3),
        ],
      ),
    );
  }

  Flexible buildLogo() {
    return Flexible(
        flex: 3,
        child:
            Hero(tag: 'logo', child: Image.asset("assets/images/logo1.png")));
  }

  SizedBox buildExitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.find<AuthController>().setData(login: false);
          Get.find<HomeController>().changePage(0);
        },
        child: Text('buttons_logout'.tr),
      ),
    );
  }

  TextFieldInput buildTextFieldUsername() {
    return TextFieldInput(
      textEditingController: TextEditingController(),
      hintText: authController.currentUser.username ?? '',
      textInputType: TextInputType.name,
      icon: Icon(Icons.person),
      isEditable: true,
    );
  }

  TextFieldInput buildTextFieldMail() {
    return TextFieldInput(
      textEditingController: TextEditingController(),
      hintText: authController.currentUser.mail ?? '',
      textInputType: TextInputType.emailAddress,
      icon: Icon(Icons.email),
      isEditable: true,
    );
  }
}
