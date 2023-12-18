import 'package:dio/dio.dart';

class DioProvider {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;
}
