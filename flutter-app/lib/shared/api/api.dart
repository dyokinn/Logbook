import 'package:dio/dio.dart';

class Api {
  static String baseUrl = 'http://192.168.15.92:3000/api';

  static Dio dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.15.92:3000/api',
  ));
}


