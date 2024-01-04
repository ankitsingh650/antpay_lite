// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferDetailsRequest _$OfferDetailsRequestFromJson(Map<String, dynamic> json) =>
    OfferDetailsRequest(
      offerID: json['offer_id'] as String?,
    );

Map<String, dynamic> _$OfferDetailsRequestToJson(
        OfferDetailsRequest instance) =>
    <String, dynamic>{
      'offer_id': instance.offerID,
    };

OfferDetailsResponse _$OfferDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    OfferDetailsResponse(
      status: json['status'],
      details: json['results'] == null
          ? null
          : Details.fromJson(json['results'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$OfferDetailsResponseToJson(
        OfferDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.details,
      'msg': instance.msg,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      offerDetails: json['offer_details'] == null
          ? null
          : OfferDetails.fromJson(
              json['offer_details'] as Map<String, dynamic>),
      couponId: json['couponIds'] as String?,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'offer_details': instance.offerDetails,
      'couponIds': instance.couponId,
    };

OfferDetails _$OfferDetailsFromJson(Map<String, dynamic> json) => OfferDetails(
      id: json['id'] as String?,
      offerName: json['offer_name'] as String?,
      categoryId: json['category_id'] as String?,
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
      offerShortDescription: json['offer_short_description'] as String?,
      offerLongDescription: json['offer_long_description'] as String?,
      termCondition: json['term_condition'] as String?,
      aboutCompany: json['about_company'] as String?,
      offerIconImg: json['offer_icon_img'] as String?,
      offerBannerImg: json['offer_banner_img'] as String?,
      companyIconImg: json['company_icon_img'] as String?,
      offerUrl: json['offer_url'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OfferDetailsToJson(OfferDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'offer_name': instance.offerName,
      'category_id': instance.categoryId,
      'offer_type': instance.offerType,
      'coupon_code_type': instance.couponCodeType,
      'discount_reward_type': instance.discountRewardType,
      'min_transaction_amount': instance.minTransactionAmount,
      'max_transaction_amount': instance.maxTransactionAmount,
      'discount_worth': instance.discountWorth,
      'max_reward': instance.maxReward,
      'payment_method': instance.paymentMethod,
      'bank': instance.bank,
      'offer_short_description': instance.offerShortDescription,
      'offer_long_description': instance.offerLongDescription,
      'term_condition': instance.termCondition,
      'about_company': instance.aboutCompany,
      'offer_icon_img': instance.offerIconImg,
      'offer_banner_img': instance.offerBannerImg,
      'company_icon_img': instance.companyIconImg,
      'offer_url': instance.offerUrl,
      'status': instance.status,
    };
