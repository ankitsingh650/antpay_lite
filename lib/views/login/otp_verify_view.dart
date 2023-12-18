import 'dart:async';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/login/otp_verify_view_model.dart';
import '../../model/device/device_information.dart';
import '../../preferences/session_ manager.dart';
import '../../res/color_palette.dart';
import '../../utils/common_utils.dart';
import '../../utils/custom_shape.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/widgets/reusables.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({Key? key}) : super(key: key);

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView>
    with TickerProviderStateMixin {
  int _remainingTime = 120;
  String _showTime = "";
  String? mtoken = " ";
  bool resend = false;
  late Timer _timer;
  late final deviceInfoSingleton;
  late var otpVerifyViewModel;

  late final FlutterGifController gifController;
  late final TextEditingController key1, key2, key3, key4, key5, key6;

  @override
  void initState() {
    gifController = FlutterGifController(vsync: this);
    key1 = TextEditingController();
    key2 = TextEditingController();
    key3 = TextEditingController();
    key4 = TextEditingController();
    key5 = TextEditingController();
    key6 = TextEditingController();
    deviceInfoSingleton = DeviceInfoSingleton();
    _initTimer();
    getToken();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    gifController.dispose();
    key1.dispose();
    key2.dispose();
    key3.dispose();
    key4.dispose();
    key5.dispose();
    key6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    otpVerifyViewModel = Provider.of<OtpVerifyViewModel>(context);

    return Scaffold(
      backgroundColor: ColorPalette.iconColor,
      body: Stack(
        children: [
          const Positioned(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: MyCustomPainter(),
              child: SizedBox(
                width: double.infinity,
                height: 400,
              ),
            ),
          )),
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 220,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/antpay_logo.png'))),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: RichText(
                      text: TextSpan(
                          text:
                              "Experience New Age Financial Services at AntPay",
                          style: TextStyle(
                              fontSize: 12,
                              color: CommonUtils.toColor("#09466d"))),
                    ),
                  )
                ],
              )),
          Positioned(
              top: 250,
              child: Container(
                height: 380,
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 1),
                    ]),
                child: Form(
                  child: Column(
                    children: [
                      Text(
                        "Confirm OTP",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CommonUtils.toColor("#000000")),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Enter OTP sent to mobile number",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: CommonUtils.toColor("#6f6e6e")),
                      ),
                      Text(
                        "+91 ${SessionManager().getMobile().toString()}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: CommonUtils.toColor("#6f6e6e")),
                      ),
                      Text(
                        _showTime,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: resend
                                ? CommonUtils.toColor("#c1c1c1")
                                : Colors.redAccent),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       height: 68,
                      //       width: 32,
                      //       child: TextFormField(
                      //         onChanged: (value) {
                      //           if (value.length == 1) {
                      //             FocusScope.of(context).nextFocus();
                      //           }
                      //         },
                      //         style: Theme.of(context).textTheme.headlineMedium,
                      //         keyboardType: TextInputType.number,
                      //         textAlign: TextAlign.center,
                      //         inputFormatters: [
                      //           LengthLimitingTextInputFormatter(1),
                      //           FilteringTextInputFormatter.digitsOnly
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 68,
                      //       width: 32,
                      //       child: TextFormField(
                      //         onChanged: (value) {
                      //           if (value.length == 1) {
                      //             FocusScope.of(context).nextFocus();
                      //           }
                      //         },
                      //         style: Theme.of(context).textTheme.headlineMedium,
                      //         keyboardType: TextInputType.number,
                      //         textAlign: TextAlign.center,
                      //         inputFormatters: [
                      //           LengthLimitingTextInputFormatter(1),
                      //           FilteringTextInputFormatter.digitsOnly
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 68,
                      //       width: 32,
                      //       child: TextFormField(
                      //         onChanged: (value) {
                      //           if (value.length == 1) {
                      //             FocusScope.of(context).nextFocus();
                      //           }
                      //         },
                      //         style: Theme.of(context).textTheme.headlineMedium,
                      //         keyboardType: TextInputType.number,
                      //         textAlign: TextAlign.center,
                      //         inputFormatters: [
                      //           LengthLimitingTextInputFormatter(1),
                      //           FilteringTextInputFormatter.digitsOnly
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 68,
                      //       width: 32,
                      //       child: TextFormField(
                      //         onChanged: (value) {
                      //           if (value.length == 1) {
                      //             FocusScope.of(context).nextFocus();
                      //           }
                      //         },
                      //         style: Theme.of(context).textTheme.headlineMedium,
                      //         keyboardType: TextInputType.number,
                      //         textAlign: TextAlign.center,
                      //         inputFormatters: [
                      //           LengthLimitingTextInputFormatter(1),
                      //           FilteringTextInputFormatter.digitsOnly
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 68,
                      //       width: 32,
                      //       child: TextFormField(
                      //         onChanged: (value) {
                      //           if (value.length == 1) {
                      //             FocusScope.of(context).nextFocus();
                      //           }
                      //         },
                      //         style: Theme.of(context).textTheme.headlineMedium,
                      //         keyboardType: TextInputType.number,
                      //         textAlign: TextAlign.center,
                      //         inputFormatters: [
                      //           LengthLimitingTextInputFormatter(1),
                      //           FilteringTextInputFormatter.digitsOnly
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 68,
                      //       width: 32,
                      //       child: TextFormField(
                      //         onChanged: (value) {
                      //           if (value.length == 1) {
                      //             FocusScope.of(context).nextFocus();
                      //           }
                      //         },
                      //         style: Theme.of(context).textTheme.headlineMedium,
                      //         keyboardType: TextInputType.number,
                      //         textAlign: TextAlign.center,
                      //         inputFormatters: [
                      //           LengthLimitingTextInputFormatter(1),
                      //           FilteringTextInputFormatter.digitsOnly
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          otpInputField(key1, context),
                          otpInputField(key2, context),
                          otpInputField(key3, context),
                          otpInputField(key4, context),
                          otpInputField(key5, context),
                          otpInputField(key6, context),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90)),
                        child: ElevatedButton(
                          onPressed: otpVerifyViewModel.loading
                              ? null
                              : () {
                                  verify();
                                  // OtpApiRepo repoClass = OtpApiRepo();
                                  // repoClass.demoPost('8006034041', '741709');
                                },
                          child: Text(
                            "VERIFY OTP",
                            style: TextStyle(
                                color: ColorPalette.getOTPText,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return ColorPalette.getOTPButton;
                            }
                            return ColorPalette.getOTPButton;
                          })),
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: resend
                            ? () async {
                                final deviceModel = await deviceInfoSingleton
                                    .createDeviceModel();
                                otpVerifyViewModel.loginDetail.name =
                                    SessionManager().getUserName();
                                otpVerifyViewModel.loginDetail.number =
                                    SessionManager().getMobile();
                                otpVerifyViewModel.loginDetail.fbToken = mtoken;
                                otpVerifyViewModel.loginDetail.deviceInfo =
                                    deviceModel;
                                await otpVerifyViewModel.resendOtp(context);
                                setState(() {
                                  print("OTP Resent!");
                                  otpVerifyViewModel.setLoading(true);
                                  if (otpVerifyViewModel.timer) {
                                    print("reset");
                                    _remainingTime = 120;
                                    _initTimer();
                                    otpVerifyViewModel.setTimer(false);
                                  }
                                });
                              }
                            : null,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Didn't receive OTP? Resend ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: resend
                                  ? CommonUtils.toColor("#09466d")
                                  : CommonUtils.toColor("#c1c1c1"),
                            ),
                          ),
                        ),
                      ),
                      // RichText(
                      //   textAlign: TextAlign.center,
                      //   text: TextSpan(
                      //     text: "Didn't receive OTP? Resend ",
                      //     recognizer: _tapGestureRecognizerResend,
                      //     style: TextStyle(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w400,
                      //         color: CommonUtils.toColor("#09466d")),
                      //   ),
                      // ),
                      // Text(
                      //   "Didn't receive OTP? Resend",
                      //   style: TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w400,
                      //       color: CommonUtils.toColor("#09466d")),
                      // ),
                    ],
                  ),
                ),
              )),
          if (otpVerifyViewModel.loading)
            Center(
              child: Image(
                image: const AssetImage('assets/images/loader_image.gif'),
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.10,
                // controller: gifController,
              ),
            )
        ],
      ),
    );
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime >= 0) {
          _showTime = formatedTime(timeInSecond: _remainingTime--);
          // _remainingTime--;
          resend = false;
        } else {
          _timer.cancel();
          resend = true;
        }
      });
    });
  }

  String formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute Min $second Secs";
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('Generated Token is:$mtoken');
      });
    });
  }

  void verify() async {
    otpVerifyViewModel.setLoading(true);
    String otp =
        '${key1.text}${key2.text}${key3.text}${key4.text}${key5.text}${key6.text}';
    String number = SessionManager().getMobile().toString();
    String nextScreen = await otpVerifyViewModel.verifyOTP(number, otp);
    print('no: $number\notp: $otp :$nextScreen');
    if (nextScreen == 'Profile_page') {
       Navigator.pushNamed(context, RoutesName.dashboard);
      Map<String, dynamic> passScreenData = {
          'fromScreen': 'login',
        };
      Navigator.pushReplacementNamed(context, RoutesName.dashboard, arguments: passScreenData);
    }
  }
}
