import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class FetchNotificationRequestModel{

  FetchNotificationRequestModel({
    this.mobile,
    this.source,

  });

  @JsonKey(name: 'mobile')
  String? mobile;

  @JsonKey(name: 'source')
  String? source;


  factory FetchNotificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FetchNotificationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$FetchNotificationRequestModelToJson(this);

}

@JsonSerializable()
class FetchNotificationResponseModel{

  FetchNotificationResponseModel({
    this.status,
    this.notificationList,
    this.msg,
  });

  @JsonKey(name: 'status')
  dynamic status;

  @JsonKey(name: 'notification_list')
  List<Notifications>? notificationList;

  @JsonKey(name: 'msg')
  String? msg;
  factory FetchNotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FetchNotificationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FetchNotificationResponseModelToJson(this);
}

@JsonSerializable()
class Notifications{

  Notifications({
    this.id,
    this.classificationCode,
    this.title,
    this.message,
    this.img,
    this.imgUrl,
    this.pageUrl,
    this.pageName,
    this.categoryId,
    this.status,
    this.source,
    this.createdDate,
  });

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'classification_code')
  String? classificationCode;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'img')
  dynamic img;

  @JsonKey(name: 'img_url')
  String? imgUrl;

  @JsonKey(name: 'page_url')
  dynamic pageUrl;

  @JsonKey(name: 'page_name')
  String? pageName;

  @JsonKey(name: 'category_id')
  String? categoryId;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'source')
  String? source;

  @JsonKey(name: 'created_date')
  String? createdDate;

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}