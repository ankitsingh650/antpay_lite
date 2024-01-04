
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
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, requestHeader: true));
    apiClient = APIClient(dio);
    apiClientTest = APIClientTest(Dio());


  }


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