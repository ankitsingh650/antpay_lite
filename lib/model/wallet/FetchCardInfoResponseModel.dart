import 'package:json_annotation/json_annotation.dart';

part 'FetchCardInfoResponseModel.g.dart';

@JsonSerializable()
class FetchCardInfoResponseModel {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'status_code')
  String? statusCode;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'card_number')
  String? cardNumber;
  @JsonKey(name: 'cvv')
  String? cvv;
  @JsonKey(name: 'expiry_month')
  String? expiryMonth;
  @JsonKey(name: 'expiry_year')
  String? expiryYear;

  FetchCardInfoResponseModel({
    this.code,
    this.statusCode,
    this.message,
    this.cardNumber,
    this.cvv,
    this.expiryMonth,
    this.expiryYear,
  });

  factory FetchCardInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FetchCardInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FetchCardInfoResponseModelToJson(this);
}
