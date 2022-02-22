import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_rating/app/controller/auth_controller.dart';
import 'package:restaurant_rating/app/view/widgets/language_button.dart';
import 'package:restaurant_rating/app/view/widgets/text_field_input.dart';
import '../../../core/extension/context_extension.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var authController = Get.find<AuthController>();

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  loginButton() async {
    if (!emailController.text.isEmail) {
      showSnacbar("error_texts_validate_email".tr);
      return;
    }
    if (passwordController.text.isEmpty) {
      showSnacbar("error_texts_validate_password".tr);
      return;
    }
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
    authController.login(
        email: emailController.text, password: passwordController.text);
  }

  registerButton() {
    if (usernameController.text.isEmpty) {
      showSnacbar("error_texts_validate_username".tr);
      return;
    }
    if (!emailController.text.isEmail) {
      showSnacbar("error_texts_validate_email".tr);
      return;
    }
    if (passwordController.text.isEmpty) {
      showSnacbar("error_texts_validate_password".tr);
      return;
    }
    authController.register(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text);
  }

  showSnacbar(String message) {
    Get.closeCurrentSnackbar();
    Get.showSnackbar(GetSnackBar(
      title: "error_texts_error".tr,
      message: message,
      duration: Duration(milliseconds: 1500),
    ));
  }

  animatePage({required int index}) {
    _tabController.animateTo(index, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildLoadingAnimation(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                LoginPage(context),
                RegisterPage(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Restaurant Rating'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [PopupButton()],
    );
  }

  Obx buildLoadingAnimation() {
    return Obx(() => authController.isLoading.value
        ? LinearProgressIndicator()
        : SizedBox());
  }

  Padding LoginPage(BuildContext context) {
    return Padding(
      padding: context.paddingHigh,
      child: Column(
        children: [
          Flexible(child: Container(), flex: 1),
          buildLogo(),
          Flexible(child: Container(), flex: 1),
          buildTextFieldMail(),
          SizedBox(height: context.lowValue),
          buildTextFieldPassword(),
          SizedBox(height: context.mediumValue),
          buildLoginButton(),
          Flexible(child: Container(), flex: 2),
          buildRegisterNavigateButton(context),
          Flexible(child: Container(), flex: 1),
        ],
      ),
    );
  }

  Padding RegisterPage(BuildContext context) {
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
          buildTextFieldPassword(),
          SizedBox(height: context.mediumValue),
          buildRegisterButton(),
          Flexible(child: Container(), flex: 2),
          buildLoginNavigateButton(context),
          Flexible(child: Container(), flex: 1),
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

  TextFieldInput buildTextFieldUsername() {
    return TextFieldInput(
      textEditingController: usernameController,
      hintText: "hint_texts_login_username".tr,
      textInputType: TextInputType.name,
      icon: Icon(Icons.person),
    );
  }

  SizedBox buildLoginNavigateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          animatePage(index: 0);
        },
        child: Text('buttons_login'.tr),

        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).disabledColor),
          elevation: MaterialStateProperty.all(0),
        ),
        // style: ElevatedButton.styleFrom(
        //   elevation: 0,
        // ),
      ),
    );
  }

  SizedBox buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          registerButton();
        },
        child: Text('buttons_sign_in'.tr),
      ),
    );
  }

  SizedBox buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          loginButton();
        },
        child: Text('buttons_login'.tr),
        // style: ElevatedButton.styleFrom(
        //   elevation: 0,
        // ),
      ),
    );
  }

  SizedBox buildRegisterNavigateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          animatePage(index: 1);
        },
        child: Text('buttons_sign_in'.tr),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).disabledColor),
          elevation: MaterialStateProperty.all(0),
        ),
        // style: ElevatedButton.styleFrom(
        //   elevation: 0,
        // ),
      ),
    );
  }

  TextFieldInput buildTextFieldPassword() {
    return TextFieldInput(
      textEditingController: passwordController,
      hintText: "hint_texts_login_password".tr,
      textInputType: TextInputType.visiblePassword,
      isPass: true,
      icon: Icon(Icons.lock),
    );
  }

  TextFieldInput buildTextFieldMail() {
    return TextFieldInput(
      textEditingController: emailController,
      hintText: "hint_texts_login_email".tr,
      textInputType: TextInputType.emailAddress,
      icon: Icon(Icons.email),
    );
  }
}
