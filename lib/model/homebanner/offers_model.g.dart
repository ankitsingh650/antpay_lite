// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferResponse _$OfferResponseFromJson(Map<String, dynamic> json) =>
    OfferResponse(
      status: json['status'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$OfferResponseToJson(OfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
      'msg': instance.msg,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      categoryName: json['category_name'] as String?,
      imgURL: json['img_base_url'] as String?,
      offer: (json['offers'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'category_name': instance.categoryName,
      'img_base_url': instance.imgURL,
      'offers': instance.offer,
    };

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: json['id'] as String?,
      offerName: json['offer_name'] as String?,
      offerType: json['offer_type'] as String?,
      couponCodeType: json['coupon_code_type'] as String?,
      offerIconImg: json['offer_icon_img'] as String?,
      offerBannerImg: json['offer_banner_img'] as String?,
      companyIconImg: json['company_icon_img'] as String?,
      offerUrl: json['offer_url'] as String?,
      appId: json['app_id'] as String?,
      playStoreURL: json['play_store_url'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'offer_name': instance.offerName,
      'offer_type': instance.offerType,
      'coupon_code_type': instance.couponCodeType,
      'offer_icon_img': instance.offerIconImg,
      'offer_banner_img': instance.offerBannerImg,
      'company_icon_img': instance.companyIconImg,
      'offer_url': instance.offerUrl,
      'app_id': instance.appId,
      'play_store_url': instance.playStoreURL,
      'status': instance.status,
    };
