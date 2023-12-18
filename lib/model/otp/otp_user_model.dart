import 'package:json_annotation/json_annotation.dart';
part 'otp_user_model.g.dart';

@JsonSerializable()
class OtpUserModel{


  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'va')
  String? va;

  @JsonKey(name: 'company_referral_code')
  String? companyReferralCode;

  @JsonKey(name: 'user_referral_code')
  String? userReferralCode;

  @JsonKey(name: 'dob')
  String? dob;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'occupation')
  String? occupation;

  @JsonKey(name: 'income')
  String? income;

  @JsonKey(name: 'classification_code')
  String? classificationCode;

  @JsonKey(name: 'pan')
  dynamic pan;

  @JsonKey(name: 'aadhar')
  dynamic aadhar;

  @JsonKey(name: 'is_mobile_verified')
  String? isMobileVerified;

  @JsonKey(name: 'is_wallet_active')
  String? isWalletActive;

  @JsonKey(name: 'wallet_activation_date')
  dynamic walletActivationDate;

  @JsonKey(name: 'kyc_status')
  String? kycStatus;

  @JsonKey(name: 'marital_status')
  String? maritalStatus;

  @JsonKey(name: 'qualification')
  String? education;

  @JsonKey(name: 'company_name')
  String? companyName;

  @JsonKey(name: 'invest_in_equity_market_flag')
  String? investInEquityMarketFlag;

  @JsonKey(name: 'own_house_motor_flag')
  String? ownHouseMotorFlag;

  @JsonKey(name: 'residence_type')
  String? residenceType;

  @JsonKey(name: 'profile_img')
  String? profileImg;

  OtpUserModel({
    this.name,
    this.email,
    this.va,
    this.companyReferralCode,
    this.userReferralCode,
    this.dob,
    this.gender,
    this.occupation,
    this.income,
    this.classificationCode,
    this.pan,
    this.aadhar,
    this.isMobileVerified,
    this.isWalletActive,
    this.walletActivationDate,
    this.kycStatus,
    this.maritalStatus,
    this.education,
    this.companyName,
    this.investInEquityMarketFlag,
    this.ownHouseMotorFlag,
    this.residenceType,
    this.profileImg});

  factory OtpUserModel.fromJson(Map<String, dynamic> json) =>
      _$OtpUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpUserModelToJson(this);
}