// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generateRazorpayorderBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateRazorpayorderModel _$GenerateRazorpayorderModelFromJson(
        Map<String, dynamic> json) =>
    GenerateRazorpayorderModel(
      amount: json['amount'] as String?,
      mobile: json['mobile'] as String?,
      service: json['service'] as String?,
    );

Map<String, dynamic> _$GenerateRazorpayorderModelToJson(
        GenerateRazorpayorderModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'mobile': instance.mobile,
      'service': instance.service,
    };

GenerateRazorpayorderBean _$GenerateRazorpayorderBeanFromJson(
        Map<String, dynamic> json) =>
    GenerateRazorpayorderBean(
      msg: json['msg'] as String?,
      order_id: json['order_id'] as String?,
      api_key: json['api_key'] as String?,
      ant_txn_id: json['ant_txn_id'] as String?,
    );

Map<String, dynamic> _$GenerateRazorpayorderBeanToJson(
        GenerateRazorpayorderBean instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'order_id': instance.order_id,
      'api_key': instance.api_key,
      'ant_txn_id': instance.ant_txn_id,
    };
