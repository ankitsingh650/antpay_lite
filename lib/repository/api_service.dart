import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/login/user_name_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://antworksmoney.com/apiserver/antapp/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("getname}")
  Future<UsernameResponse> getUsername(@Body() UsernameRequest request);
}
