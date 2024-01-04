import 'package:json_annotation/json_annotation.dart';

part 'offers_model.g.dart';

@JsonSerializable()
class OfferResponse {

  OfferResponse({
    this.status,
    this.results,
    this.msg,
  });

  @JsonKey(name: 'status')
  dynamic status;

  @JsonKey(name: 'results')
  List<Results>? results;

  @JsonKey(name: 'msg')
  String? msg;


  factory OfferResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferResponseToJson(this);
}

@JsonSerializable()
class Results {

  Results({
    this.categoryName,
    this.imgURL,
    this.offer,
  });

  @JsonKey(name: 'category_name')
  String? categoryName;

  @JsonKey(name: 'img_base_url')
  String? imgURL;

  @JsonKey(name: 'offers')
  List<Offer>? offer;

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

@JsonSerializable()
class Offer {
  Offer({
    this.id,
    this.offerName,
    this.offerType,
    this.couponCodeType,
    this.offerIconImg,
    this.offerBannerImg,
    this.companyIconImg,
    this.offerUrl,
    this.appId,
    this.playStoreURL,
    this.status,
  });

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'offer_name')
  String? offerName;

  @JsonKey(name: 'offer_type')
  String? offerType;

  @JsonKey(name: 'coupon_code_type')
  String? couponCodeType;

  @JsonKey(name: 'offer_icon_img')
  String? offerIconImg;


  @JsonKey(name: 'offer_banner_img')
  String? offerBannerImg;

  @JsonKey(name: 'company_icon_img')
  String? companyIconImg;

  @JsonKey(name: 'offer_url')
  String? offerUrl;

  @JsonKey(name: 'app_id')
  String? appId;

  @JsonKey(name: 'play_store_url')
  String? playStoreURL;

  @JsonKey(name: 'status')
  String? status;


  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
