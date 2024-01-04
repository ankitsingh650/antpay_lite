import 'dart:convert';
import 'dart:io';

import 'package:antpay_lite/repository/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/device/info_model.dart';
import '../../model/login/fetch_user_model.dart';
import '../../model/login/login_model.dart';
import '../../model/login/user_model.dart';
import '../../model/login/user_name_model.dart';
import '../../preferences/session_ manager.dart';
import '../../provider/DioProvider.dart';
import '../../repository/common/common_api_repo.dart';
import '../../repository/login/login_repository.dart';
import '../../utils/common_utils.dart';
import '../../utils/routes/routes_name.dart';

class LoginViewModel with ChangeNotifier {
  final _loginRepo = LoginRepository();
  bool _loading = false;
  CommonApiRepo repoClass = CommonApiRepo();

  bool get loading => _loading;

  final loginDetail = LoginModel();
  final DeviceInfoModel deviceInfoModel = DeviceInfoModel();

  late Map userData;
  late UserModel userResponse;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    setLoading(true);

    userData = setDataFields(loginDetail);
    _loginRepo.loginUser(jsonEncode(userData)).then((value) {
      setLoading(false);
      print(value.toString());
      saveUserPrefs(value);
      print("hello::: ${userResponse.data?.imeiNo.toString()}");
      if (userResponse.status.toString() == '1') {
        print('flow chk success');
        Navigator.pushReplacementNamed(context, RoutesName.verify);
      } else {
        print('flow chk failure');
        // CommonUtils.showSnackBar(userResponse.msg.toString());
      }

      print(
          "check data: \nname: ${loginDetail.name}\number: ${loginDetail.number}\nDevice in: ${loginDetail.deviceInfo?.imeiNumber}");
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
    });
  }

  /* submit(String msg, BuildContext context) {
    _loginRepo.testSubmit(msg, context);
    CommonUtils.showSnackBar(
        'name: ${loginDetail.name}\nNumber: ${loginDetail.number}', context);
  }*/

  Map setDataFields(LoginModel loginDetail) {
    Map data = {
      'name': loginDetail.name,
      'mobile': loginDetail.number,
      'firebaseToken': loginDetail.fbToken,
      'ipAddress': loginDetail.deviceInfo?.ipAddress,
      'latitude': loginDetail.deviceInfo?.currentPosition.latitude.toString(),
      'longitude': loginDetail.deviceInfo?.currentPosition.latitude.toString(),
      'location': "",
      'os': "",
      'imeiNo': loginDetail.deviceInfo?.imeiNumber.toString(),
      'referralCode': "null",
      'versionName': loginDetail.deviceInfo?.packageInfo.version.toString(),
      'versionNumber':
          loginDetail.deviceInfo?.packageInfo.buildNumber.toString(),
      'modelName': (Platform.isAndroid)
          ? loginDetail.deviceInfo?.phoneInfo.manufacturer.toString()
          : loginDetail.deviceInfo?.phoneInfo.name.toString(),
      'modelNo': loginDetail.deviceInfo?.phoneInfo.model.toString()
    };
    return data;
  }

  Future<void> saveUserPrefs(value) async {
    userResponse = UserModel.fromJson(value);
    final SharedPreferences userPref = await SharedPreferences.getInstance();
    if (userResponse.status.toString() == '1') {
      print('save user');
      userPref.setString('user_phone', loginDetail.number!);
      userPref.setString('user_fname', loginDetail.name!);
      SessionManager().addMobile(loginDetail.number!);
      SessionManager().addUserName(loginDetail.name!);
      // print(SessionManager().getUserName());
    }
  }

  Future<String?> fetchMerchantName(String enteredNumber) async {
    String? fetchUserName = "";
    setLoading(true);

    UsernameRequest req = UsernameRequest(mobile: enteredNumber);
    UsernameResponse response = await repoClass.apiClient.getUsername(req);

    print('User Response:\nStatus: \nfname: ${response.fname}');

    fetchUserName = "${response.fname} ${response.lname}";

    setLoading(false);

    print('fetchuser: $fetchUserName');
    return fetchUserName;
  }

  String setUserDetails(value) {
    FetchUserModel fetchUserModel = FetchUserModel.fromJson(value);
    String foundUser = "";
    if (fetchUserModel.status.toString() == "1") {
      print("${fetchUserModel.fname} ${fetchUserModel.lname}");
      foundUser = "${fetchUserModel.fname} ${fetchUserModel.lname}";
    }
    return foundUser;
  }
}
