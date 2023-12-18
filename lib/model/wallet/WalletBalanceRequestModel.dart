import 'package:json_annotation/json_annotation.dart';

part 'WalletBalanceRequestModel.g.dart';

@JsonSerializable()
class WalletBalanceRequestModel {
  @JsonKey(name: 'action_name')
  String? actionName;
  @JsonKey(name: 'p1')
  String? p1;

  WalletBalanceRequestModel({
    this.actionName,
    this.p1,
  });

  factory WalletBalanceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletBalanceRequestModelToJson(this);
}
