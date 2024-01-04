import 'package:antpay_lite/model/payment/generateRazorpayorderBean.dart';
import 'package:dio/dio.dart' hide Headers;

import 'package:retrofit/retrofit.dart';

import '../../model/homebanner/homebanner.dart';
import '../../model/homebanner/offer_details_by_category_model.dart';
import '../../model/homebanner/offer_details_model.dart';
import '../../model/homebanner/offers_model.dart';
import '../../model/login/profile_data.dart';
import '../../model/notification/notification_model.dart';
import '../../model/otp/otp_model.dart';
import '../../model/transaction/transaction_history_model.dart';
import '../../model/wallet/FetchCardInfoRequestModel.dart';
import '../../model/wallet/FetchCardInfoResponseModel.dart';
import '../../model/wallet/GetBankDetailsRequestModel.dart';
import '../../model/wallet/GetBankDetailsResponseModel.dart';
import '../../model/wallet/WalletBalanceRequestModel.dart';
import '../../model/wallet/WalletBalanceResponseModel.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://antworksmoney.com/apiserver/")
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

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
  Future<ProfileUpdateResponseModel> profileUpdate
      (@Header("oath_token") String authValue,
      @Header("Authorization") String oAuthTokenValue,
      @Body() ProfileUpdateRequestModel dataProfile);

  @POST("antapp/appTransaction")
  Future<TransactionHistoryResponseModel> Transaction
      (@Header("oath_token") String authValue,
      @Header("Authorization") String oAuthTokenValue,
      @Body() TransactionHistoryRequestModel dataProfile);


  @GET("offers/offersapi/homebanner")
  Future<HomebannerModel> Homebanner
      ();
  @POST("offers/offersapi/getOfferdetails")
  Future<OfferDetailsResponse> fetchOfferDetails(@Body() OfferDetailsRequest data);

  @GET("offers/offersapi/getHomeoffers_by_Categories_V1")
  Future<OfferResponse> getOffers();

  @POST("offers/offersapi/getOffersbycategory")
  Future<OfferDetailsByCategoryResponse> fetchOfferByCategory(@Body() OfferDetailsByCategoryRequest data);

  @POST("antapp/get_notification")
  Future<FetchNotificationResponseModel> fetchNotifications(@Header("oath_token") String authValue, @Header("Authorization") String oAuthTokenValue,
      @Body() FetchNotificationRequestModel data);

}
