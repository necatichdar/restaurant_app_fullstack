import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleManager extends GetxController {
  static LocaleManager get to => Get.find();

  final box = GetStorage();
  String get isLocale => box.read('locale') ?? "en_US";
  String get isDeeplink => box.read('deeplink') ?? "";
  Locale get locale => Locale(isLocale);
  void changeLocale(String val) =>
      {Get.updateLocale(Locale(val)), box.write('locale', val)};

  void changeDeeplinkParameter(String val) => {box.write('deeplink', val)};
}
