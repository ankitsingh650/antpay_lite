import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/login/login_view_model.dart';
import '../../model/device/device_information.dart';
import '../../res/color_palette.dart';
import '../../utils/common_utils.dart';
import '../../utils/custom_shape.dart';
import '../../utils/routes/routes_name.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final _myFormKey = GlobalKey<FormState>();

  late TapGestureRecognizer _tapGestureRecogniserTC;
  late TapGestureRecognizer _tapGestureRecogniserPolicy;

  // late final FlutterGifController gifController;

  String? mtoken = " ";
  bool fieldsEnabled = true;
  late final deviceInfoSingleton;

   late var loginViewModel;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  var _firebaseToken = '';

  FocusNode phoneFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();

  String username = '';

  //NotificationServices notificationServices=NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.getToken().then((value) {
      _firebaseToken = value!;
    });
    /*  notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.isTokenRefresh();
    notificationServices.getFCMToken().then((token) {
      setState(() {
        mtoken = token;
        print('Device Token: ${token}');
      });
    });*/
    getToken();
     deviceInfoSingleton = DeviceInfoSingleton();
    //  gifController= FlutterGifController(vsync: this);

    _tapGestureRecogniserTC = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          print("T&Cs");
            CommonUtils.openPolicyView(
              context, 'https://www.antworksmoney.com/Terms_and_condition');
        });
      };

    _tapGestureRecogniserPolicy = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          print("Policy");
           CommonUtils.openPolicyView(
              context, 'https://www.antworksmoney.com/privacy-policy');
        });
      };

    phone.addListener(afterTextChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tapGestureRecogniserTC.dispose();
    _tapGestureRecogniserPolicy.dispose();
  }

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
      loginViewModel = Provider.of<LoginViewModel>(context);

    bool? isChecked = true;
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
                    height: 46,
                    width: 150,
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
                  key: _myFormKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Text(
                        "Sign Up/Sign In",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CommonUtils.toColor("#000000")),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 45,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CommonUtils.toColor("#09466d")),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "+91",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[22]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 130,
                              child: TextField(
                                controller: phone,
                                focusNode: phoneFocusNode,
                                onChanged: (mobileNumber) async {
                                  // Fetch and update username when mobile number changes
                                  if (mobileNumber.length == 10) {
                                   //  _loadUsername(mobileNumber);

                                    String? responseName= await loginViewModel.fetchMerchantName(phone.text.toString());
                                    if(responseName!=null && responseName!="" && responseName!=" "){
                                      setState(() {
                                        fieldsEnabled=false;
                                        username=responseName.toString();
                                        name.text=getMaskedName(responseName.toString());
                                        print(getMaskedName(name.text));
                                      });
                                      phoneFocusNode.unfocus();

                                      print('Field Enabled!');
                                    }
                                    else{
                                      print('record not found!');
                                      setState(() {
                                        fieldsEnabled=true;
                                        name.text='';
                                      });
                                      CommonUtils.fieldFocusChanged(context, phoneFocusNode, nameFocusNode);
                                    }

                                  }
                                },


                               /* onFieldSubmitted: (value) {
                                  CommonUtils.fieldFocusChanged(
                                      context, phoneFocusNode, nameFocusNode);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter your Phone";
                                  }
                                  if (value.length != 10) {
                                    return "Invalid Phone";
                                  }
                                  return null;
                                },*/
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.justify,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    hintText: "Enter Your Mobile Number",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(5.0),
                                      gapPadding: 0.5,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(5.0),
                                      gapPadding: 0.5,
                                    ),
                                    errorStyle: TextStyle(
                                      height: 0.09,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                    )),
                                textAlignVertical: TextAlignVertical.bottom,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: name,
                                focusNode: nameFocusNode,
                                enabled: fieldsEnabled,
                                onChanged: (newValue) {
                                  setState(() => username = newValue);
                                  print('on changed: $username');
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter your Name";
                                  }
                                  if (value.length < 3) {
                                    return "Name too short";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Enter Name",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(5.0),
                                      gapPadding: 0.5,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(5.0),
                                      gapPadding: 0.5,
                                    ),
                                    errorStyle: TextStyle(
                                      height: 0.09,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 15),
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                    )),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                keyboardType: TextInputType.text,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Checkbox(
                                  focusColor: Colors.lightBlue,
                                  activeColor: ColorPalette.agreementTextColor,
                                  value: isChecked,
                                  onChanged: (newValue) {
                                    setState(() => isChecked = newValue);
                                  });
                            }),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "I Agree to ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  children: [
                                    TextSpan(
                                      recognizer: _tapGestureRecogniserTC,
                                      text: "Terms of use",
                                      style: TextStyle(
                                          color:
                                              ColorPalette.agreementTextColor,
                                          fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: " | ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    TextSpan(
                                      recognizer: _tapGestureRecogniserPolicy,
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                          color:
                                              ColorPalette.agreementTextColor,
                                          fontSize: 12),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90)),
                        child: ElevatedButton(
                          onPressed: () async {
                               if (_myFormKey.currentState!.validate()) {
                              print("valid");
                              if (isChecked == true) {
                                loginViewModel.setLoading(true);
                                final deviceModel =
                                    await deviceInfoSingleton.createDeviceModel();


                                print("Api has hit");
                                print('Username: $username');
                                loginViewModel.loginDetail.name=username;//name.text.toString();
                                loginViewModel.loginDetail.number=phone.text.toString();
                                loginViewModel.loginDetail.fbToken = _firebaseToken;
                                loginViewModel.loginDetail.deviceInfo = deviceModel;
                                 // loginViewModel.loginDetail.setDeviceInformation();
                                loginViewModel.loginUser(context);
                                // SessionManager().addMobile("1234567890");
                                print('OTP SEND');
                                // Navigator.pushNamed(context, RoutesName.verify);
                              }
                              else{
                               // CommonUtils.showFlushBar("Please Accept the Terms & Conditions", context);
                              }
                            }
                          },
                          child: Text(
                            "SEND OTP",
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
                      )
                    ],
                  ),
                ),
              )),
          if(loginViewModel.loading)
          Center(
            child: Image(
              image: const AssetImage('assets/images/loader_image.gif'),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.10,
              // controller: gifController,
            ),
          )
          // Positioned(
          //     top: 300,
          //     child: Container(
          //       margin: EdgeInsets.only(top: 20),
          //       child: ElevatedButton(
          //         onPressed: () async {
          //           final deviceModel =
          //               await deviceInfoSingleton.createDeviceModel();
          //           Map data = {
          //             'name': 'Faraz',
          //             'mobile': "8076266458",
          //             'firebaseToken': mtoken,
          //             'ipAddress': '192.22.31.45',
          //             'latitude': "",
          //             'longitude': "",
          //             'location': "",
          //             'os': "",
          //             'imeiNo': '1762864832',
          //             'referralCode': "null",
          //             'versionName': '1.0',
          //             'versionNumber': '1',
          //             'modelName': 'Samsung',
          //             'modelNo': '19008723'
          //           };
          //
          //           jsonEncode(data);
          //
          //           print("Api has hit: ${data.toString()}");
          //           loginViewModel.loginDetail.name=name.text.toString();
          //           loginViewModel.loginDetail.number=phone.text.toString();
          //           loginViewModel.loginDetail.fbToken = mtoken;
          //           loginViewModel.loginDetail.deviceInfo = deviceModel;
          //           // loginViewModel.loginDetail.setDeviceInformation();
          //           loginViewModel.loginUser(jsonEncode(data), context);
          //           // loginViewModel.loginDetail.deviceInfo=loginViewModel.setDeviceInformation() ;
          //         },
          //         child: Text(
          //           "POST API",
          //           style: TextStyle(
          //               color: ColorPalette.getOTPText,
          //               fontWeight: FontWeight.bold,
          //               fontSize: 16),
          //         ),
          //         style: ButtonStyle(backgroundColor:
          //             MaterialStateProperty.resolveWith((states) {
          //           if (states.contains(MaterialState.pressed)) {
          //             return ColorPalette.getOTPButton;
          //           }
          //           return ColorPalette.getOTPButton;
          //         })),
          //       ),
          //     ))
        ],
      ),
    );
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('Generated Token is:$mtoken');
      });
    });
  }

  void afterTextChanged() async {
/*    if(phone.text.length==10){
      print('number ready');

      String? responseName= await loginViewModel.fetchMerchantName(phone.text.toString());
      if(responseName!=null && responseName!="" && responseName!=" "){
        setState(() {
          fieldsEnabled=false;
          username=responseName.toString();
          name.text=getMaskedName(responseName.toString());
          print(getMaskedName(name.text));
        });
        phoneFocusNode.unfocus();

        print('Field Enabled!');
      }
      else{
        print('record not found!');
        setState(() {
          fieldsEnabled=true;
          name.text='';
        });
        CommonUtils.fieldFocusChanged(context, phoneFocusNode, nameFocusNode);
      }


      // loginViewModel.fetchUserName(phone.text.toString()).then( (value){
      //   print('field value: ${value.toString()}');
      //   if(value!=null && value!=""){
      //     fieldsEnabled=false;
      //     name.text=value.toString().toUpperCase();
      //     print('Field Enabled!');
      //   }
      //   else{
      //     print('record not found!');
      //     fieldsEnabled=true;
      //     name.text='';
      //
      //   }
      // });
    }*/
  }

/*  void _loadUsername(String mobileNumber) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$mobileNumber'));

      if (response.statusCode == 200) {
        // Parse the response and update the UI
        final Map<String, dynamic> data = json.decode(response.body);
        final String username = data['username'];

        setState(() {
          _username = username;
        });
      } else {
        // Handle error
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }*/


  String getMaskedName(String name) {
    if (name.toString().length == 0) {
      return '';
    }
    final firstCharacter = name[0];
    final lastCharacter = name[name.length - 1];
    final middleCharacters = name.substring(1, name.length - 1);

    // Create an obscured version of the middle characters.
    final obscuredMiddle = '*' * middleCharacters.length;

    // Concatenate the first, obscured middle, and last characters.
    final obscuredText = '$firstCharacter$obscuredMiddle$lastCharacter';

    return obscuredText;
  }
}
