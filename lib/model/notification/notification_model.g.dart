// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchNotificationRequestModel _$FetchNotificationRequestModelFromJson(
        Map<String, dynamic> json) =>
    FetchNotificationRequestModel(
      mobile: json['mobile'] as String?,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$FetchNotificationRequestModelToJson(
        FetchNotificationRequestModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'source': instance.source,
    };

FetchNotificationResponseModel _$FetchNotificationResponseModelFromJson(
        Map<String, dynamic> json) =>
    FetchNotificationResponseModel(
      status: json['status'],
      notificationList: (json['notification_list'] as List<dynamic>?)
          ?.map((e) => Notifications.fromJson(e as Map<String, dynamic>))
          .toList(),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$FetchNotificationResponseModelToJson(
        FetchNotificationResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'notification_list': instance.notificationList,
      'msg': instance.msg,
    };

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      id: json['id'] as String?,
      classificationCode: json['classification_code'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      img: json['img'],
      imgUrl: json['img_url'] as String?,
      pageUrl: json['page_url'],
      pageName: json['page_name'] as String?,
      categoryId: json['category_id'] as String?,
      status: json['status'] as String?,
      source: json['source'] as String?,
      createdDate: json['created_date'] as String?,
    );

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classification_code': instance.classificationCode,
      'title': instance.title,
      'message': instance.message,
      'img': instance.img,
      'img_url': instance.imgUrl,
      'page_url': instance.pageUrl,
      'page_name': instance.pageName,
      'category_id': instance.categoryId,
      'status': instance.status,
      'source': instance.source,
      'created_date': instance.createdDate,
    };
