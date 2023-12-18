
import 'package:dio/dio.dart';

import '../../data/retrofit/api_client.dart';
import '../../data/retrofit/api_client_test.dart';
import '../../model/notification/notification_model.dart';
import '../../model/post.dart';
import '../../model/transaction/transaction_history_model.dart';


class CommonApiRepo{

  late APIClient apiClient;
  late APIClientTest apiClientTest;

  CommonApiRepo() {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    apiClient = APIClient(dio);
    apiClientTest = APIClientTest(Dio());


  }












 /* Future<dynamic> fetchTransaction(String oAuthToken, String auth, fetchStatementRequestModel requestData) async{

    fetchStatementResponseModel responseModel= await apiClient.fetchSellerTransactions(oAuthToken, auth, requestData);
    print(':::Status->${responseModel.status}\nResponse Code->${responseModel.responseCode}\nMsg->${responseModel.responseMessage}');

    return responseModel;
  }*/

  Future<dynamic> getNotifications(String mobile) async {
    FetchNotificationRequestModel requestModel = FetchNotificationRequestModel(
      mobile: mobile,
      source: "Antpay",
    );
  }

  Future<dynamic> fetchPost(int pageNo, int limit) async{

    List<Post> response= await apiClientTest.getPost(pageNo, limit);
    // print(':::${response[0].title}');
    // if(response.isEmpty)
    //   return [];
    return response;
  }


}