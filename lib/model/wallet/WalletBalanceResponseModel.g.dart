// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WalletBalanceResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletBalanceResponseModel _$WalletBalanceResponseModelFromJson(
        Map<String, dynamic> json) =>
    WalletBalanceResponseModel(
      code: json['code'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      statusCode: json['status_code'] as String?,
      message: json['message'] as String?,
      phoneNumber: json['phone_number'] as String?,
      remainingWalletBalanceLimit:
          (json['remaining_wallet_balance_limit'] as num?)?.toDouble(),
      remainingLoadLimit: (json['remaining_load_limit'] as num?)?.toDouble(),
      tagBalance: (json['tag_balance'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList(),
      walletType: json['wallet_type'] as String?,
      remainingCashLoadLimit:
          (json['remaining_cash_load_limit'] as num?)?.toDouble(),
      holdAmount: (json['hold_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WalletBalanceResponseModelToJson(
        WalletBalanceResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'balance': instance.balance,
      'status_code': instance.statusCode,
      'message': instance.message,
      'phone_number': instance.phoneNumber,
      'remaining_wallet_balance_limit': instance.remainingWalletBalanceLimit,
      'remaining_load_limit': instance.remainingLoadLimit,
      'tag_balance': instance.tagBalance,
      'wallet_type': instance.walletType,
      'remaining_cash_load_limit': instance.remainingCashLoadLimit,
      'hold_amount': instance.holdAmount,
    };
