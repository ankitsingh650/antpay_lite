// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpUserModel _$OtpUserModelFromJson(Map<String, dynamic> json) => OtpUserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      va: json['va'] as String?,
      companyReferralCode: json['company_referral_code'] as String?,
      userReferralCode: json['user_referral_code'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      occupation: json['occupation'] as String?,
      income: json['income'] as String?,
      classificationCode: json['classification_code'] as String?,
      pan: json['pan'],
      aadhar: json['aadhar'],
      isMobileVerified: json['is_mobile_verified'] as String?,
      isWalletActive: json['is_wallet_active'] as String?,
      walletActivationDate: json['wallet_activation_date'],
      kycStatus: json['kyc_status'] as String?,
      maritalStatus: json['marital_status'] as String?,
      education: json['qualification'] as String?,
      companyName: json['company_name'] as String?,
      investInEquityMarketFlag: json['invest_in_equity_market_flag'] as String?,
      ownHouseMotorFlag: json['own_house_motor_flag'] as String?,
      residenceType: json['residence_type'] as String?,
      profileImg: json['profile_img'] as String?,
    );

Map<String, dynamic> _$OtpUserModelToJson(OtpUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'va': instance.va,
      'company_referral_code': instance.companyReferralCode,
      'user_referral_code': instance.userReferralCode,
      'dob': instance.dob,
      'gender': instance.gender,
      'occupation': instance.occupation,
      'income': instance.income,
      'classification_code': instance.classificationCode,
      'pan': instance.pan,
      'aadhar': instance.aadhar,
      'is_mobile_verified': instance.isMobileVerified,
      'is_wallet_active': instance.isWalletActive,
      'wallet_activation_date': instance.walletActivationDate,
      'kyc_status': instance.kycStatus,
      'marital_status': instance.maritalStatus,
      'qualification': instance.education,
      'company_name': instance.companyName,
      'invest_in_equity_market_flag': instance.investInEquityMarketFlag,
      'own_house_motor_flag': instance.ownHouseMotorFlag,
      'residence_type': instance.residenceType,
      'profile_img': instance.profileImg,
    };
