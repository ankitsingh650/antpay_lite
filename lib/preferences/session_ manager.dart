
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{

   static final String _PREF_NAME = "SharePreferences";
   static final String _KEY_KYC_STATUS = "KYC";
   static final String _IS_LOGIN = "IsLoggedIn";
   static final String KEY_NAME = "name";
   static final String IS_NOT_FIRST_TIME = "not_first_time";
   static final String KEY_EMAIL = "email";
   static final String KEY_PAN_CARD = "panNumber";
   static final String KEY_MOBILE = "mobile";
   static final String KEY_GENDER = "gender";
   static final String KEY_PAYMENT_PIN = "payment_pin";
   static final String KEY_PROFILE_PIC = "profile_pic";
   static final String KEY_SELFIE_PIC = "selfie_pic";
   static final String KEY_MARITAL_STATUS = "MARITAL_STATUS";
   static final String KEY_DATE_OF_BIRTH = "DATE_OF_BIRTH";
   static final String KEY_OCCUPATION = "OCCUPATION";
   static final String KEY_EDUCATION = "EDUCATION";
   static final String KEY_INCOME = "INCOME";
   static final String KEY_INVEST_IN_MUTUAL_FUND = "INVEST_IN_MUTUAL_FUND";
   static final String KEY_OWN_ASSETS = "OWN_ASSETS";
   static final String KEY_CONTACT = "contact";
   static final String KEY_TOKEN = "token";
   static final String KEY_CORPORATE_ID = "corporate_id";
   static final String KEY_SELLER_ID = "seller_id";
   static final String KEY_VERIFICATION_TOKEN = "verification_token";
   static final String KEY_CONTACT_NAME = "contact_name";
   static final String KEY_BENEFICIARY_NAME = "beneficiary_name";
   static final String KEY_BENEFICIARY_TYPE = "beneficiary_type";
   static final String KEY_ACCOUNT_NUMBER = "account_NUMBER";
   static final String KEY_IFSC_CODE = "ifsc_code";
   static final String KEY_BENEFICIARY_ID = "beneficiary_id";
   static final String KEY_WALLET_BENEFICIARY_ID = "wallet_beneficiary_id";
   static final String KEY_WALLET_BENEFICIARY_NAME = "wallet_beneficiary_name";
   static final String KEY_WALLET_BALANCE = "KEY_WALLET_BALANCE";
   static final String KEY_NO_AADHAR_KYC_DONE = "no_aadhar_kyc_done";
   static final String KEY_VPA_BENEFICIARY_ID = "vpa_beneficiary_id";
   static final String KEY_MAX_PERMISSIBLE_LIMIT = "max_permissible_limit";
   static final String KEY_MONTHLY_LIMIT_AVAILED = "monthly_limit_availed";
   static final String KEY_PAGE_NAME = "page_name";
   static final String KEY_REFERRER_CODE = "referrer_code";
   static final String KEY_INSURANCE_TOKEN = "KEY_INSURANCE_TOKEN";
   static final String INSURANCE_TRANSACTION_ID = "INSURANCE_TRANSACTION_ID";
   static final String INSURANCE_PRODUCT_CODE = "INSURANCE_PRODUCT_CODE";
   static final String INSURANCE_RTO_CODE = "INSURANCE_RTO_CODE";
   static final String INSURANCE_VEHICLE_CODE = "INSURANCE_VEHICLE_CODE";
   static final String INSURANCE_VEHICLE_REGISTRATION = "INSURANCE_VEHICLE_REGISTRATION";
   static final String INSURANCE_POLICY_START_DATE = "INSURANCE_POLICY_START_DATE";
   static final String INSURANCE_POLICY_TYPE = "INSURANCE_POLICY_TYPE";
   static final String INSURANCE_VEHICLE_LIFE = "INSURANCE_VEHICLE_LIFE";
   static final String INSURANCE_BUSINESS_TYPE = "INSURANCE_BUSINESS_TYPE";
   static final String INSURANCE_POLICY_TENURE = "INSURANCE_POLICY_TENURE";
   static final String INSURANCE_IDV_AMOUNT = "INSURANCE_IDV_AMOUNT";
   static final String INSURANCE_MAX_IDV_AMOUNT = "INSURANCE_MAX_IDV_AMOUNT";
   static final String INSURANCE_MIN_IDV_AMOUNT = "INSURANCE_MIN_IDV_AMOUNT";
   static final String INSURANCE_VEHICLE_TYPE = "INSURANCE_VEHICLE_TYPE";

   static final String INSURANCE_DRIVING_LICENSE = "INSURANCE_DRIVING_LICENSE";
   static final String INSURANCE_EA_COVER = "INSURANCE_EA_COVER";
   static final String INSURANCE_ZERO_DEBT_COVER = "INSURANCE_ZERO_DEBT_COVER";
   static final String INSURANCE_NO_CLAIM_COVER = "INSURANCE_NO_CLAIM_COVER";
   static final String INSURANCE_LOSS_OF_USE_COVER = "INSURANCE_LOSS_OF_USE_COVER";
   static final String INSURANCE_ENGINE_PROTECTION_COVER = "INSURANCE_ENGINE_PROTECTION_COVER";
   static final String INSURANCE_COC_COVER = "INSURANCE_COC_COVER";
   static final String INSURANCE_RTI_COVER = "INSURANCE_RTI_COVER";
   static final String INSURANCE_CPA_TERM = "INSURANCE_CPA_TERM";
   static final String INSURANCE_TOTAL_PREMIUM = "INSURANCE_TOTAL_PREMIUM";

   static final String INSURANCE_CUSTOMER_TYPE = "INSURANCE_CUSTOMER_TYPE";
   static final String INSURANCE_CUSTOMER_SALUTATION = "INSURANCE_CUSTOMER_SALUTATION";
   static final String INSURANCE_ORGANISATION_NAME = "INSURANCE_ORGANISATION_NAME";
   static final String INSURANCE_CUSTOMER_FNAME = "INSURANCE_CUSTOMER_FNAME";
   static final String INSURANCE_CUSTOMER_LNAME = "INSURANCE_CUSTOMER_LNAME";
   static final String INSURANCE_CUSTOMER_DOB = "INSURANCE_CUSTOMER_DOB";
   static final String INSURANCE_CUSTOMER_MAIL = "INSURANCE_CUSTOMER_MAIL";
   static final String INSURANCE_CUSTOMER_GENDER = "INSURANCE_CUSTOMER_GENDER";
   static final String INSURANCE_CUSTOMER_EIA_NUMBER = "INSURANCE_CUSTOMER_EIA_NUMBER";
   static final String INSURANCE_CUSTOMER_GST_NUMBER = "INSURANCE_CUSTOMER_GST_NUMBER";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_LINE_1 = "INSURANCE_CUSTOMER_COM_ADDRESS_LINE_1";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_LINE_2 = "INSURANCE_CUSTOMER_COM_ADDRESS_LINE_2";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_LINE_3 = "INSURANCE_CUSTOMER_COM_ADDRESS_LINE_3";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_CITY = "INSURANCE_CUSTOMER_COM_ADDRESS_CITY";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_STATE = "INSURANCE_CUSTOMER_COM_ADDRESS_STATE";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_LAND_MARK = "INSURANCE_CUSTOMER_COM_ADDRESS_LAND_MARK";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_PIN_CODE = "INSURANCE_CUSTOMER_COM_ADDRESS_PIN_CODE";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_COUNTRY = "INSURANCE_CUSTOMER_COM_ADDRESS_COUNTRY";
   static final String INSURANCE_CUSTOMER_COM_ADDRESS_STATUS = "INSURANCE_CUSTOMER_COM_ADDRESS_STATUS";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_1 = "INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_1";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_2 = "INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_2";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_3 = "INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_3";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_CITY = "INSURANCE_CUSTOMER_PERM_ADDRESS_CITY";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_STATE = "INSURANCE_CUSTOMER_PERM_ADDRESS_STATE";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_LAND_MARK = "INSURANCE_CUSTOMER_PERM_ADDRESS_LAND_MARK";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_PIN_CODE = "INSURANCE_CUSTOMER_PERM_ADDRESS_PIN_CODE";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_COUNTRY = "INSURANCE_CUSTOMER_PERM_ADDRESS_COUNTRY";
   static final String INSURANCE_CUSTOMER_PERM_ADDRESS_STATUS = "INSURANCE_CUSTOMER_PERM_ADDRESS_STATUS";

   static final String INSURANCE_VEHICLE_REG_NUMBER = "INSURANCE_VEHICLE_REG_NUMBER";
   static final String INSURANCE_VEHICLE_ENGINE_NUMBER = "INSURANCE_VEHICLE_REG_NUMBER";
   static final String INSURANCE_VEHICLE_CHASIS_NUMBER = "INSURANCE_VEHICLE_CHASIS_NUMBER";
   static final String INSURANCE_VEHICLE_REGISTRATION_DATE = "INSURANCE_VEHICLE_REGISTRATION_DATE";
   static final String INSURANCE_VEHICLE_REGISTRATION_YEAR = "INSURANCE_VEHICLE_REGISTRATION_YEAR";
   static final String INSURANCE_VEHICLE_IS_ON_LOAN = "INSURANCE_VEHICLE_IS_ON_LOAN";

   static final String INSURANCE_NOMINEE_FIRST_NAME = "INSURANCE_NOMINEE_FIRST_NAME";
   static final String INSURANCE_NOMINEE_LAST_NAME = "INSURANCE_NOMINEE_LAST_NAME";
   static final String INSURANCE_NOMINEE_GENDER = "INSURANCE_NOMINEE_GENDER";
   static final String INSURANCE_NOMINEE_RELATION = "INSURANCE_NOMINEE_RELATION";
   static final String INSURANCE_NOMINEE_DOB = "INSURANCE_NOMINEE_DOB";
   static final String INSURANCE_APPOINTEE_FIRST_NAME = "INSURANCE_APPOINTEE_FIRST_NAME";
   static final String INSURANCE_APPOINTEE_LAST_NAME = "INSURANCE_APPOINTEE_LAST_NAME";
   static final String INSURANCE_APPOINTEE_GENDER = "INSURANCE_APPOINTEE_GENDER";
   static final String INSURANCE_APPOINTEE_RELATION = "INSURANCE_APPOINTEE_RELATION";
   static final String INSURANCE_APPOINTEE_DOB = "INSURANCE_APPOINTEE_DOB";

   static final String INSURANCE_NCB_PREVIOUS_POLICY_STATUS = "INSURANCE_NCB_PREVIOUS_POLICY_STATUS";
   static final String INSURANCE_NCB_PREVIOUS_POLICY_TYPE = "INSURANCE_NCB_PREVIOUS_POLICY_TYPE";
   static final String INSURANCE_NCB_PERCENTAGE = "INSURANCE_NCB_PERCENTAGE";
   static final String INSURANCE_PREVIOUS_POLICY_DATE = "INSURANCE_PREVIOUS_POLICY_DATE";
   static final String INSURANCE_TOOK_CLAIM = "INSURANCE_TOOK_CLAIM";

   static final String INSURANCE_PREVIOUS_COMPANY_NAME = "INSURANCE_PREVIOUS_COMPANY_NAME";
   static final String INSURANCE_PREVIOUS_START_DATE = "INSURANCE_PREVIOUS_START_DATE";
   static final String INSURANCE_PREVIOUS_POLICY_NUMBER = "INSURANCE_PREVIOUS_POLICY_NUMBER";

   static final String INSURANCE_PAYMENT_RESPONSE = "INSURANCE_PAYMENT_RESPONSE";

   static final String BILL_SERVICE_NAME = "BILL_SERVICE_NAME";
   static final String BILL_BILLER_ID = "BILL_BILLER_ID";
   static final String BILL_BILLER_NAME = "BILL_BILLER_NAME";
   static final String BILL_ORDER_ID = "BILL_ORDER_ID";
   static final String BILL_REQUEST_ID = "BILL_REQUEST_ID";
   static final String BILL_AMOUNT_TO_PAY = "BILL_AMOUNT_TO_PAY";
   static final String BILL_CONVENIENCE_FEE = "BILL_CONVENIENCE_FEE";
   static final String BILL_FETCH_RESPONSE = "BILL_FETCH_RESPONSE";
   static final String BILL_AMOUNT = "BILL_AMOUNT";
   static final String BILL_DATE = "BILL_DATE";
   static final String BILL_NUMBER = "BILL_NUMBER";
   static final String BILL_PERIOD = "BILL_PERIOD";
   static final String BILL_CUSTOMER_NAME = "BILL_CUSTOMER_NAME";
   static final String BILL_DUE_DATE = "BILL_DUE_DATE";
   static final String BILL_CAN_BE_PAID_FROM_WALLET = "BILL_CAN_BE_PAID_FROM_WALLET";

   static final String SHOW_DIGITAL_CARD_ACTIVATION_MSG = "SHOW_DIGITAL_CARD_ACTIVATION_MSG";
   static final String SHOW_CELEBRATION_GIF = "SHOW_CELEBRATION_GIF";

   static final String KEY_AUTOFILL_NAME = "autofill_name";
   static final String KEY_AUTOFILL_GENDER = "autofill_gender";
   static final String KEY_AUTOFILL_DOB = "autofill_dob";
   static final String KEY_AUTOFILL_MARITAL_STATUS = "autofill_marital_status";
   static final String KEY_AUTOFILL_EDUCATION = "autofill_education";
   static final String KEY_AUTOFILL_OCCUPATION = "autofill_OCCUPATION";
   static final String KEY_AUTOFILL_BUSINESS_NAME = "autofill_business_name";
   static final String KEY_AUTOFILL_COMPANY_EMAIL = "autofill_company_email";
   static final String KEY_AUTOFILL_COMPANY_MOBILE = "autofill_company_mobile";
   static final String KEY_AUTOFILL_COMPANY_PAN = "autofill_company_pan";
   static final String KEY_AUTOFILL_COMPANY_ADDRESS = "autofill_company_address";
   static final String KEY_AUTOFILL_INDUSTRY = "autofill_industry_type";
   static final String KEY_AUTOFILL_STATE = "autofill_state_code";
   static final String KEY_AUTOFILL_CITY = "autofill_city";
   static final String KEY_AUTOFILL_PIN = "autofill_pin";

   static final String LENDER_ID = "lender_id";
   static final String SCHEME_ID = "scheme_id";

   static final String MINIMUM_AMOUNT = "minimum_amount";
   static final String MESSAGE = "message";

   static final String PANAUTH = "panAuth";

   // generate order api response
   static final String INVESTMENT_AMOUNT = "investment_amount";
   static final String ORDER_ID = "order_id";
   static final String RAZORPAY_API_KEY = "razorpay_api_key";
   static final String AMOUNT_TRANSCATION_ID = "amount_transcation_id";
   static final String PGTYPE = "pg_type";
   static final String SERVICE = "service";

   //  Razorpay payment success response store
   static final String SUCCESS_ORDER_ID = "success_order_id";
   static final String PAYMENTID = "paymentId";
   static final String SIGNATURE = "signature";

   // after payment status
   static final String INVESTMENT_NO = "investment_no";

   // dashboard investmentNumber
   static final String DS_INVESTMENT_NO='ds_investment_no';



   static final String KEY_AUTOFILL_PROFESSION_TYPE ="autofill_profession_type ";
   static final String KEY_AUTOFILL_NET_WORTH = "autofill_net_worth";
   static final String KEY_AUTOFILL_EXP ="autofill_experience";
   static final String KEY_AUTOFILL_LGROSS_TURNOVER = "autofill_lgross_turnover";
   static final String KEY_AUTOFILL_L2L_GROSS_TURNOVER = "autofill_l2l_gross_turnover";
   static final String KEY_AUTOFILL_OWNERSHIP = "autofill_ownership";
   static final String KEY_AUTOFILL_AUDIT_STATUS = "autofill_audit_status";
   static final String KEY_AUTOFILL_LOAN_DEFAULTER ="autofill_loan_defaulter";
   static final String KEY_AUTOFILL_OWNERSHIP_TYPE = "autofill_ownership_type";
   static final String KEY_AUTOFILL_DOI="autofill_doi";
   static final String KEY_AUTOFILL_DISTRICT = "autofill_district";
   static final String KEY_AUTOFILL_ADDRESS1 = "autofill_address1";
   static final String KEY_AUTOFILL_ADDRESS2 = "autofill_address2";
   static final String KEY_AUTOFILL_COMPANY_GST ="autofill_gst";
   static final String KEY_AUTOFILL_ACCOUNT_NAME="autofill_account_name";
   static final String KEY_AUTOFILL_ACCOUNT_NUMBER="autofill_account_number";
   static final String KEY_AUTOFILL_ACCOUNT_IFSC="autofill_account_ifsc";

   static final String KEY_SELLER_CORPORATE_ID="seller_corporate_id";
   static final String KEY_SELLER_PARTNER_REF_NO="seller_partner_ref_no";
   static final String KEY_SELLER_IDENTIFIER="seller_identifier";
   static final String KEY_SELLER_STATUS="seller_status";
   static final String KEY_SELLER_QR="seller_qr";

   static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

   static late SharedPreferences _pref;

  static Future<void> initialize() async {
    _pref=await SharedPreferences.getInstance();
  }

   void clearPreferences() {
     _pref?.clear();
   }

   void setAutofillData(
       String name,
       String gender,
       String dateOfBirth,
       String maritalStatus,
       String education,
       String occupation,
       String businessName,
       String companyEmail,
       String companyMobile,
       String companyPan,
       String companyAddress,
       String industryType,
       String stateCode,
       String city,
       String pin){

     _pref.setString(KEY_AUTOFILL_NAME, name);
     _pref.setString(KEY_AUTOFILL_GENDER, gender);
     _pref.setString(KEY_AUTOFILL_DOB, dateOfBirth);
     _pref.setString(KEY_AUTOFILL_MARITAL_STATUS, maritalStatus);
     _pref.setString(KEY_AUTOFILL_EDUCATION, education);
     _pref.setString(KEY_AUTOFILL_OCCUPATION, occupation);
     _pref.setString(KEY_AUTOFILL_BUSINESS_NAME, businessName);
     _pref.setString(KEY_AUTOFILL_COMPANY_EMAIL, companyEmail);
     _pref.setString(KEY_AUTOFILL_COMPANY_MOBILE, companyMobile);
     _pref.setString(KEY_AUTOFILL_COMPANY_PAN, companyPan);
     _pref.setString(KEY_AUTOFILL_COMPANY_ADDRESS, companyAddress);
     _pref.setString(KEY_AUTOFILL_INDUSTRY, industryType);
     _pref.setString(KEY_AUTOFILL_STATE, stateCode);
     _pref.setString(KEY_AUTOFILL_CITY, city);
     _pref.setString(KEY_AUTOFILL_PIN, pin);
   }

   void setBusinessLoanAutofill(
       String name,
       String companyEmail,
       String companyMobile,
       String gender,
       String dateOfBirth,
       String maritalStatus,
       String stateCode,
       String city,
       String education,
       String occupation,
       String professionType,
       String netWorth,
       String totalExp,
       String lGrossTurnover,
       String l2lGrossTurnover,
       String ownership,
       String auditStatus,
       String loanDefaulter,
       String companyPan,
       String pin
       ){
     _pref.setString(KEY_AUTOFILL_NAME, name);
     _pref.setString(KEY_AUTOFILL_COMPANY_EMAIL, companyEmail);
     _pref.setString(KEY_AUTOFILL_COMPANY_MOBILE, companyMobile);
     _pref.setString(KEY_AUTOFILL_GENDER, gender);
     _pref.setString(KEY_AUTOFILL_DOB, dateOfBirth);
     _pref.setString(KEY_AUTOFILL_MARITAL_STATUS, maritalStatus);
     _pref.setString(KEY_AUTOFILL_STATE, stateCode);
     _pref.setString(KEY_AUTOFILL_CITY, city);
     _pref.setString(KEY_AUTOFILL_EDUCATION, education);
     _pref.setString(KEY_AUTOFILL_OCCUPATION, occupation);
     _pref.setString(KEY_AUTOFILL_PROFESSION_TYPE, professionType);
     _pref.setString(KEY_AUTOFILL_NET_WORTH, netWorth);
     _pref.setString(KEY_AUTOFILL_EXP, totalExp);
     _pref.setString(KEY_AUTOFILL_LGROSS_TURNOVER, lGrossTurnover);
     _pref.setString(KEY_AUTOFILL_L2L_GROSS_TURNOVER, l2lGrossTurnover);
     _pref.setString(KEY_AUTOFILL_OWNERSHIP, ownership);
     _pref.setString(KEY_AUTOFILL_AUDIT_STATUS, auditStatus);
     _pref.setString(KEY_AUTOFILL_LOAN_DEFAULTER, loanDefaulter);
     _pref.setString(KEY_AUTOFILL_COMPANY_PAN, companyPan);
     _pref.setString(KEY_AUTOFILL_PIN, pin);
   }

   void setSellerAutofill(
       String businessName,
       String companyMobile,
       String companyEmail,
       String industry,
       String ownershipType,
       String dateOfBirth,
       String dateOfIncorporation,
       String city,
       String district,
       String stateCode,
       String address1,
       String address2,
       String companyPan,
       String companyGst,
       String accountName,
       String accountNumber,
       String accountIfsc,
       ){
     _pref.setString(KEY_AUTOFILL_BUSINESS_NAME, businessName);
     _pref.setString(KEY_AUTOFILL_COMPANY_MOBILE, companyMobile);
     _pref.setString(KEY_AUTOFILL_COMPANY_EMAIL, companyEmail);
     _pref.setString(KEY_AUTOFILL_INDUSTRY, industry);
     _pref.setString(KEY_AUTOFILL_OWNERSHIP_TYPE, ownershipType);
     _pref.setString(KEY_AUTOFILL_DOB, dateOfBirth);
     _pref.setString(KEY_AUTOFILL_DOI, dateOfBirth);
     _pref.setString(KEY_AUTOFILL_CITY, city);
     _pref.setString(KEY_AUTOFILL_DISTRICT, district);
     _pref.setString(KEY_AUTOFILL_STATE, stateCode);
     _pref.setString(KEY_AUTOFILL_ADDRESS1, address1);
     _pref.setString(KEY_AUTOFILL_ADDRESS2, address2);
     _pref.setString(KEY_AUTOFILL_COMPANY_PAN, companyPan);
     _pref.setString(KEY_AUTOFILL_COMPANY_GST, companyGst);
     _pref.setString(KEY_AUTOFILL_ACCOUNT_NAME, accountName);
     _pref.setString(KEY_AUTOFILL_ACCOUNT_NUMBER, accountNumber);
     _pref.setString(KEY_AUTOFILL_ACCOUNT_IFSC, accountIfsc);
   }
   void createLoginSession(
       String name,
       String email,
       String maritalStatus,
       String dateOfBirth,
       String gender,
       String occupation,
       String education,
       String income,
       String investInMutualFund,
       String ownAssets,
       ) {
     _pref.setBool(_IS_LOGIN, true);
     _pref.setString(KEY_NAME, name);
     _pref.setString(KEY_EMAIL, email);
     _pref.setString(KEY_MARITAL_STATUS, maritalStatus);
     _pref.setString(KEY_DATE_OF_BIRTH, dateOfBirth);
     _pref.setString(KEY_GENDER, gender);
     _pref.setString(KEY_OCCUPATION, occupation);
     _pref.setString(KEY_EDUCATION, education);
     _pref.setString(KEY_INCOME, income);
     _pref.setString(KEY_INVEST_IN_MUTUAL_FUND, investInMutualFund);
     _pref.setString(KEY_OWN_ASSETS, ownAssets);
   }

   void createSellerCredential(
       String corporateID,
       String partnerReferenceNumber,
       String sellerIdentifier,
       String sellerStatus,
       String qr,
       ) {
     _pref.setString(KEY_SELLER_CORPORATE_ID, corporateID);
     _pref.setString(KEY_SELLER_PARTNER_REF_NO, partnerReferenceNumber);
     _pref.setString(KEY_SELLER_IDENTIFIER, sellerIdentifier);
     _pref.setString(KEY_SELLER_STATUS, sellerStatus);
     _pref.setString(KEY_SELLER_QR, qr);
   }

   void setSellerIdentifier(String sellerIdentifier) {
     _pref.setString(KEY_SELLER_IDENTIFIER, sellerIdentifier);
   }

   String getSellerIdentifier() {
     return _pref.getString(KEY_SELLER_IDENTIFIER) ?? 'null';
   }

   void createMiniAccountDetails(String panNumber) {
     _pref.setString(KEY_PAN_CARD, panNumber);
   }


   void setShowDigitalCardActivationMsg(bool shouldShow) {
     _pref.setBool(SHOW_DIGITAL_CARD_ACTIVATION_MSG, shouldShow);
   }

   void setShowCelebrationGif(bool shouldShow) {
     _pref.setBool(SHOW_CELEBRATION_GIF, shouldShow);
   }

   bool shouldShowCelebrationGIf() {
     return _pref.getBool(SHOW_CELEBRATION_GIF) ?? true;
   }

   void setPaymentPin(String paymentPin) {
     _pref.setString(KEY_PAYMENT_PIN, paymentPin);
   }

   String? getPaymentPin() {
     return _pref.getString(KEY_PAYMENT_PIN);
   }

   bool shouldShowDigitalCardActivationMsg() {
     return _pref.getBool(SHOW_DIGITAL_CARD_ACTIVATION_MSG) ?? true;
   }

   Map<dynamic, dynamic> getUserDetails() {
    Map user={
      _IS_LOGIN: _pref.getBool('IsLoggedIn') ?? false,
      KEY_NAME: _pref.getString(KEY_NAME),
      KEY_MOBILE: _pref.getString(KEY_MOBILE),
      KEY_EMAIL: _pref.getString(KEY_EMAIL),
      KEY_MARITAL_STATUS: _pref.getString(KEY_MARITAL_STATUS),
      KEY_DATE_OF_BIRTH: _pref.getString(KEY_DATE_OF_BIRTH),
      KEY_OCCUPATION: _pref.getString(KEY_OCCUPATION),
      KEY_EDUCATION: _pref.getString(KEY_EDUCATION),
      KEY_INCOME: _pref.getString(KEY_INCOME),
      KEY_INVEST_IN_MUTUAL_FUND: _pref.getString(KEY_INVEST_IN_MUTUAL_FUND),
      KEY_OWN_ASSETS: _pref.getString(KEY_OWN_ASSETS)
     };
    return user;
   }

   Map<dynamic, dynamic> getSellerCredential(){
     Map seller={
     KEY_SELLER_CORPORATE_ID: _pref.getString(KEY_SELLER_CORPORATE_ID)??'',
     KEY_SELLER_PARTNER_REF_NO: _pref.getString(KEY_SELLER_PARTNER_REF_NO)??'',
     KEY_SELLER_IDENTIFIER: _pref.getString(KEY_SELLER_IDENTIFIER)??'',
     KEY_SELLER_STATUS: _pref.getString(KEY_SELLER_STATUS)??'',
     KEY_SELLER_QR: _pref.getString(KEY_SELLER_QR)??''
     };
     return seller;
   }
   Map<dynamic, dynamic> getAutofillDetails() {
    Map user={
      KEY_AUTOFILL_NAME: _pref.getString(KEY_AUTOFILL_NAME),
      KEY_AUTOFILL_BUSINESS_NAME: _pref.getString(KEY_AUTOFILL_BUSINESS_NAME),
      KEY_AUTOFILL_GENDER: _pref.getString(KEY_AUTOFILL_GENDER),
      KEY_AUTOFILL_DOB: _pref.getString(KEY_AUTOFILL_DOB),
      KEY_AUTOFILL_MARITAL_STATUS: _pref.getString(KEY_AUTOFILL_MARITAL_STATUS),
      KEY_AUTOFILL_EDUCATION: _pref.getString(KEY_AUTOFILL_EDUCATION),
      KEY_AUTOFILL_OCCUPATION: _pref.getString(KEY_AUTOFILL_OCCUPATION),
      KEY_AUTOFILL_COMPANY_EMAIL: _pref.getString(KEY_AUTOFILL_COMPANY_EMAIL),
      KEY_AUTOFILL_COMPANY_MOBILE: _pref.getString(KEY_AUTOFILL_COMPANY_MOBILE),
      KEY_AUTOFILL_COMPANY_PAN: _pref.getString(KEY_AUTOFILL_COMPANY_PAN),
      KEY_AUTOFILL_COMPANY_ADDRESS: _pref.getString(KEY_AUTOFILL_COMPANY_ADDRESS),
      KEY_AUTOFILL_INDUSTRY: _pref.getString(KEY_AUTOFILL_INDUSTRY),
      KEY_AUTOFILL_STATE: _pref.getString(KEY_AUTOFILL_STATE),
      KEY_AUTOFILL_CITY: _pref.getString(KEY_AUTOFILL_CITY),
      KEY_AUTOFILL_PIN: _pref.getString(KEY_AUTOFILL_PIN),
      KEY_AUTOFILL_PROFESSION_TYPE: _pref.getString(KEY_AUTOFILL_PROFESSION_TYPE),
      KEY_AUTOFILL_NET_WORTH: _pref.getString(KEY_AUTOFILL_NET_WORTH),
      KEY_AUTOFILL_EXP: _pref.getString(KEY_AUTOFILL_EXP),
      KEY_AUTOFILL_LGROSS_TURNOVER: _pref.getString(KEY_AUTOFILL_LGROSS_TURNOVER),
      KEY_AUTOFILL_L2L_GROSS_TURNOVER: _pref.getString(KEY_AUTOFILL_L2L_GROSS_TURNOVER),
      KEY_AUTOFILL_OWNERSHIP: _pref.getString(KEY_AUTOFILL_OWNERSHIP),
      KEY_AUTOFILL_AUDIT_STATUS: _pref.getString(KEY_AUTOFILL_PIN),
      KEY_AUTOFILL_LOAN_DEFAULTER: _pref.getString(KEY_AUTOFILL_LOAN_DEFAULTER),
      KEY_AUTOFILL_OWNERSHIP_TYPE: _pref.getString(KEY_AUTOFILL_OWNERSHIP_TYPE),
      KEY_AUTOFILL_DOI: _pref.getString(KEY_AUTOFILL_DOI),
      KEY_AUTOFILL_DISTRICT: _pref.getString(KEY_AUTOFILL_DISTRICT),
      KEY_AUTOFILL_ADDRESS1: _pref.getString(KEY_AUTOFILL_ADDRESS1),
      KEY_AUTOFILL_ADDRESS2: _pref.getString(KEY_AUTOFILL_ADDRESS2),
      KEY_AUTOFILL_COMPANY_GST: _pref.getString(KEY_AUTOFILL_COMPANY_GST),
      KEY_AUTOFILL_ACCOUNT_NAME: _pref.getString(KEY_AUTOFILL_ACCOUNT_NAME),
      KEY_AUTOFILL_ACCOUNT_NUMBER: _pref.getString(KEY_AUTOFILL_ACCOUNT_NUMBER),
       KEY_AUTOFILL_ACCOUNT_IFSC: _pref.getString(KEY_AUTOFILL_ACCOUNT_IFSC),
   };
    return user;
   }

   Map<dynamic, dynamic> getPanDetails(){
    Map user={
      _IS_LOGIN: _pref.getBool(_IS_LOGIN) ?? false,
      KEY_PAN_CARD: _pref.getString(KEY_PAN_CARD)
    };
    return user;
   }

   void addMobile(String mobile){
      _pref.setString(KEY_MOBILE, mobile);
   }

   void addPanCard(String panNumber){
      _pref.setString(KEY_PAN_CARD, panNumber);
   }
   void addProfilePic(String imageUrl){
      _pref.setString(KEY_PROFILE_PIC, imageUrl);
   }
   void addSelfiePic(String imageUrl){
      _pref.setString(KEY_SELFIE_PIC, imageUrl);
   }
   void addContact(String name){
      _pref.setString(KEY_CONTACT, name);
   }
   void addContactName(String name){
      _pref.setString(KEY_CONTACT_NAME, name);
   }
   void addReferrerCode(String referral_code){
      _pref.setString(KEY_REFERRER_CODE, referral_code);
   }
   void addKYCSTATUS(String kycStatus){
      _pref.setString(_KEY_KYC_STATUS, kycStatus);
   }
   String? getKeyReferrerCode(){
    return KEY_REFERRER_CODE;
   }
   void addSelectedBeneficiaryMobile(String mobile){
      _pref.setString(KEY_MOBILE, mobile);
   }
   void addToken(String token){
      _pref.setString(KEY_TOKEN, token);
   }

   void addCorporateID(String corporateID){
      _pref.setString(KEY_CORPORATE_ID, corporateID);
   }

   void addSellerID(String sellerID){
      _pref.setString(KEY_SELLER_ID, sellerID);
   }

   String? getKYC() {
     return _pref.getString(_KEY_KYC_STATUS) ?? 'null';
   }

   String? getToken() {
     return _pref.getString(KEY_TOKEN) ?? 'null';
   }

   String? getCorporateID() {
     return _pref.getString(KEY_CORPORATE_ID) ?? 'null';
   }

   String getSellerID() {
     return _pref.getString(KEY_SELLER_ID) ?? 'null';
   }

   String? getMobile(){
    return _pref.getString(KEY_MOBILE);
   }

   String? getUserEmail(){
     return _pref.getString(KEY_EMAIL);
   }

   String? getName(){
     return _pref.getString(KEY_NAME);
   }
   String? getProfilePic(){
    return _pref.getString(KEY_PROFILE_PIC);
   }
   String? getSelfiePic(){
    return _pref.getString(KEY_SELFIE_PIC);
   }
   String? getUserGender(){
    return _pref.getString(KEY_GENDER);
   }
   String? getMailId(){
    return _pref.getString(KEY_EMAIL);
   }
   String? getPAN_Card(){
    return _pref.getString(KEY_PAN_CARD);
   }
   String? getContact(){
    return _pref.getString(KEY_CONTACT);
   }
   String? getContactName(){
    return _pref.getString(KEY_CONTACT_NAME);
   }
   String? getSelectedBeneficiaryMobile(){
    return _pref.getString(KEY_MOBILE);
   }

   void addBeneficiaryName(String beneficiary_name){
    _pref.setString(KEY_BENEFICIARY_NAME, beneficiary_name);
   }

   String? getBeneficiaryName(){
    return _pref.getString(KEY_BENEFICIARY_NAME);
   }

   void addnoaadhar(String addnoaadhar) {
    _pref.setString(KEY_NO_AADHAR_KYC_DONE, addnoaadhar);
   }

   String? getKeyNoAadharKycDone(){
    return _pref.getString(KEY_NO_AADHAR_KYC_DONE);
   }

   void addBeneficiaryWalletName(String beneficiary_name) {
     _pref.setString(KEY_WALLET_BENEFICIARY_NAME, beneficiary_name);
   }

   String? getWalletBeneficiaryName() {
     return _pref.getString(KEY_WALLET_BENEFICIARY_NAME);
   }


   void addBeneficiaryType(String beneficiary_type) {
     _pref.setString(KEY_BENEFICIARY_TYPE, beneficiary_type);
   }

   String? getBeneficiaryType() {
     return _pref.getString(KEY_BENEFICIARY_TYPE);
   }

   void addAccountNumber(String account_number) {
     _pref.setString(KEY_ACCOUNT_NUMBER, account_number);
   }

   String? getAccountNumber() {
     return _pref.getString(KEY_ACCOUNT_NUMBER);
   }

   void addIFSCCode(String ifsc_code) {
     _pref.setString(KEY_IFSC_CODE, ifsc_code);
   }

   String? getIFSCCode() {
     return _pref.getString(KEY_IFSC_CODE);
   }

   void addBeneficiaryId(String beneficiary_id) {
     _pref.setString(KEY_BENEFICIARY_ID, beneficiary_id);
   }

   void addVPABeneficiaryId(String vpa_beneficiary_id) {
     _pref.setString(KEY_VPA_BENEFICIARY_ID, vpa_beneficiary_id);

   }

   String? getVPABeneficiaryId() {
     return _pref.getString(KEY_VPA_BENEFICIARY_ID);
   }

   void addWalletBeneficiaryId(String wallet_beneficiary_id) {
     _pref.setString(KEY_WALLET_BENEFICIARY_ID, wallet_beneficiary_id);

   }

   String? getBeneficiaryId() {
     return _pref.getString(KEY_BENEFICIARY_ID);
   }

   String? getWalletBeneficiaryId() {
     return _pref.getString(KEY_WALLET_BENEFICIARY_ID);
   }

   void addMonthlyLimitAvailed(String monthly_limit_availed) {
     _pref.setString(KEY_MONTHLY_LIMIT_AVAILED, monthly_limit_availed);

   }

   String? getMonthlyLimitAvailed() {
     return _pref.getString(KEY_MONTHLY_LIMIT_AVAILED);
   }

   void addClick(String clickpage) {
     _pref.setString(KEY_PAGE_NAME, clickpage);

   }

   String? getClick() {
     return _pref.getString(KEY_PAGE_NAME);
   }

   void addMaximumPermissibleLimit(String maximum_permissible_limit) {
     _pref.setString(KEY_MAX_PERMISSIBLE_LIMIT, maximum_permissible_limit);

   }

   String? getMaximumPermissibleLimit() {
     return _pref.getString(KEY_MAX_PERMISSIBLE_LIMIT);
   }


   void addUserName(String userName) {
     _pref.setString(KEY_NAME, userName);

   }

   String? getUserName() {
     return _pref.getString(KEY_NAME);
   }

   void setIsNotFirstTime(bool firstTime) {
     _pref.setBool(IS_NOT_FIRST_TIME, firstTime);

   }

   bool getIsNotFirstTime() {
     return _pref.getBool(IS_NOT_FIRST_TIME) ?? false;
   }

   bool userLoggedIn() {
     return _pref.getBool(_IS_LOGIN) ?? false;
   }

   void addVerificationToken(String token) {
     _pref.setString(KEY_VERIFICATION_TOKEN, token);

   }

   void addInsuranceToken(String token) {
     _pref.setString(KEY_INSURANCE_TOKEN, token);

   }

   void addInsuranceTransactionID(String transactionID) {
     _pref.setString(INSURANCE_TRANSACTION_ID, transactionID);

   }

   void addInsuranceBasicDetails(String productCode,
       String rtoCode,
       String vehicleCode,
       String vehicleRegistrationDate,
       String policyStartDate,
       String policyType,
       int vehicleLife,
       String businessType,
       String policyTenure,
       double IDV_AMOUNT,
       double MAX_IDV_AMOUNT,
       double MIN_IDV_AMOUNT,
       String vehicleType) {

     _pref.setString(INSURANCE_PRODUCT_CODE, productCode);
     _pref.setString(INSURANCE_RTO_CODE, rtoCode);
     _pref.setString(INSURANCE_VEHICLE_CODE, vehicleCode);
     _pref.setString(INSURANCE_VEHICLE_REGISTRATION, vehicleRegistrationDate);
     _pref.setString(INSURANCE_POLICY_START_DATE, policyStartDate);
     _pref.setString(INSURANCE_POLICY_TYPE, policyType);
     _pref.setString(INSURANCE_BUSINESS_TYPE, businessType);
     _pref.setDouble(INSURANCE_IDV_AMOUNT, IDV_AMOUNT);
     _pref.setDouble(INSURANCE_MAX_IDV_AMOUNT, MAX_IDV_AMOUNT);
     _pref.setDouble(INSURANCE_MIN_IDV_AMOUNT, MIN_IDV_AMOUNT);
     _pref.setString(INSURANCE_POLICY_TENURE, policyTenure);
     _pref.setString(INSURANCE_VEHICLE_TYPE, vehicleType);

   }

   Map<dynamic, dynamic> getInsuranceBasicDetails() {

     Map insuranceBasicDetails = {
       INSURANCE_PRODUCT_CODE: _pref.getString(INSURANCE_PRODUCT_CODE),
       INSURANCE_RTO_CODE: _pref.getString(INSURANCE_RTO_CODE),
       INSURANCE_VEHICLE_CODE: _pref.getString(INSURANCE_VEHICLE_CODE),
       INSURANCE_VEHICLE_REGISTRATION: _pref.getString(INSURANCE_VEHICLE_REGISTRATION),
       INSURANCE_POLICY_START_DATE: _pref.getString(INSURANCE_POLICY_START_DATE),
       INSURANCE_POLICY_TYPE: _pref.getString(INSURANCE_POLICY_TYPE),
       INSURANCE_VEHICLE_LIFE: _pref.getInt(INSURANCE_VEHICLE_LIFE) ?? 0,
       INSURANCE_BUSINESS_TYPE: _pref.getString(INSURANCE_BUSINESS_TYPE),
       INSURANCE_POLICY_TENURE: _pref.getString(INSURANCE_POLICY_TENURE),
       INSURANCE_IDV_AMOUNT: _pref.getDouble(INSURANCE_IDV_AMOUNT) ?? 0,
       INSURANCE_MAX_IDV_AMOUNT: _pref.getDouble(INSURANCE_MAX_IDV_AMOUNT)?? 0,
       INSURANCE_MIN_IDV_AMOUNT: _pref.getDouble(INSURANCE_MIN_IDV_AMOUNT)?? 0,
       INSURANCE_VEHICLE_TYPE: _pref.getString(INSURANCE_VEHICLE_TYPE)
     };

     return insuranceBasicDetails;

   }

   void addInsurancePremiumDetails(String drivingLicense,
       String optEaCover,
       String optZeroDeptCvr,
       String optNcbClaimCover,
       String optLossOfUseCover,
       String optEngineProtectionCover,
       String optCocCover,
       String optRtiCover,
       String cpaTerm,
       String totalPremium) {


     _pref.setString(INSURANCE_DRIVING_LICENSE, drivingLicense);
     _pref.setString(INSURANCE_EA_COVER, optEaCover);
     _pref.setString(INSURANCE_ZERO_DEBT_COVER, optZeroDeptCvr);
     _pref.setString(INSURANCE_NO_CLAIM_COVER, optNcbClaimCover);
     _pref.setString(INSURANCE_LOSS_OF_USE_COVER, optLossOfUseCover);
     _pref.setString(INSURANCE_ENGINE_PROTECTION_COVER, optEngineProtectionCover);
     _pref.setString(INSURANCE_COC_COVER, optCocCover);
     _pref.setString(INSURANCE_RTI_COVER, optRtiCover);
     _pref.setString(INSURANCE_CPA_TERM, cpaTerm);
     _pref.setString(INSURANCE_TOTAL_PREMIUM, totalPremium);



   }


   Map<dynamic, dynamic> getInsurancePremiumDetails() {
     Map insurancePremiumDetails = {
       INSURANCE_DRIVING_LICENSE: _pref.getString(INSURANCE_DRIVING_LICENSE),
       INSURANCE_EA_COVER: _pref.getString(INSURANCE_EA_COVER),
       INSURANCE_ZERO_DEBT_COVER: _pref.getString(INSURANCE_ZERO_DEBT_COVER),
       INSURANCE_NO_CLAIM_COVER: _pref.getString(INSURANCE_NO_CLAIM_COVER),
       INSURANCE_LOSS_OF_USE_COVER: _pref.getString(INSURANCE_LOSS_OF_USE_COVER),
       INSURANCE_ENGINE_PROTECTION_COVER: _pref.getString(INSURANCE_ENGINE_PROTECTION_COVER),
       INSURANCE_COC_COVER: _pref.getString(INSURANCE_COC_COVER),
       INSURANCE_RTI_COVER: _pref.getString(INSURANCE_RTI_COVER),
       INSURANCE_CPA_TERM: _pref.getString(INSURANCE_CPA_TERM),
       INSURANCE_TOTAL_PREMIUM: _pref.getString(INSURANCE_TOTAL_PREMIUM)
     };
     return insurancePremiumDetails;

   }

   void addInsuranceProposerDetails(String strCustomerType,
       String strSalutation,
       String organisationName,
       String strCustomerFName,
       String strCustomerLName,
       String strCustomerDob,
       String strCustomerEmail,
       String strGender,
       String strEIANumber,
       String strGSTNumber,
       String strCustomerCommunicationAddressLine1,
       String strCustomerCommunicationAddressLine2,
       String strCustomerCommunicationAddressLine3,
       String strCustomerCommunicationAddressCity,
       String strCustomerCommunicationAddressState,
       String strCustomerCommunicationAddressLandMark,
       String strCustomerCommunicationAddressPinCode,
       String strCustomerCommunicationAddressCountry,
       String strCommunicationStatus,
       String strCustomerPermanentAddressLine1,
       String strCustomerPermanentAddressLine2,
       String strCustomerPermanentAddressLine3,
       String strCustomerPermanentAddressCity,
       String strCustomerPermanentAddressState,
       String strCustomerPermanentAddressLandMark,
       String strCustomerPermanentAddressPinCode,
       String strCustomerPermanentAddressCountry,
       String strPermanentStatus) {


     _pref.setString(INSURANCE_CUSTOMER_TYPE, strCustomerType);
     _pref.setString(INSURANCE_CUSTOMER_SALUTATION, strSalutation);
     _pref.setString(INSURANCE_ORGANISATION_NAME, organisationName);
     _pref.setString(INSURANCE_CUSTOMER_FNAME, strCustomerFName);
     _pref.setString(INSURANCE_CUSTOMER_LNAME, strCustomerLName);
     _pref.setString(INSURANCE_CUSTOMER_DOB, strCustomerDob);
     _pref.setString(INSURANCE_CUSTOMER_MAIL, strCustomerEmail);
     _pref.setString(INSURANCE_CUSTOMER_GENDER, strGender);
     _pref.setString(INSURANCE_CUSTOMER_EIA_NUMBER, strEIANumber);
     _pref.setString(INSURANCE_CUSTOMER_GST_NUMBER, strGSTNumber);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_LINE_1, strCustomerCommunicationAddressLine1);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_LINE_2, strCustomerCommunicationAddressLine2);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_LINE_3, strCustomerCommunicationAddressLine3);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_CITY, strCustomerCommunicationAddressCity);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_STATE, strCustomerCommunicationAddressState);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_LAND_MARK, strCustomerCommunicationAddressLandMark);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_PIN_CODE, strCustomerCommunicationAddressPinCode);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_COUNTRY, strCustomerCommunicationAddressCountry);
     _pref.setString(INSURANCE_CUSTOMER_COM_ADDRESS_STATUS, strCommunicationStatus);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_1, strCustomerPermanentAddressLine1);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_2, strCustomerPermanentAddressLine2);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_LINE_3, strCustomerPermanentAddressLine3);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_CITY, strCustomerPermanentAddressCity);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_STATE, strCustomerPermanentAddressState);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_LAND_MARK, strCustomerPermanentAddressLandMark);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_PIN_CODE, strCustomerPermanentAddressPinCode);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_COUNTRY, strCustomerPermanentAddressCountry);
     _pref.setString(INSURANCE_CUSTOMER_PERM_ADDRESS_STATUS, strPermanentStatus);


   }

   void addInsuranceVehicleDetails(String strVehicleRegNumber,
       String strEngineNumber,
       String strChasisNumber,
       String strRegDate,
       String strManufacturingYear,
       String isVehicleOnLoan) {

     _pref.setString(INSURANCE_VEHICLE_REG_NUMBER, strVehicleRegNumber);
     _pref.setString(INSURANCE_VEHICLE_ENGINE_NUMBER, strEngineNumber);
     _pref.setString(INSURANCE_VEHICLE_CHASIS_NUMBER, strChasisNumber);
     _pref.setString(INSURANCE_VEHICLE_REGISTRATION_DATE, strRegDate);
     _pref.setString(INSURANCE_VEHICLE_REGISTRATION_YEAR, strManufacturingYear);
     _pref.setString(INSURANCE_VEHICLE_IS_ON_LOAN, isVehicleOnLoan);



   }

   void addInsuranceNomineeDetails(String strNomineeFirstName,
       String strNomineeLastName,
       String strNomineeGender,
       String strNomineeRelation,
       String strNomineeDob,
       String strAppointeeFirstName,
       String strAppointeeLastName,
       String strAppointeeGender,
       String strAppointeeRelation,
       String strAppointeeDob) {

     _pref.setString(INSURANCE_NOMINEE_FIRST_NAME, strNomineeFirstName);
     _pref.setString(INSURANCE_NOMINEE_LAST_NAME, strNomineeLastName);
     _pref.setString(INSURANCE_NOMINEE_GENDER, strNomineeGender);
     _pref.setString(INSURANCE_NOMINEE_RELATION, strNomineeRelation);
     _pref.setString(INSURANCE_NOMINEE_DOB, strNomineeDob);
     _pref.setString(INSURANCE_APPOINTEE_FIRST_NAME, strAppointeeFirstName);
     _pref.setString(INSURANCE_APPOINTEE_LAST_NAME, strAppointeeLastName);
     _pref.setString(INSURANCE_APPOINTEE_GENDER, strAppointeeGender);
     _pref.setString(INSURANCE_APPOINTEE_RELATION, strAppointeeRelation);
     _pref.setString(INSURANCE_APPOINTEE_DOB, strAppointeeDob);


   }


   void addInsuranceNCBDetails(String strPrevPolicyStatus,
       String strPrevPolicyEndDate,
       String strPrevPolicyType,
       String strTookClaim,
       String strNcbPercent) {

     _pref.setString(INSURANCE_NCB_PREVIOUS_POLICY_STATUS, strPrevPolicyStatus);
     _pref.setString(INSURANCE_PREVIOUS_POLICY_DATE, strPrevPolicyEndDate);
     _pref.setString(INSURANCE_NCB_PREVIOUS_POLICY_TYPE, strPrevPolicyType);
     _pref.setString(INSURANCE_TOOK_CLAIM, strTookClaim);
     _pref.setString(INSURANCE_NCB_PERCENTAGE, strNcbPercent);

   }

   void addPreviousInsuranceDetails(String strPreviousInsuranceCompany,
       String strPrevPolicyNumber,
       String strPreviousPolicyStartDate) {


     _pref.setString(INSURANCE_PREVIOUS_COMPANY_NAME, strPreviousInsuranceCompany);
     _pref.setString(INSURANCE_PREVIOUS_POLICY_NUMBER, strPrevPolicyNumber);
     _pref.setString(INSURANCE_PREVIOUS_START_DATE, strPreviousPolicyStartDate);


   }

   String? getInsuranceTransactionID() {
     return _pref.getString(INSURANCE_TRANSACTION_ID);
   }

   void addInsurancePaymentResponse(String paymentResponse) {
     _pref.setString(INSURANCE_PAYMENT_RESPONSE, paymentResponse);

   }

   String? getInsuranceToken() {
     return _pref.getString(KEY_INSURANCE_TOKEN);
   }

   String? getInsuranceProductCode() {
     return _pref.getString(INSURANCE_PRODUCT_CODE);
   }

   String? getInsuranceRtoCode() {
     return _pref.getString(INSURANCE_RTO_CODE);
   }

   String? getInsuranceVehicleCode() {
     return _pref.getString(INSURANCE_VEHICLE_CODE);
   }

   String? getInsuranceVehicleRegistration() {
     return _pref.getString(INSURANCE_VEHICLE_REGISTRATION);
   }

   String? getInsurancePolicyStartDate() {
     return _pref.getString(INSURANCE_POLICY_START_DATE);
   }

   String? getInsurancePolicyType() {
     return _pref.getString(INSURANCE_POLICY_TYPE);
   }

   int? getInsuranceVehicleLife() {
     return _pref.getInt(INSURANCE_VEHICLE_LIFE)?? 0;
   }

   String? getInsuranceBusinessType() {
     return _pref.getString(INSURANCE_BUSINESS_TYPE);
   }

   String? getInsurancePolicyTenure() {
     return _pref.getString(INSURANCE_POLICY_TENURE);
   }

   double getInsuranceIdvAmount() {
     return _pref.getDouble(INSURANCE_IDV_AMOUNT)?? 0;
   }

   double getInsuranceMaxIdvAmount() {
     return _pref.getDouble(INSURANCE_MAX_IDV_AMOUNT)?? 0;
   }

   double getInsuranceMinIdvAmount() {
     return _pref.getDouble(INSURANCE_MIN_IDV_AMOUNT)?? 0;
   }

   String? getInsuranceVehicleType() {
     return _pref.getString(INSURANCE_VEHICLE_TYPE);
   }


   String? getVerificationToken() {
     return _pref.getString(KEY_VERIFICATION_TOKEN);
   }

   String? getNcbPercentage() {
     return _pref.getString(INSURANCE_NCB_PERCENTAGE);
   }

   String? getInsurancePreviousPolicyDate() {
     return _pref.getString(INSURANCE_PREVIOUS_POLICY_DATE);
   }

   String? getInsuranceTookClaim() {
     return _pref.getString(INSURANCE_TOOK_CLAIM);
   }


   void logOutUser() {

     _pref.clear();

   }


   void saveUserBalance(double balance) {
     _pref.setString(KEY_WALLET_BALANCE, balance.toString());

   }

   double getSavedBalance() {
     return double.parse(_pref.getString(KEY_WALLET_BALANCE)?? "0");
   }

   void addBillRepaymentParameters(String serviceName,
       String billerId,
       String billerName,
       String orderId,
       String requestId,
       Double totalAmountToPay,
       dynamic customerConvenienceFees,
       String billFetchResponse,
       Double billAmount,
       String billDate,
       String billNumber,
       String billPeriod,
       String customerName,
       String dueDate,
       bool canBePaidFromWallet) {


     _pref.setString(BILL_SERVICE_NAME, serviceName);
     _pref.setString(BILL_BILLER_ID, billerId);
     _pref.setString(BILL_BILLER_NAME, billerName);
     _pref.setString(BILL_ORDER_ID, orderId);
     _pref.setString(BILL_REQUEST_ID, requestId);
     _pref.setString(BILL_AMOUNT_TO_PAY, totalAmountToPay.toString());
     _pref.setString(BILL_CONVENIENCE_FEE, customerConvenienceFees.toString());
     _pref.setString(BILL_FETCH_RESPONSE, billFetchResponse);
     _pref.setString(BILL_AMOUNT, billAmount.toString());
     _pref.setString(BILL_DATE, billDate);
     _pref.setString(BILL_NUMBER, billNumber);
     _pref.setString(BILL_PERIOD, billPeriod);
     _pref.setString(BILL_CUSTOMER_NAME, customerName);
     _pref.setString(BILL_DUE_DATE, dueDate);
     _pref.setBool(BILL_CAN_BE_PAID_FROM_WALLET, canBePaidFromWallet);

   }


   Map<dynamic, dynamic> getBillPaymentParams() {

     Map billMap = {

       BILL_SERVICE_NAME: _pref.getString(BILL_SERVICE_NAME)?? "-",
       BILL_BILLER_ID: _pref.getString(BILL_BILLER_ID)?? "-",
       BILL_BILLER_NAME: _pref.getString(BILL_BILLER_NAME)?? "-",
       BILL_ORDER_ID: _pref.getString(BILL_ORDER_ID)?? "-",
       BILL_REQUEST_ID: _pref.getString(BILL_REQUEST_ID)?? "-",
       BILL_AMOUNT_TO_PAY: double.parse(_pref.getString(BILL_AMOUNT_TO_PAY)?? "-"),
       BILL_CONVENIENCE_FEE: _pref.getString(BILL_CONVENIENCE_FEE)?? "-",
       BILL_FETCH_RESPONSE: json.decode(_pref.getString(BILL_FETCH_RESPONSE)!),
       BILL_AMOUNT: double.parse(_pref.getString(BILL_AMOUNT)?? "-"),
       BILL_DATE: _pref.getString(BILL_DATE)?? "-",
       BILL_NUMBER: _pref.getString(BILL_NUMBER)?? "-",
       BILL_PERIOD: _pref.getString(BILL_PERIOD)?? "-",
       BILL_CUSTOMER_NAME: _pref.getString(BILL_CUSTOMER_NAME)?? "-",
       BILL_DUE_DATE: _pref.getString(BILL_DUE_DATE)?? "-",
       BILL_CAN_BE_PAID_FROM_WALLET: _pref.getBool(BILL_CAN_BE_PAID_FROM_WALLET)?? true
     };

     return billMap;
   }



   void addSchemeDetails(dynamic scheme_id,String? minimum_amount){
     _pref.setString(SCHEME_ID,scheme_id);
     _pref.setString(MINIMUM_AMOUNT,minimum_amount??'');
   }

   void addLenderId(String lender_id){
    _pref.setString(LENDER_ID,lender_id);
   }

   void addAntTxnId(String txn_id){
     _pref.setString(AMOUNT_TRANSCATION_ID,txn_id);
   }

   void addMessage(String message){
     _pref.setString(MESSAGE,message);
   }

   void addPanAuth(String panAuth ){
     _pref.setString(PANAUTH,panAuth);
   }

   String? getPanAuth(){
     return _pref.getString(PANAUTH);
   }


   String? getMessage(){
     return _pref.getString(MESSAGE);
   }

   String? getLenderId(){
     return _pref.getString(LENDER_ID);
   }

   dynamic? getSchemeID(){
     return _pref.getString(SCHEME_ID);
   }

   String? getMinimumAmount(){
     return _pref.getString(MINIMUM_AMOUNT);
   }



   void addGnerateOrderResponse(String investment_amount,
       String order_id,
       String razorpay_api_key,
       String amount_transcation_id,
       String pg_type,
       String service,
     ) {

     _pref.setString(INVESTMENT_AMOUNT, investment_amount);
     _pref.setString(ORDER_ID, order_id);
     _pref.setString(RAZORPAY_API_KEY, razorpay_api_key);
     _pref.setString(AMOUNT_TRANSCATION_ID, amount_transcation_id);
     _pref.setString(PGTYPE, pg_type);
     _pref.setString(SERVICE, service);
   }






   Map<dynamic, dynamic> getGenerateOrderResponse() {

     Map generateOrderDetailsGet = {
       INVESTMENT_AMOUNT: _pref.getString(INVESTMENT_AMOUNT),
       ORDER_ID: _pref.getString(ORDER_ID),
       RAZORPAY_API_KEY: _pref.getString(RAZORPAY_API_KEY),
       AMOUNT_TRANSCATION_ID: _pref.getString(AMOUNT_TRANSCATION_ID),
       PGTYPE: _pref.getString(PGTYPE),
       SERVICE: _pref.getString(SERVICE),

     };
     return generateOrderDetailsGet;

   }

   void addPaymentSuccessDetails(String success_order_id,
       String paymentId,
       String signature,
       ) {
     _pref.setString(SUCCESS_ORDER_ID, success_order_id);
     _pref.setString(PAYMENTID, paymentId);
     _pref.setString(SIGNATURE, signature);
   }

   String? getSuccessOrderId(){
     return _pref.getString(SUCCESS_ORDER_ID);
   }

   String? getAntTxnId(){
     return _pref.getString(AMOUNT_TRANSCATION_ID)??'null';
   }

   String? getPaymentId(){
     return _pref.getString(PAYMENTID);
   }

   String? getSignature(){
     return _pref.getString(SIGNATURE);
   }

   void addInvestmentNumber(String investmentNo ){
     _pref.setString(INVESTMENT_NO,investmentNo);
   }

   String? getInvestmentNumber(){
     return _pref.getString(INVESTMENT_NO);
   }

   void addDsInvestmentNumber(String DsInvestmentNo ){
     _pref.setString(DS_INVESTMENT_NO,DsInvestmentNo);
   }

   String? getDsinvestmentNumber(){
     return _pref.getString(DS_INVESTMENT_NO);
   }

}