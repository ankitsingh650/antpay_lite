import 'package:json_annotation/json_annotation.dart';

part 'AadhaarCardRequest.g.dart';

@JsonSerializable()
class AadhaarCardRequest {
  String? p1;
  String? p2;
  String? p3;
  String? p4;
  String? p5;
  String? p6;
  String? p7;
  String? p8;
  String? p9;
  String? p10;
  String? city;
  String? state;

  AadhaarCardRequest({
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
    this.p6,
    this.p7,
    this.p8,
    this.p9,
    this.p10,
    this.city,
    this.state,
  });

  factory AadhaarCardRequest.fromJson(Map<String, dynamic> json) =>
      _$AadhaarCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AadhaarCardRequestToJson(this);
}
