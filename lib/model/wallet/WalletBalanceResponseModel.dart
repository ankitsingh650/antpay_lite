import 'package:json_annotation/json_annotation.dart';

part 'WalletBalanceResponseModel.g.dart';

@JsonSerializable()
class WalletBalanceResponseModel {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'balance')
  double? balance;
  @JsonKey(name: 'status_code')
  String? statusCode;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'remaining_wallet_balance_limit')
  double? remainingWalletBalanceLimit;
  @JsonKey(name: 'remaining_load_limit')
  double? remainingLoadLimit;
  @JsonKey(name: 'tag_balance')
  List<Object>? tagBalance;
  @JsonKey(name: 'wallet_type')
  String? walletType;
  @JsonKey(name: 'remaining_cash_load_limit')
  double? remainingCashLoadLimit;
  @JsonKey(name: 'hold_amount')
  double? holdAmount;

  WalletBalanceResponseModel({
    this.code,
    this.balance,
    this.statusCode,
    this.message,
    this.phoneNumber,
    this.remainingWalletBalanceLimit,
    this.remainingLoadLimit,
    this.tagBalance,
    this.walletType,
    this.remainingCashLoadLimit,
    this.holdAmount,
  });

  factory WalletBalanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletBalanceResponseModelToJson(this);
}
