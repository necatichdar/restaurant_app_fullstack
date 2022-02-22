import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension MediaQueryExtension on BuildContext {
  double get height => Get.height;

  double get width => Get.width;

  double get veryLowValue => height * 0.006; //5

  double get lowValue => height * 0.0125; //10

  double get lowMediumValue => height * 0.0185; //15

  double get normalValue => height * 0.0245; //--

  double get normalMediumValue => height * 0.03; //--

  double get mediumValue => height * 0.0245; //20

  double get highValue => height * 0.0307; //25

  double get veryHighValue => height * 0.037; //30

  double get wlowValue => width * 0.013; //5

  double get wmediumValue => width * 0.026; //10

  double get whighValue => width * 0.053; //20

}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow =>
      EdgeInsets.symmetric(horizontal: wlowValue, vertical: veryLowValue); //5

  EdgeInsets get paddingLowMedium => EdgeInsets.all(lowMediumValue); //--

  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);

  EdgeInsets get paddingMedium =>
      EdgeInsets.symmetric(horizontal: wmediumValue, vertical: lowValue); //10

  EdgeInsets get paddingMediumHigh => EdgeInsets.all(veryHighValue);

  EdgeInsets get paddingHigh =>
      EdgeInsets.symmetric(horizontal: whighValue, vertical: mediumValue); //20
}

extension PaddingExtensionSymetric on BuildContext {
  ///vertical:

  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);

  EdgeInsets get paddingLowMediumVertical =>
      EdgeInsets.symmetric(vertical: lowMediumValue);

  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);

  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);

  EdgeInsets get paddingMediumHighVertical =>
      EdgeInsets.symmetric(vertical: veryHighValue);

  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  ///Horizontol:

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: wlowValue);

  EdgeInsets get paddingLowMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: lowMediumValue);

  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);

  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: wmediumValue);

  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: whighValue);
}

extension BoxDecorationExtension on BuildContext {
  double get radiusLow => 4;

  double get radiusNormal => 8;

  double get radiusMedium => 16;

  double get radiusHigh => 32;

  BorderRadius get containerBorderRadiusLow => BorderRadius.circular(radiusLow);

  BorderRadius get containerBorderRadiusNormal =>
      BorderRadius.circular(radiusNormal);

  BorderRadius get containerBorderRadiusMedium =>
      BorderRadius.circular(radiusMedium);

  BorderRadius get containerBorderRadiusHigh =>
      BorderRadius.circular(radiusHigh);

  RoundedRectangleBorder get lowCircularBorder =>
      RoundedRectangleBorder(borderRadius: containerBorderRadiusLow);

  RoundedRectangleBorder get normalCircularBorder =>
      RoundedRectangleBorder(borderRadius: containerBorderRadiusMedium);

  RoundedRectangleBorder get highCircularBorder =>
      RoundedRectangleBorder(borderRadius: containerBorderRadiusHigh);

  List<BoxShadow> get customBoxShadowGrey => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 4,
          offset: Offset(0, 4),
        ),
      ];

  List<BoxShadow> get customBoxShadowBlue => [
        BoxShadow(
          color: Color(0xFF2a3747).withOpacity(0.20),
          blurRadius: 12,
          spreadRadius: 0,
          offset: Offset(0, 4), // changes position of shadow
        ),
      ];

  Radius get circularRadiusLow => Radius.circular(radiusLow);

  Radius get circularRadiusNormal => Radius.circular(radiusNormal);
}

extension EmptyWidget on BuildContext {
  Widget get emptylowWidget => SizedBox(height: lowValue);

  Widget get emptyNormalWidget => SizedBox(height: normalValue);

  Widget get emptyMediumWidget => SizedBox(height: mediumValue);
}
