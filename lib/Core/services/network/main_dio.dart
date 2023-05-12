import 'package:dio/dio.dart';
import 'package:todo_task/Core/const/Api_const.dart';
class MyDio {
  static late Dio dio;
  static String url = ApiConst.baseUrl;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer your token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

// ====================================================

  static Future<Response> postData(
      {required String url, required FormData data}) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer your token',
    };
    return dio.post(url, data: data);
  }

// ====================================================

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required FormData data,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer your token',
    };
    return dio.put(url, queryParameters: query, data: data);
  }

// ====================================================
  static Future<Response> deleteData({required String url}) {
    return dio.delete(url);
  }
}