// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistoryRequestModel _$TransactionHistoryRequestModelFromJson(
        Map<String, dynamic> json) =>
    TransactionHistoryRequestModel(
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$TransactionHistoryRequestModelToJson(
        TransactionHistoryRequestModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
    };

TransactionHistoryResponseModel _$TransactionHistoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    TransactionHistoryResponseModel(
      transaction_list: (json['transaction_list'] as List<dynamic>?)
          ?.map(
              (e) => TransactionHistorylist.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'],
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$TransactionHistoryResponseModelToJson(
        TransactionHistoryResponseModel instance) =>
    <String, dynamic>{
      'transaction_list': instance.transaction_list,
      'status': instance.status,
      'msg': instance.msg,
    };

TransactionHistorylist _$TransactionHistorylistFromJson(
        Map<String, dynamic> json) =>
    TransactionHistorylist(
      transaction_no: json['transaction_no'] as String?,
      transaction_type: json['transaction_type'] as String?,
      app_user_mobile: json['app_user_mobile'],
      recharge_no: json['recharge_no'] as String?,
      amount: json['amount'] as String?,
      payment_method: json['payment_method'] as String?,
      status: json['status'] as String?,
      ResposneMessage: json['ResposneMessage'] as String?,
      antworksService: json['antworksService'] as String?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$TransactionHistorylistToJson(
        TransactionHistorylist instance) =>
    <String, dynamic>{
      'transaction_no': instance.transaction_no,
      'transaction_type': instance.transaction_type,
      'app_user_mobile': instance.app_user_mobile,
      'recharge_no': instance.recharge_no,
      'amount': instance.amount,
      'payment_method': instance.payment_method,
      'status': instance.status,
      'ResposneMessage': instance.ResposneMessage,
      'antworksService': instance.antworksService,
      'created_at': instance.created_at,
    };
