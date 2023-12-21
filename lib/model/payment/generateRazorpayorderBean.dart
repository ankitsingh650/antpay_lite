import 'package:json_annotation/json_annotation.dart';
part 'generateRazorpayorderBean.g.dart';
//verify otp POST body class
@JsonSerializable()
class GenerateRazorpayorderModel {
  GenerateRazorpayorderModel({
    this.amount,
    this.mobile,
    this.service,
    this.channel,
  });

  @JsonKey(name: 'amount')
  String? amount;

  @JsonKey(name: 'mobile')
  String? mobile;

  @JsonKey(name: 'service')
  String? service;
  @JsonKey(name: 'channel')
  String? channel;



  factory GenerateRazorpayorderModel.fromJson(Map<String, dynamic> json) =>
      _$GenerateRazorpayorderModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateRazorpayorderModelToJson(this);

}
@JsonSerializable()
class GenerateRazorpayorderBean {
  GenerateRazorpayorderBean({
    this.msg,
    this.order_id,
    this.api_key,
    this.ant_txn_id,
  });

  @JsonKey(name: 'msg')
  String? msg;

  @JsonKey(name: 'order_id')
  String? order_id;


  @JsonKey(name: 'api_key')
  String? api_key;


  @JsonKey(name: 'ant_txn_id')
  String? ant_txn_id;




  factory GenerateRazorpayorderBean.fromJson(Map<String, dynamic> json) =>
      _$GenerateRazorpayorderBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateRazorpayorderBeanToJson(this);


}



