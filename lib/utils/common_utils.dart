

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../views/web_view.dart';

class CommonUtils {

  static showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        //add futher toast properties below:
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG
    );
  }

  static showSnackBar(String message, BuildContext context){

    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message)
        )
    );
  }

  static toColor(String hexColor)
  {
    hexColor=hexColor.toUpperCase().replaceAll("#", "");
    if(hexColor.length==6)
    {
      hexColor="FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static fieldFocusChanged(BuildContext context, FocusNode current, FocusNode next){

    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static void openPolicyView(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PolicyWebView(url)));
  }

  static void showFlushBar(String message, BuildContext context){

    showFlushbar(context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.all(2),
          reverseAnimationCurve: Curves.easeInOut,
          message: message,
          backgroundColor: Colors.red,
          title: 'ERROR',
          messageColor: Colors.black,
          duration: Duration(seconds: 3),
          // icon: Icon(Icon.error),
        )..show(context)
    );
  }

}