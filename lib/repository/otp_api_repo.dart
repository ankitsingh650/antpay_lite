import 'package:dio/dio.dart';

import '../data/retrofit/api_client.dart';
import '../model/otp/otp_model.dart';
import '../utils/method_utils.dart';

class OtpApiRepo {
  late APIClient apiClient;


  OtpApiRepo() {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    apiClient = APIClient(dio);
  }

  Future<dynamic> verifyOTP(String mobile, String currOtp) async {

    String? id = await CommonMethodUtils().getId();
    print('Device ID: $id');
    OTPRequestModel dataPost = OTPRequestModel(mobile: mobile, otp: currOtp , device_id: id);
    dynamic posResponse = await apiClient.otp(dataPost);
    print(
        '${posResponse.status}:  ${posResponse.msg}: ${posResponse.oathToken}: ${posResponse.userModel?.name}');
    return posResponse;
    //You can use your login model data as per your requirements.
  }
}
