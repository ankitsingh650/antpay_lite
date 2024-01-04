import 'package:json_annotation/json_annotation.dart';

part 'RegUserResponseModel.g.dart';

@JsonSerializable()
class RegUserResponseModel {
  String? code;
  @JsonKey(name: 'status_code')
  String? statusCode;
  @JsonKey(name: 'mobile_number')
  String? mobileNumber;
  @JsonKey(name: 'otp_ref_number')
  int? otpRefNumber;
  String? message;

  RegUserResponseModel({
    this.code,
    this.statusCode,
    this.mobileNumber,
    this.otpRefNumber,
    this.message,
  });

  factory RegUserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegUserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegUserResponseModelToJson(this);
}
