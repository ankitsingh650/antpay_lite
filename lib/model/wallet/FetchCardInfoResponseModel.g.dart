// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FetchCardInfoResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchCardInfoResponseModel _$FetchCardInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    FetchCardInfoResponseModel(
      code: json['code'] as String?,
      statusCode: json['status_code'] as String?,
      message: json['message'] as String?,
      cardNumber: json['card_number'] as String?,
      cvv: json['cvv'] as String?,
      expiryMonth: json['expiry_month'] as String?,
      expiryYear: json['expiry_year'] as String?,
    );

Map<String, dynamic> _$FetchCardInfoResponseModelToJson(
        FetchCardInfoResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status_code': instance.statusCode,
      'message': instance.message,
      'card_number': instance.cardNumber,
      'cvv': instance.cvv,
      'expiry_month': instance.expiryMonth,
      'expiry_year': instance.expiryYear,
    };
