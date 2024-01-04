// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PanKYCResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanKYCResponseModel _$PanKYCResponseModelFromJson(Map<String, dynamic> json) =>
    PanKYCResponseModel(
      code: json['code'] as String?,
      statusCode: json['status_code'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PanKYCResponseModelToJson(
        PanKYCResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status_code': instance.statusCode,
      'mobile_number': instance.mobileNumber,
      'message': instance.message,
    };
