// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPBean _$OTPBeanFromJson(Map<String, dynamic> json) => OTPBean(
      status: json['status'],
      oathToken: json['oath_token'] as String?,
      corporateHrID: json['corporate_hr_id'] as String?,
      msg: json['msg'] as String?,
      userModel: json['user_details'] == null
          ? null
          : OtpUserModel.fromJson(json['user_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OTPBeanToJson(OTPBean instance) => <String, dynamic>{
      'status': instance.status,
      'oath_token': instance.oathToken,
      'corporate_hr_id': instance.corporateHrID,
      'msg': instance.msg,
      'user_details': instance.userModel,
    };

OTPRequestModel _$OTPRequestModelFromJson(Map<String, dynamic> json) =>
    OTPRequestModel(
      mobile: json['mobile'] as String?,
      otp: json['otp'] as String?,
      device_id: json['device_id'] as String?,
    );

Map<String, dynamic> _$OTPRequestModelToJson(OTPRequestModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'otp': instance.otp,
      'device_id': instance.device_id,
    };
