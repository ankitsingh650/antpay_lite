// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_details_by_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferDetailsByCategoryRequest _$OfferDetailsByCategoryRequestFromJson(
        Map<String, dynamic> json) =>
    OfferDetailsByCategoryRequest(
      categoryID: json['category_id'] as String?,
      offerType: json['offer_type'] as String?,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$OfferDetailsByCategoryRequestToJson(
        OfferDetailsByCategoryRequest instance) =>
    <String, dynamic>{
      'category_id': instance.categoryID,
      'offer_type': instance.offerType,
      'source': instance.source,
    };

OfferDetailsByCategoryResponse _$OfferDetailsByCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    OfferDetailsByCategoryResponse(
      status: json['status'],
      details: (json['results'] as List<dynamic>?)
          ?.map((e) => OfferDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$OfferDetailsByCategoryResponseToJson(
        OfferDetailsByCategoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.details,
      'msg': instance.msg,
    };

OfferDetails _$OfferDetailsFromJson(Map<String, dynamic> json) => OfferDetails(
      id: json['id'] as String?,
      appName: json['app_name'] as String?,
      offerName: json['offer_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      offerValidity: json['offer_validity'] as String?,
      offerType: json['offer_type'] as String?,
      couponCodeType: json['coupon_code_type'] as String?,
      discountRewardType: json['discount_reward_type'] as String?,
      minTransactionAmount: json['min_transaction_amount'] as String?,
      maxTransactionAmount: json['max_transaction_amount'] as String?,
      discountWorth: json['discount_worth'] as String?,
      maxReward: json['max_reward'] as String?,
      paymentMethod: (json['payment_method'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bank: (json['bank'] as List<dynamic>?)?.map((e) => e as String).toList(),
      binInn: json['bin_inn'] as String?,
      offerShortDescription: json['offer_short_description'] as String?,
      offerLongDescription: json['offer_long_description'] as String?,
      termCondition: json['term_condition'] as String?,
      aboutCompany: json['about_company'] as String?,
      offerIconImg: json['offer_icon_img'] as String?,
      offerBannerImg: json['offer_banner_img'] as String?,
      companyIconImg: json['company_icon_img'] as String?,
      offerUrl: json['offer_url'] as String?,
      appID: json['app_id'] as String?,
      playStoreUrl: json['play_store_url'] as String?,
      status: json['status'] as String?,
      createdDate: json['created_date'] as String?,
    );

Map<String, dynamic> _$OfferDetailsToJson(OfferDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'app_name': instance.appName,
      'offer_name': instance.offerName,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'offer_validity': instance.offerValidity,
      'offer_type': instance.offerType,
      'coupon_code_type': instance.couponCodeType,
      'discount_reward_type': instance.discountRewardType,
      'min_transaction_amount': instance.minTransactionAmount,
      'max_transaction_amount': instance.maxTransactionAmount,
      'discount_worth': instance.discountWorth,
      'max_reward': instance.maxReward,
      'payment_method': instance.paymentMethod,
      'bank': instance.bank,
      'bin_inn': instance.binInn,
      'offer_short_description': instance.offerShortDescription,
      'offer_long_description': instance.offerLongDescription,
      'term_condition': instance.termCondition,
      'about_company': instance.aboutCompany,
      'offer_icon_img': instance.offerIconImg,
      'offer_banner_img': instance.offerBannerImg,
      'company_icon_img': instance.companyIconImg,
      'offer_url': instance.offerUrl,
      'app_id': instance.appID,
      'play_store_url': instance.playStoreUrl,
      'status': instance.status,
      'created_date': instance.createdDate,
    };
