import 'package:json_annotation/json_annotation.dart';

part 'PanKYCResponseModel.g.dart';

@JsonSerializable()
class PanKYCResponseModel {
  String? code;
  @JsonKey(name: 'status_code')
  String? statusCode;
  @JsonKey(name: 'mobile_number')
  String? mobileNumber;
  String? message;

  PanKYCResponseModel({
    this.code,
    this.statusCode,
    this.mobileNumber,
    this.message,
  });

  factory PanKYCResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PanKYCResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PanKYCResponseModelToJson(this);
}
