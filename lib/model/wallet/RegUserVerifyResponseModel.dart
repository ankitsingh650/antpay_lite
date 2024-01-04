import 'package:json_annotation/json_annotation.dart';

part 'RegUserVerifyResponseModel.g.dart';

@JsonSerializable()
class RegUserVerifyResponseModel {
  String? code;
  @JsonKey(name: 'status_code')
  String? statusCode;
  @JsonKey(name: 'mobile_number')
  String? mobileNumber;
  String? token;
  String? message;

  RegUserVerifyResponseModel({
    this.code,
    this.statusCode,
    this.mobileNumber,
    this.token,
    this.message,
  });

  factory RegUserVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegUserVerifyResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegUserVerifyResponseModelToJson(this);
}
