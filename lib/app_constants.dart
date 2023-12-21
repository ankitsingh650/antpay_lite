import 'package:flutter/material.dart';

class AppConstant {

  static const appName=  'antpay_lite';



  static const Color colorPrimary = Color(0xEA5436AD);
  static const Color colorPrimaryDark = Color(0xFF432B8A);

  static const Color colorBg = Color(0x2C7566AD);
  static const Color colorText = Color(0xBB282828);

  static const bool showDebugLabel = false;

  static const String fontBold = 'lato_bold';
  static const String fontMedium = 'lato_medium';
  static const String fontNormal = 'lato';

  static const String gblRedirectUrl = 'https://moneymentor.optshine.com/';

  static bool isValidEmail(String email) {
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password){
    RegExp passRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passRegExp.hasMatch(password);
  }

}
