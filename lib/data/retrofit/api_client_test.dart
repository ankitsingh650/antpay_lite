
import 'package:dio/dio.dart' hide Headers;

import 'package:retrofit/retrofit.dart';

import '../../model/post.dart';
part 'api_client_test.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class APIClientTest {
  factory APIClientTest(Dio dio, {String baseUrl}) = _APIClientTest;

  @GET("posts")
  Future<List<Post>> getPost(@Query("_page") int page, @Query("_limit") int limit);

}