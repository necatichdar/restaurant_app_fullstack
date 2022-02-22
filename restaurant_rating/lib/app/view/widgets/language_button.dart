import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_rating/app/controller/local_manager.dart';
import 'package:restaurant_rating/core/consts.dart';

class PopupButton extends StatelessWidget {
  const PopupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        switch (result) {
          case 'Türkçe':
            Get.find<LocaleManager>().changeLocale("tr_TR");
            break;
          case 'English':
            Get.find<LocaleManager>().changeLocale("en_US");
            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) =>
          Constants.instance.languages.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
