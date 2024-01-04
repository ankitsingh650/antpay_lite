import 'package:json_annotation/json_annotation.dart';

part 'RegUserRequestModel.g.dart';

@JsonSerializable()
class RegUserRequestModel {
  @JsonKey(name: 'action_name')
  String? actionName;
  String? p1;
  String? p2;

  RegUserRequestModel({
    this.actionName,
    this.p1,
    this.p2,
  });

  factory RegUserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegUserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegUserRequestModelToJson(this);
}
