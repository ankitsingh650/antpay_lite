

import 'dart:convert';
import 'dart:io';


 import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/device/info_model.dart';
import '../../model/login/login_model.dart';
import '../../model/login/user_model.dart';
import '../../model/otp/otp_model.dart';
import '../../model/otp/otp_user_model.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/otp_api_repo.dart';
import '../../repository/otp_repository.dart';
import '../../utils/common_utils.dart';

class OtpVerifyViewModel with ChangeNotifier{

  final _otpRepo=OtpRepository();
  bool _loading=false;
  bool _restartTimer=false;

  bool get loading =>_loading;
  bool get timer =>_restartTimer;

  final DeviceInfoModel deviceInfoModel=DeviceInfoModel();
  final loginDetail=LoginModel();

  late Map userData;
  late UserModel userResponse;

  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }
  setTimer(bool value){
    _restartTimer=value;
    notifyListeners();
  }

  Future<void> resendOtp(BuildContext context)async {

    setLoading(true);
    setTimer(true);
    userData=setDataFields(loginDetail);
    _otpRepo.resendOtp(jsonEncode(userData)).then((value){
      setLoading(false);
      resetTimer(value);
      print(value.toString());
    }).onError((error, stackTrace){
      setLoading(false);
      print(error.toString());
    });
  }

  Map setDataFields(LoginModel loginDetail) {

    Map data= {
      'name' : loginDetail.name,
      'mobile': loginDetail.number,
      'firebaseToken' :  loginDetail.fbToken,
      'ipAddress' : loginDetail.deviceInfo?.ipAddress,
      'latitude' : loginDetail.deviceInfo?.currentPosition.latitude.toString(),
      'longitude' : loginDetail.deviceInfo?.currentPosition.latitude.toString(),
      'location' : "",
      'os' : "",
      'imeiNo' : loginDetail.deviceInfo?.imeiNumber.toString(),
      'referralCode' : "null",
      'versionName' : loginDetail.deviceInfo?.packageInfo.version.toString(),
      'versionNumber' : loginDetail.deviceInfo?.packageInfo.buildNumber.toString(),
      'modelName' : (Platform.isAndroid)?loginDetail.deviceInfo?.phoneInfo.manufacturer.toString():loginDetail.deviceInfo?.phoneInfo.name.toString(),
      'modelNo' : loginDetail.deviceInfo?.phoneInfo.model.toString()
    };
    return data;
  }

  void resetTimer(value) {
    userResponse=UserModel.fromJson(value);
    if(userResponse.status.toString()=='1'){
      setTimer(true);
      // print(SessionManager().getUserName());
    }
  }

  Future<String> verifyOTP(String userMobile, String enteredOTP) async {
    String navigateTo="";
    OtpApiRepo repoClass = OtpApiRepo();
    OTPBean response= await repoClass.verifyOTP(userMobile, enteredOTP);
    print("response print check: ${response.status}:  ${response.msg}: ${response.oathToken}: ${response.userModel?.name}");
    if(response.status.toString()=='1'){

      // add token in SessionManager
      SessionManager().addToken(response.oathToken.toString());
      SessionManager().addCorporateID(response.corporateHrID.toString());
      print('alpha corporate:${response.corporateHrID.toString()}');
      // SessionManager().getToken().toString()
      OtpUserModel? currUser=response.userModel;
      if(currUser!=null){
        SessionManager().createLoginSession(
            currUser.name ?? "",
            currUser.email ?? "",
            currUser.maritalStatus ?? "",
            currUser.dob ?? "",
            currUser.gender ?? "",
            currUser.occupation ?? "",
            currUser.education ?? "",
            currUser.income ?? "",
            currUser.investInEquityMarketFlag ?? "",
            currUser.ownHouseMotorFlag ?? "");
        
        SessionManager().setAutofillData(
            currUser.name ?? "",
            currUser.gender ?? "",
            currUser.dob ?? "",
            "",
            "",
            "",
            "",
            currUser.email ?? "",
            SessionManager().getMobile().toString(), "", "", "", "", "", "");
      }

      if(false){
        //add if conditon to start for navigation
        //intent calling next activity

        navigateTo="Pin_set_reset";
      }
      else{

        final SharedPreferences sp=await SharedPreferences.getInstance();
        sp.setString('tkntkn', response.oathToken.toString());
        sp.setString('FirebaseToken', response.oathToken.toString());
        sp.setString('first_run', '0.5');

        //Basic Profile Detail navigation intent
        navigateTo="Profile_page";

      }

    }
    else{
        CommonUtils.showToast(response.msg.toString());
    }

    setLoading(false);
    return navigateTo;
  }


}