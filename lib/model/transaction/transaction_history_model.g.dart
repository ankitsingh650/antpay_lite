// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

fetchStatementRequestModel _$fetchStatementRequestModelFromJson(
        Map<String, dynamic> json) =>
    fetchStatementRequestModel(
      mobile: json['mobile'] as String?,
      txnStartDate: json['p2'] as String?,
      txnEndDate: json['p3'] as String?,
      pageNo: json['p4'] as String?,
    );

Map<String, dynamic> _$fetchStatementRequestModelToJson(
        fetchStatementRequestModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'p2': instance.txnStartDate,
      'p3': instance.txnEndDate,
      'p4': instance.pageNo,
    };

fetchStatementResponseModel _$fetchStatementResponseModelFromJson(
        Map<String, dynamic> json) =>
    fetchStatementResponseModel(
      requestId: json['requestId'] as String?,
      status: json['status'] as String?,
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'] as String?,
      transactionList: (json['transactionsList'] as List<dynamic>?)
          ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$fetchStatementResponseModelToJson(
        fetchStatementResponseModel instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'status': instance.status,
      'responseCode': instance.responseCode,
      'responseMessage': instance.responseMessage,
      'transactionsList': instance.transactionList,
    };

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      transactionDate: json['transactionDate'] as String?,
      transactionReferenceNumber: json['transactionReferenceNumber'] as String?,
      transactionType: json['transactionType'] as String?,
      transactionSubType: json['transactionSubType'] as String?,
      transactionAmount: json['transactionAmount'],
      commission: json['commission'] as String?,
      settlementAmount: json['settlementAmount'],
      settlementStatus: json['settlementStatus'] as String?,
      settlementMode: json['settlementMode'] as String?,
      settlementUTRNumber: json['settlementUTRNumber'] as String?,
      sender: json['sender'] as String?,
      senderVpa: json['senderVpa'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'transactionDate': instance.transactionDate,
      'transactionReferenceNumber': instance.transactionReferenceNumber,
      'transactionType': instance.transactionType,
      'transactionSubType': instance.transactionSubType,
      'transactionAmount': instance.transactionAmount,
      'commission': instance.commission,
      'settlementAmount': instance.settlementAmount,
      'settlementStatus': instance.settlementStatus,
      'settlementMode': instance.settlementMode,
      'settlementUTRNumber': instance.settlementUTRNumber,
      'sender': instance.sender,
      'senderVpa': instance.senderVpa,
    };
