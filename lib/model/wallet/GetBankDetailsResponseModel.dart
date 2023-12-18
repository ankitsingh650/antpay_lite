import 'package:json_annotation/json_annotation.dart';

part 'GetBankDetailsResponseModel.g.dart';

@JsonSerializable()
class GetBankDetailsResponseModel {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'account_no')
  String? accountNo;
  @JsonKey(name: 'ifsc_code')
  String? ifscCode;
  @JsonKey(name: 'account_holder_name')
  String? accountHolderName;
  @JsonKey(name: 'msg')
  String? msg;

  GetBankDetailsResponseModel({
    this.status,
    this.accountNo,
    this.ifscCode,
    this.accountHolderName,
    this.msg,
  });

  factory GetBankDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetBankDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetBankDetailsResponseModelToJson(this);
}
