import 'package:json_annotation/json_annotation.dart';
import 'otp_user_model.dart';

part 'otp_model.g.dart';

//verify otp response class
@JsonSerializable()
class OTPBean {
  OTPBean({
    this.status,
    this.oathToken,
    this.corporateHrID,
    this.msg,
    this.userModel,
  });

  @JsonKey(name: 'status')
  dynamic status;

  @JsonKey(name: 'oath_token')
  String? oathToken;

  @JsonKey(name: 'corporate_hr_id')
  String? corporateHrID;

  @JsonKey(name: 'msg')
  String? msg;

  @JsonKey(name: 'user_details')
  OtpUserModel? userModel;

  factory OTPBean.fromJson(Map<String, dynamic> json) =>
      _$OTPBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OTPBeanToJson(this);
}

//verify otp POST body class
@JsonSerializable()
class OTPRequestModel {
  @JsonKey(name: 'mobile')
  String? mobile;

  @JsonKey(name: 'otp')
  String? otp;

  @JsonKey(name: 'device_id')
  String? device_id;

  OTPRequestModel({this.mobile, this.otp, this.device_id});

  factory OTPRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OTPRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OTPRequestModelToJson(this);
}
