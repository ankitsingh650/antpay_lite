import 'package:another_flushbar/flushbar_route.dart';
import 'package:antpay_lite/model/wallet/RegUserRequestModel.dart';
import 'package:antpay_lite/model/wallet/RegUserResponseModel.dart';
import 'package:antpay_lite/model/wallet/RegUserVerifyRequestModel.dart';
import 'package:antpay_lite/res/color_palette.dart';
import 'package:antpay_lite/utils/common_utils.dart';
import 'package:antpay_lite/views/wallet/MinKyc.dart';
import 'package:flutter/material.dart';
import '../../data/retrofit/auth.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';
import '../../utils/widgets/reusables.dart';
import '../../utils/widgets/stateless_reusables.dart';

class MinVerifyMobile extends StatefulWidget {
  const MinVerifyMobile({Key? key}) : super(key: key);

  @override
  State<MinVerifyMobile> createState() => _MinVerifyMobileState();
}

class _MinVerifyMobileState extends State<MinVerifyMobile> {
  TextEditingController phone = TextEditingController();

  bool isVisibleOTP = false;
  late final TextEditingController key1, key2, key3, key4, key5, key6;
  var otpRefno = '';

  @override
  void initState() {
    key1 = TextEditingController();
    key2 = TextEditingController();
    key3 = TextEditingController();
    key4 = TextEditingController();
    key5 = TextEditingController();
    key6 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorPalette.white,
        title: Text('Min Ac Kyc'),
      ),
      backgroundColor: ColorPalette.blueBackgroundColor,
      // Change the background color accordingly
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/profileicon1.png',
                    // Add the path to your image
                    width: double.infinity,
                    height: 100.0,
                    fit: BoxFit.contain,
                  ),
                  Visibility(
                    //visible: widget.isVisibleOTP,
                    child: !isVisibleOTP
                        ? Card(
                            elevation: 2,
                            color: ColorPalette.white,
                            surfaceTintColor: ColorPalette.white,
                            margin: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/profile_ant_hand.png',
                                  // Add the path to your image
                                  width: 100.0,
                                  fit: BoxFit.contain,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          bottom: 20.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Mobile Number kyc',
                                            style: TextStyle(
                                              fontSize: 21.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Text(
                                              'Please verify mobile number for activation of'),
                                          Row(
                                            children: [
                                              Text(
                                                'Mini Account',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          HeaderAlignText(
                                              headerText: "Mobile Number"),
                                          SizedBox(
                                            height: 40,
                                            // width: MediaQuery.of(context).size.width - 130,
                                            child: TextField(
                                              controller: phone,
                                              // focusNode: phoneFocusNode,
                                              // Fetch and update username when mobile number changes

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
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.justify,

                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Enter Your Mobile Number",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    gapPadding: 0.5,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    gapPadding: 0.5,
                                                  ),
                                                  errorStyle: TextStyle(
                                                    height: 0.09,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  hintStyle: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                              textAlignVertical:
                                                  TextAlignVertical.bottom,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (phone.text.length == 10) {
                                                minsendOtp(phone.text);
                                              }

                                              /*  Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => MinKycScreen()));*/

                                              // Add your button click logic
                                            },
                                            child: Text('Submit'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Card(
                            elevation: 2,
                            color: ColorPalette.white,
                            surfaceTintColor: ColorPalette.white,
                            margin: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/profile_ant_hand.png',
                                  // Add the path to your image
                                  width: 100.0,
                                  fit: BoxFit.contain,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Text(
                                            'ConfirmOTP',
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text('Enter OTP sent to mobile'),
                                          Text(
                                            '+91 99XXXXXX99',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              otpInputField(key1, context),
                                              otpInputField(key2, context),
                                              otpInputField(key3, context),
                                              otpInputField(key4, context),
                                              otpInputField(key5, context),
                                              otpInputField(key6, context),
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            'Secs',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              verifymOtp(phone.text);

                                              // Add your button click logic
                                            },
                                            child: Text('Verify OTP'),
                                          ),
                                          Text(
                                            'Didn\'t receive OTP? Try again',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  )

                  /*  GifImage.asset(
                    'assets/loader_image.gif', // Add the path to your gif
                    width: 100.0,
                    height: 80.0,
                    fit: BoxFit.contain,
                    hideOverlay: true,
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  void minsendOtp(String mobileNumber) async {
    CommonApiRepo repoClass = CommonApiRepo();
    RegUserRequestModel request =
        RegUserRequestModel(actionName: 'REGUSER', p1: mobileNumber, p2: 'Y');

    RegUserResponseModel response;

    response = await repoClass.apiClient.regUserMobile(AuthToken.getAuthToken(),
        SessionManager().getToken().toString(), request);

    if (response.statusCode != null) {
      print('Response:${response.message}');

      if (response.statusCode == "SUCCESS") {
        setState(() {
          otpRefno = response.otpRefNumber.toString();
          isVisibleOTP = true;
        });
      } else {
        CommonUtils.showToast(response.message.toString());
      }
    } else {
      //handle if not registered as seller
    }
  }

  void verifymOtp(String mobile) async {
    // otpVerifyViewModel.setLoading(true);
    String otp =
        '${key1.text}${key2.text}${key3.text}${key4.text}${key5.text}${key6.text}';

    RegUserVerifyRequestModel request = RegUserVerifyRequestModel(
        actionName: 'VERIFYMOTP', p1: mobile, p2: otpRefno, p3: otp);
    String number = SessionManager().getMobile().toString();
    RegUserResponseModel response = await CommonApiRepo().apiClient.mOtpVerify(
        AuthToken.getAuthToken(),
        SessionManager().getToken().toString(),
        request);
    print('no: $number\notp: $otp :$response');

    if (response.statusCode != null) {
      print('Response:${response.message}');

      if (response.statusCode == "SUCCESS") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MinKycScreen()));
      } else {
        CommonUtils.showToast("Something went wrong");
      }
    } else {
      //handle if not registered as seller
    }
  }
}
