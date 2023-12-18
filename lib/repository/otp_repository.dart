import '../utils/app_urls.dart';
import '../utils/network/BaseApiService.dart';
import '../utils/network/NetworkApiService.dart';

class OtpRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> resendOtp(dynamic data) async {
    try {
      dynamic apiResponse =
          await _apiService.getPostApiResponse(AppUrls.endPoint, data);
      return apiResponse;
    } catch (e) {
      throw e;
    }
  }
}
