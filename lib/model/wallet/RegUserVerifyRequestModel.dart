import 'package:json_annotation/json_annotation.dart';

part 'RegUserVerifyRequestModel.g.dart';

@JsonSerializable()
class RegUserVerifyRequestModel {
  @JsonKey(name: 'action_name')
  String? actionName;
  String? p1;
  String? p2;
  String? p3;

  RegUserVerifyRequestModel({
    this.actionName,
    this.p1,
    this.p2,
    this.p3,
  });

  factory RegUserVerifyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegUserVerifyRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegUserVerifyRequestModelToJson(this);
}
