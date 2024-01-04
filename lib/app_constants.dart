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

  static const String disclaimerText = 'Disclaimer - I hereby confirm that I have voluntarily submitted the copy of my Aadhaar card/e-Aadhaar/masked Aadhaar/Aadhaar XML to YES Bank Limited. I further give my consent to YES Bank to use my Aadhaar number and/or other information contained in the Aadhaar card (“Aadhaar Information”) to establish my identity for availing banking services. I have no objection for YES Bank to conduct offline verification of my Aadhaar Information or to share the same with UIDAI for facilitating Aadhaar based authentication and to obtain my demographic information. I have been informed by YES Bank about other alternative options available for me to establish my identity.';

  static bool isValidEmail(String email) {
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password){
    RegExp passRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passRegExp.hasMatch(password);
  }

}
