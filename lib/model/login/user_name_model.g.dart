// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsernameRequest _$UsernameRequestFromJson(Map<String, dynamic> json) =>
    UsernameRequest(
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$UsernameRequestToJson(UsernameRequest instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
    };

UsernameResponse _$UsernameResponseFromJson(Map<String, dynamic> json) =>
    UsernameResponse(
      lname: json['lname'] as String?,
      fname: json['fname'] as String?,
    );

Map<String, dynamic> _$UsernameResponseToJson(UsernameResponse instance) =>
    <String, dynamic>{
      'lname': instance.lname,
      'fname': instance.fname,
    };
