import 'package:antpay_lite/model/payment/generateRazorpayorderBean.dart';
import 'package:antpay_lite/model/wallet/AadhaarCardRequest.dart';
import 'package:antpay_lite/model/wallet/PanKYCResponseModel.dart';
import 'package:antpay_lite/model/wallet/RegUserVerifyRequestModel.dart';
import 'package:dio/dio.dart' hide Headers;

import 'package:retrofit/retrofit.dart';

import '../../model/login/profile_data.dart';
import '../../model/login/user_name_model.dart';
import '../../model/offer/homebanner.dart';
import '../../model/offer/offer_details_by_category_model.dart';
import '../../model/offer/offer_details_model.dart';
import '../../model/offer/offers_model.dart';
import '../../model/otp/otp_model.dart';
import '../../model/transaction/transaction_history_model.dart';
import '../../model/wallet/FetchCardInfoRequestModel.dart';
import '../../model/wallet/FetchCardInfoResponseModel.dart';
import '../../model/wallet/GetBankDetailsRequestModel.dart';
import '../../model/wallet/GetBankDetailsResponseModel.dart';
import '../../model/wallet/RegUserRequestModel.dart';
import '../../model/wallet/RegUserResponseModel.dart';
import '../../model/wallet/WalletBalanceRequestModel.dart';
import '../../model/wallet/WalletBalanceResponseModel.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://antworksmoney.com/apiserver/")
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @POST("antapp/getname")
  Future<UsernameResponse> getUsername(@Body() UsernameRequest request);

  @POST("antapp/verifyOTP") // Verify OTP
  Future<OTPBean> otp(@Body() OTPRequestModel dataPost);

  @POST("ppi/walletbal") // Get Wallet Balance
  Future<WalletBalanceResponseModel> walletbal(
      @Header("oath_token") String authValue,
      @Header("Authorization") String oAuthTokenValue,
      @Body() WalletBalanceRequestModel walletBalanceRequestModel);

  @POST("ppi/getcard") // Get Card Details
  Future<FetchCardInfoResponseModel> fetchCardInfo(
      @Header("oath_token") String authValue,
      @Header("Authorization") String oAuthTokenValue,
      @Body() FetchCardInfoRequestModel request);

  @POST("ppi/getAccountdetails") // Get Card Details
  Future<GetBankDetailsResponseModel> fetchAccountInfo(
      @Header("oath_token") String authValue,
      @Header("Authorization") String oAuthTokenValue,
      @Body() GetBankDetailsRequestModel request);

  @POST("antapp/generateOrder")
  Future<GenerateRazorpayorderBean> generateRazorpayorder(
      @Body() GenerateRazorpayorderModel data,
      @Header("Authorization") String oAuthTokenValue,
      @Header("oath_token") String authValue);

  @POST("antapp/updateProfile")
  Future<ProfileUpdateResponseModel> profileUpdate(
      @Header("oath_token") String authValue,
      @Header("Authorization") String oAuthTokenValue,
      @Body() ProfileUpdateRequestModel dataProfile);



  @POST("ppi/reguser")
  Future<RegUserResponseModel> regUserMobile(
      @Header("Authorization") String oAuthTokenValue,
      @Header("oath_token") String authValue,
      @Body() RegUserRequestModel dataProfile);




  @POST("ppi/verifymotp")
  Future<RegUserResponseModel> mOtpVerify(
      @Header("Authorization") String oAuthTokenValue,
      @Header("oath_token") String authValue,
      @Body() RegUserVerifyRequestModel dataProfile);



@POST("ppi/reguser_minkyc_aadhar")
Future<PanKYCResponseModel> minKycaadhar(
    @Header("Authorization") String oAuthTokenValue,
    @Header("oath_token") String authValue,
    @Body() AadhaarCardRequest dataProfile);


  @POST("antapp/appTransaction")
  Future<TransactionHistoryResponseModel> transaction
      (@Header("oath_token") String authValue,
      @Header("Authorization") String oAuthTokenValue,
      @Body() TransactionHistoryRequestModel dataProfile);

  @GET("offers/offersapi/homebanner")
  Future<HomebannerModel> Homebanner();

  @POST("offers/offersapi/getOfferdetails")
  Future<OfferDetailsResponse> fetchOfferDetails(@Body() OfferDetailsRequest data);

  @GET("offers/offersapi/getHomeoffers_by_Categories_V1")
  Future<OfferResponse> getOffers();

  @POST("offers/offersapi/getOffersbycategory")
  Future<OfferDetailsByCategoryResponse> fetchOfferByCategory(@Body() OfferDetailsByCategoryRequest data);

}


