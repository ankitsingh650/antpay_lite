//to store body model of Profile via POST Call
import 'package:json_annotation/json_annotation.dart';
part 'profile_data.g.dart';

@JsonSerializable()
class ProfileUpdateRequestModel{


  ProfileUpdateRequestModel({
    this.company_name,
    this.dob,
    this.email,
    this.gender,
    this.income,
    this.invest_in_equity_market_flag,
    this.marital_status,
    this.mobile,
    this.name,
    this.occupation,
    this.own_house_motor_flag,
    this.profile_img,
    this.qualification,
  });

  @JsonKey(name: 'company_name')
  String? company_name;

  @JsonKey(name: 'dob')
  String? dob;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'income')
  String? income;

  @JsonKey(name: 'invest_in_equity_market_flag')
  String? invest_in_equity_market_flag;

  @JsonKey(name: 'marital_status')
  String? marital_status;

  @JsonKey(name: 'mobile')
  String? mobile;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'occupation')
  String? occupation;

  @JsonKey(name: 'own_house_motor_flag')
  String? own_house_motor_flag;

  @JsonKey(name: 'profile_img')
  String? profile_img;

  @JsonKey(name: 'qualification')
  String? qualification;

  factory ProfileUpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUpdateRequestModelToJson(this);

}


//to store response of profileUpdate via POST Call
@JsonSerializable()
class ProfileUpdateResponseModel{

  ProfileUpdateResponseModel({
    this.status,
    this.msg,
  });

  @JsonKey(name: 'status')
  dynamic status;

  @JsonKey(name: 'msg')
  String? msg;

  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUpdateResponseModelToJson(this);

}