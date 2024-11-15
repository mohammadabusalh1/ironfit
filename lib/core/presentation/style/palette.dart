import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Palette {
  static Color get scaffoldBackground => Get.theme.scaffoldBackgroundColor;

  static const Color mainAppColor = Color(0xffffbb02);
  static const Color mainAppColorBack = Color.fromARGB(255, 255, 208, 78);
  static const Color mainAppColorOrange = Color(0xffEB8317);
  static const Color mainAppColorNavy = Color(0xff10375C);
  static const Color mainAppColorWhite = Color(0xffF4F6FF);
  static const Color mainAppColorBorder = Color(0x60FFBB02);
  static const Color gray = Colors.grey;
  static const Color secondaryColor = Color(0xff454038);
  static const Color darkGray = Color(0xFF2E2E2E);
  static const Color lightGrey = Color(0xffEFF4F6);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff343a40);
  static const Color blackBack = Color.fromARGB(255, 24, 24, 24);
  static const Color darkBackground = Color(0xff101828);
  static const Color baseLight = Color(0xffD0D5DD);
  static const Color borderGrey = Color(0xffe2e5ea);
  static const Color subTitleGrey = Color(0xff98A2B3);
  static const Color baseSubtle = Color(0xffE5E6EB);
  static const Color suffixColor = Color(0xffAFAFAF);
  static const Color borderColor = Color(0xffE4E7EC);
  static const Color arrowColor = Color(0xff374957);
  static const Color blue = Color(0xff0BA5EC);
  static const Color lightBlue = Color(0xff5fccf3);
  static const Color lightBlue2 = Color(0xffa8e0f3);
  static const Color lightBlue3 = Color(0xffAAD8E2);
  static const Color darkBlue = Color(0xff026AA2);
  static const Color backgroundBlue = Color(0xffBCEBFB);
  static const Color cyan = Color(0xff35BBAD);
  static const Color darkCyan = Color(0xff207068);
  static const Color backgroundCyan = Color(0xffBFF5EF);
  static const Color success = Color(0xff0BA5EC);
  static const Color error = Color(0xfffd5633);
  static const Color warning = Color(0xfff88d36);
  static const Color darkTextFieldBackground = Color(0xff344054);
  static const Color lightTextFieldBackground = Color(0xffFCFCFD);
  static const Color accentCyan = Color(0xff35BBAD);
  static const Color accentRed = Color(0xffD5492B);
  static const Color chargeColor = Color(0xffF2F4F7);
  static const Color accentRed5 = Color(0xffFFC7BB);
  static const Color requestButton = Color(0xff026AA2);
  static const Color favColor = Color(0xffF9A000);
  static const Color ibanColor = Color(0xffD1F1FC);
  static const Color accentBlue3 = Color(0xff0BA5EC);
  static const Color accentBlue1 = Color(0xff0B4A6F);
  static const Color changeColor = Color(0xff0E4558);
  static const Color successBackground = Color(0xff0269a1);

  //IPS
  static const Color recallInfoBgColor = Color(0xffF1FCFF);
  static const Color recallInfoIconColor = Color(0xff2FA4BB);
  static const Color ipsGradientColor = Color(0xff35D4FB);
  static const Color ipsSuccessStatusColor = Color(0xffCAF2D9);
  static const Color ipsSuccessTextStatusColor = Color(0xff4FB576);
  static const Color ipsPendingStatusColor = Color(0xffFDD9BC);
  static const Color ipsPendingTextStatusColor = Color(0xffD0762D);
  static const Color ipsDirectionColor = Color(0xff578DF5);

  static const Color appBarGradient = Color(0xffe9f9fc);

  static const Color requestTabsBgColor = Color(0xff098ABB);
  static const Color cardColor = Color(0xff0BA1D6);
  static const Color unActiveSwitchColor = Color(0xffD8D8D8);
  static const Color disableGrey = Color(0xffF2F4F7);
  static const Color subTitleBlack = Color(0xFF444444);
  static const Color colseButtonBlack = Color(0xFF444440);
  static const Color greenActive = Color(0xff4FB576);
  static const Color redDelete = Color(0xffD5492B);
  static const Color orangeInactive = Color(0xffD0762D);
  static const Color redBackGround = Color(0xffFFC7BB);
  static const Color greenBackGround = Color(0xffCAF2D9);
  static const Color orangeBackGround = Color(0xffFDD9BC);
  static const Color ealbBlue = Color(0xffB7E8F9);

  //Web colors
  static const Color bodyWebLight = Color(0xffF5FBFF);
  static const Color bodyWebDark = Color(0xff1D2939);
  static const Color webDashboardWelcoming = Color(0xffbbe8f8);

  //getters
  static Color get primaryColor => Get.theme.primaryColor;

  static Color get textColor => Get.isDarkMode ? white : black;
  static Color get bodyWeb => Get.isDarkMode ? bodyWebLight : bodyWebLight;
}
