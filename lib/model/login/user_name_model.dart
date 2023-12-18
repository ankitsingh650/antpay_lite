
import 'package:json_annotation/json_annotation.dart';
part 'user_name_model.g.dart';

@JsonSerializable()
class UsernameRequest {
  UsernameRequest({
    this.mobile
});

  @JsonKey(name: 'mobile')
  String? mobile;


  factory UsernameRequest.fromJson(Map<String, dynamic> json) =>
      _$UsernameRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UsernameRequestToJson(this);
  }

@JsonSerializable()
class UsernameResponse {
  UsernameResponse({
    this.lname,
    this.fname
});

  @JsonKey(name: 'lname')
  String? lname;


  @JsonKey(name: 'fname')
  String? fname;


  factory UsernameResponse.fromJson(Map<String, dynamic> json) =>
      _$UsernameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsernameResponseToJson(this);
}



