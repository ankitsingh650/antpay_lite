// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FetchCardInfoRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchCardInfoRequestModel _$FetchCardInfoRequestModelFromJson(
        Map<String, dynamic> json) =>
    FetchCardInfoRequestModel(
      actionName: json['action_name'] as String?,
      p1: json['p1'] as String?,
      p2: json['p2'] as String?,
    );

Map<String, dynamic> _$FetchCardInfoRequestModelToJson(
        FetchCardInfoRequestModel instance) =>
    <String, dynamic>{
      'action_name': instance.actionName,
      'p1': instance.p1,
      'p2': instance.p2,
    };
