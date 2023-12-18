import 'package:json_annotation/json_annotation.dart';

part 'FetchCardInfoRequestModel.g.dart';

@JsonSerializable()
class FetchCardInfoRequestModel {
  @JsonKey(name: 'action_name')
  String? actionName;
  @JsonKey(name: 'p1')
  String? p1;
  @JsonKey(name: 'p2')
  String? p2;

  FetchCardInfoRequestModel({
    this.actionName,
    this.p1,
    this.p2,
  });

  factory FetchCardInfoRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FetchCardInfoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$FetchCardInfoRequestModelToJson(this);
}
