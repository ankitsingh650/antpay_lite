// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetBankDetailsResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBankDetailsResponseModel _$GetBankDetailsResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetBankDetailsResponseModel(
      status: json['status'] as String?,
      accountNo: json['account_no'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      accountHolderName: json['account_holder_name'] as String?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$GetBankDetailsResponseModelToJson(
        GetBankDetailsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'account_no': instance.accountNo,
      'ifsc_code': instance.ifscCode,
      'account_holder_name': instance.accountHolderName,
      'msg': instance.msg,
    };
