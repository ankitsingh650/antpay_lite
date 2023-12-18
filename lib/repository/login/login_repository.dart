import 'package:flutter/cupertino.dart';
import '../../utils/app_urls.dart';
import '../../utils/common_utils.dart';
import '../../utils/network/BaseApiService.dart';
import '../../utils/network/NetworkApiService.dart';

class LoginRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginUser(dynamic data) async {
    try {
      dynamic apiResponse =
          await _apiService.getPostApiResponse(AppUrls.endPoint, data);
      return apiResponse;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> fetchUser(dynamic data) async {
    try {
      dynamic apiResponse =
          await _apiService.getPostApiResponse(AppUrls.endPointFetchUser, data);
      return apiResponse;
    } catch (e) {
      throw e;
    }
  }

  void testSubmit(String msg, BuildContext context) {
    CommonUtils.showFlushBar(msg, context);
  }
}
