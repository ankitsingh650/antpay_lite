import 'package:json_annotation/json_annotation.dart';

part 'transaction_history_model.g.dart';

@JsonSerializable()
class fetchStatementRequestModel{


  fetchStatementRequestModel({
    this.mobile,
    this.txnStartDate,
    this.txnEndDate,
    this.pageNo,
  });

  @JsonKey(name: 'mobile')
  String? mobile;

  @JsonKey(name: 'p2')
  String? txnStartDate;

  @JsonKey(name: 'p3')
  String? txnEndDate;

  @JsonKey(name: 'p4')
  String? pageNo;

  factory fetchStatementRequestModel.fromJson(Map<String, dynamic> json) =>
      _$fetchStatementRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$fetchStatementRequestModelToJson(this);
}

@JsonSerializable()
class fetchStatementResponseModel{

  fetchStatementResponseModel({
    this.requestId,
    this.status,
    this.responseCode,
    this.responseMessage,
    this.transactionList
  });

  @JsonKey(name: 'requestId')
  String? requestId;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'responseCode')
  dynamic responseCode;

  @JsonKey(name: 'responseMessage')
  String? responseMessage;

  @JsonKey(name: 'transactionsList')
  List<TransactionModel>? transactionList;

  factory fetchStatementResponseModel.fromJson(Map<String, dynamic> json) =>
      _$fetchStatementResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$fetchStatementResponseModelToJson(this);
}

@JsonSerializable()
class TransactionModel{

  TransactionModel({
    this.transactionDate,
    this.transactionReferenceNumber,
    this.transactionType,
    this.transactionSubType,
    this.transactionAmount,
    this.commission,
    this.settlementAmount,
    this.settlementStatus,
    this.settlementMode,
    this.settlementUTRNumber,
    this.sender,
    this.senderVpa
  });


  @JsonKey(name: 'transactionDate')
  String? transactionDate;

  @JsonKey(name: 'transactionReferenceNumber')
  String? transactionReferenceNumber;

  @JsonKey(name: 'transactionType')
  String? transactionType;

  @JsonKey(name: 'transactionSubType')
  String? transactionSubType;

  @JsonKey(name: 'transactionAmount')
  dynamic transactionAmount;

  @JsonKey(name: 'commission')
  String? commission;

  @JsonKey(name: 'settlementAmount')
  dynamic settlementAmount;

  @JsonKey(name: 'settlementStatus')
  String? settlementStatus;

  @JsonKey(name: 'settlementMode')
  String? settlementMode;

  @JsonKey(name: 'settlementUTRNumber')
  String? settlementUTRNumber;

  @JsonKey(name: 'sender')
  String? sender;

  @JsonKey(name: 'senderVpa')
  String? senderVpa;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}