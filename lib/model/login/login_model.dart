import '../device/device_model.dart';

class LoginModel {
  String? name;
  String? number;
  String? fbToken;
  DeviceModel? deviceInfo;

  LoginModel({this.name, this.number, this.fbToken, this.deviceInfo});
}
