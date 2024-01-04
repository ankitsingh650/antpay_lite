//to store body model of Profile via POST Call
import 'package:json_annotation/json_annotation.dart';
part 'homebanner.g.dart';
//to store response of profileUpdate via POST Call
@JsonSerializable()
class HomebannerModel{

  HomebannerModel({
    this.status,
    this.msg,
    this.banner_list,
  });

  @JsonKey(name: 'status')
  dynamic status;

  @JsonKey(name: 'msg')
  String? msg;


  @JsonKey(name: 'banner_list')
  List<Bannerlist>? banner_list;

  factory HomebannerModel.fromJson(Map<String, dynamic> json) =>
      _$HomebannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomebannerModelToJson(this);

}
@JsonSerializable()
class Bannerlist {
  Bannerlist({
    this.id,
    this.banner_name,
    this.banner_img,
    this.app_page,
    this.web_url,
    this.status,
    this.expired_at,
});


@JsonKey(name: 'id')
dynamic id;

@JsonKey(name: 'banner_name')
dynamic banner_name;

@JsonKey(name: 'banner_img')
dynamic banner_img;

@JsonKey(name: 'app_page')
dynamic app_page;

@JsonKey(name: 'web_url')
dynamic web_url;

@JsonKey(name: 'status')
dynamic status;

@JsonKey(name: 'expired_at')
dynamic expired_at;

  factory Bannerlist.fromJson(Map<String, dynamic> json) =>
      _$BannerlistFromJson(json);

  Map<String, dynamic> toJson() => _$BannerlistToJson(this);


}