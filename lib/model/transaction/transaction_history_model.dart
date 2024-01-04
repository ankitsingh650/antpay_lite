import 'package:json_annotation/json_annotation.dart';

part 'transaction_history_model.g.dart';

@JsonSerializable()
class TransactionHistoryRequestModel{


  TransactionHistoryRequestModel({
    this.mobile,

  });

  @JsonKey(name: 'mobile')
  String? mobile;


  factory TransactionHistoryRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHistoryRequestModelToJson(this);
}

@JsonSerializable()
class TransactionHistoryResponseModel{
  TransactionHistoryResponseModel({
    this.transaction_list,
    this.status,
    this.msg,
  });


  @JsonKey(name: 'transaction_list')
  List<TransactionHistorylist>? transaction_list;

  @JsonKey(name: 'status')
  dynamic? status;

  @JsonKey(name: 'msg')
  String? msg;

  factory TransactionHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryResponseModelFromJson(json);

  get loading => null;

  Map<String, dynamic> toJson() => _$TransactionHistoryResponseModelToJson(this);
}



@JsonSerializable()
class TransactionHistorylist{
  TransactionHistorylist({
    this.transaction_no,
    this.transaction_type,
    this.app_user_mobile,
    this.recharge_no,
    this.amount,
    this.payment_method,
    this.status,
    this.ResposneMessage,
    this.antworksService,
    this.created_at,
  });

  @JsonKey(name: 'transaction_no')
  String? transaction_no;

  @JsonKey(name: 'transaction_type')
  String? transaction_type;

  @JsonKey(name: 'app_user_mobile')
  dynamic app_user_mobile;

  @JsonKey(name: 'recharge_no')
  String? recharge_no;

  @JsonKey(name: 'amount')
  String? amount;

  @JsonKey(name: 'payment_method')
  String? payment_method;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'ResposneMessage')
  String? ResposneMessage;

  @JsonKey(name: 'antworksService')
  String? antworksService;

  @JsonKey(name: 'created_at')
  String? created_at;



  factory TransactionHistorylist.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistorylistFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHistorylistToJson(this);
}
