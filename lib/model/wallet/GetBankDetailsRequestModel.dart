import 'package:json_annotation/json_annotation.dart';

part 'GetBankDetailsRequestModel.g.dart';

@JsonSerializable()
class GetBankDetailsRequestModel {
  @JsonKey(name: 'mobile')
  String? mobile;

  GetBankDetailsRequestModel({this.mobile});

  factory GetBankDetailsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GetBankDetailsRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetBankDetailsRequestModelToJson(this);
}
