import 'package:json_annotation/json_annotation.dart';

part 'offer_details_by_category_model.g.dart';

@JsonSerializable()
class OfferDetailsByCategoryRequest {

  OfferDetailsByCategoryRequest({
    this.categoryID,
    this.offerType,
    this.source,
  });

  @JsonKey(name: 'category_id')
  String? categoryID;

  @JsonKey(name: 'offer_type')
  String? offerType;

  @JsonKey(name: 'source')
  String? source;



  factory OfferDetailsByCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$OfferDetailsByCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailsByCategoryRequestToJson(this);
}

@JsonSerializable()
class OfferDetailsByCategoryResponse {

  OfferDetailsByCategoryResponse({
    this.status,
    this.details,
    this.msg,
  });

  @JsonKey(name: 'status')
  dynamic status;

  @JsonKey(name: 'results')
  List<OfferDetails>? details;

  @JsonKey(name: 'msg')
  String? msg;

  factory OfferDetailsByCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferDetailsByCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailsByCategoryResponseToJson(this);
}

@JsonSerializable()
class OfferDetails {


  OfferDetails({
    this.id,
    this.appName,
    this.offerName,
    this.categoryId,
    this.categoryName,
    this.offerValidity,
    this.offerType,
    this.couponCodeType,
    this.discountRewardType,
    this.minTransactionAmount,
    this.maxTransactionAmount,
    this.discountWorth,
    this.maxReward,
    this.paymentMethod,
    this.bank,
    this.binInn,
    this.offerShortDescription,
    this.offerLongDescription,
    this.termCondition,
    this.aboutCompany,
    this.offerIconImg,
    this.offerBannerImg,
    this.companyIconImg,
    this.offerUrl,
    this.appID,
    this.playStoreUrl,
    this.status,
    this.createdDate,
  });

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'app_name')
  String? appName;

  @JsonKey(name: 'offer_name')
  String? offerName;

  @JsonKey(name: 'category_id')
  String? categoryId;

  @JsonKey(name: 'category_name')
  String? categoryName;

  @JsonKey(name: 'offer_validity')
  String? offerValidity;

  @JsonKey(name: 'offer_type')
  String? offerType;

  @JsonKey(name: 'coupon_code_type')
  String? couponCodeType;

  @JsonKey(name: 'discount_reward_type')
  String? discountRewardType;

  @JsonKey(name: 'min_transaction_amount')
  String? minTransactionAmount;

  @JsonKey(name: 'max_transaction_amount')
  String? maxTransactionAmount;

  @JsonKey(name: 'discount_worth')
  String? discountWorth;

  @JsonKey(name: 'max_reward')
  String? maxReward;

  @JsonKey(name: 'payment_method')
  List<String>? paymentMethod;

  @JsonKey(name: 'bank')
  List<String>? bank;

  @JsonKey(name: 'bin_inn')
  String? binInn;

  @JsonKey(name: 'offer_short_description')
  String? offerShortDescription;

  @JsonKey(name: 'offer_long_description')
  String? offerLongDescription;


  @JsonKey(name: 'term_condition')
  String? termCondition;

  @JsonKey(name: 'about_company')
  String? aboutCompany;

  @JsonKey(name: 'offer_icon_img')
  String? offerIconImg;

  @JsonKey(name: 'offer_banner_img')
  String? offerBannerImg;

  @JsonKey(name: 'company_icon_img')
  String? companyIconImg;

  @JsonKey(name: 'offer_url')
  String? offerUrl;

  @JsonKey(name: 'app_id')
  String? appID;

  @JsonKey(name: 'play_store_url')
  String? playStoreUrl;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'created_date')
  String? createdDate;


  factory OfferDetails.fromJson(Map<String, dynamic> json) => _$OfferDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailsToJson(this);
}
