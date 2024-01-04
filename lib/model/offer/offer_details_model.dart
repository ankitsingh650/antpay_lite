import 'package:json_annotation/json_annotation.dart';

part 'offer_details_model.g.dart';

@JsonSerializable()
class OfferDetailsRequest {

  OfferDetailsRequest({
    this.offerID,
  });

  @JsonKey(name: 'offer_id')
  String? offerID;



  factory OfferDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$OfferDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailsRequestToJson(this);
}

@JsonSerializable()
class OfferDetailsResponse {

  OfferDetailsResponse({
    this.status,
    this.details,
    this.msg,
  });

  @JsonKey(name: 'status')
  dynamic status;

  @JsonKey(name: 'results')
  Details? details;

  @JsonKey(name: 'msg')
  String? msg;

  factory OfferDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailsResponseToJson(this);
}

@JsonSerializable()
class Details {

  Details({
    this.offerDetails,
    this.couponId,
  });


  @JsonKey(name: 'offer_details')
  OfferDetails? offerDetails;

  @JsonKey(name: 'couponIds')
  String? couponId;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable()
class OfferDetails {


  OfferDetails({
    this.id,
    this.offerName,
    this.categoryId,
    this.offerType,
    this.couponCodeType,
    this.discountRewardType,
    this.minTransactionAmount,
    this.maxTransactionAmount,
    this.discountWorth,
    this.maxReward,
    this.paymentMethod,
    this.bank,
    this.offerShortDescription,
    this.offerLongDescription,
    this.termCondition,
    this.aboutCompany,
    this.offerIconImg,
    this.offerBannerImg,
    this.companyIconImg,
    this.offerUrl,
    this.status,
  });

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'offer_name')
  String? offerName;

  @JsonKey(name: 'category_id')
  String? categoryId;

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

  @JsonKey(name: 'status')
  String? status;


  factory OfferDetails.fromJson(Map<String, dynamic> json) => _$OfferDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailsToJson(this);
}
