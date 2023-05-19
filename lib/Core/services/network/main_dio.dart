import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_task/Core/const/Api_const.dart';
import 'package:todo_task/Core/di/di.dart';
import 'package:todo_task/Core/services/local/my_shared_preferences.dart';

class MyDio {
  late Dio dio;

  MyDio() {
    BaseOptions baseOptions = BaseOptions(baseUrl: ApiConst.baseUrl, headers: {
      'Content-Type': 'application/json',
      'Accept': 'text/plain',
    });
    dio = Dio(baseOptions);
    printTest('dio ...............');
  }

  //get data
  Future<ApiResults> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers = {
      "Authorization":
          "Bearer ${sl<MySharedPref>().getString(key: MySharedKeys.apiToken)}",
      'Accept': 'text/plain',
    };
    try {
      var response = await dio.get(endPoint, queryParameters: queryParameters);

      printResponse(response.statusCode.toString());
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('queryParameters:    $queryParameters');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("لا يوجد اتصال بالانترنت");
    } on FormatException {
      return ApiFailure("حدث خطأ في صيغة البيانات");
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        printResponse('base:    ${dio.options.baseUrl}');
        printResponse('url:    $endPoint');
        printResponse('header:    ${dio.options.headers}');
        printResponse('response:    $e');
        // return ApiFailure(e.response!.data['message']);
        return ApiFailure(e.message!);
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure("تأكد من اتصالك بالانترنت");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("غير قادر علي الاتصال بالسيرفر");
      } else {
        return ApiFailure("حدث خطأ حاول مرة اخري");
      }
    } catch (e) {
      return ApiFailure("حدث خطأ حاول مرة اخري");
    }
  }

  //post data
  Future<ApiResults> postData({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool formData = true,
    String? token,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("لا يوجد اتصال بالانترنت");
    } on FormatException {
      return ApiFailure("حدث خطأ في صيغة البيانات");
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        // return ApiFailure(e.response!.data['message']);
        printResponse('base:    ${dio.options.baseUrl}');
        printResponse('url:    $endPoint');
        printResponse('header:    ${dio.options.headers}');
        printResponse('body:    $data');
        printResponse('response:    $e');
        return ApiFailure('${e.response!.statusCode}');
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure("تأكد من اتصالك بالانترنت");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("غير قادر علي الاتصال بالسيرفر");
      } else {
        return ApiFailure("حدث خطأ حاول مرة اخري");
      }
    } catch (e) {
      return ApiFailure("$eحدث خطأ حاول مرة اخري ");
    }
  }

  //delete data
  Future<ApiResults> deleteData({
    required String endPoint,
    dynamic data,
    String? token,
  }) async {
    try {
      var response = await dio.delete(
        endPoint,
      );
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("لا يوجد اتصال بالانترنت");
    } on FormatException {
      return ApiFailure("حدث خطأ في صيغة البيانات");
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        // return ApiFailure(e.response!.data['message']);
        printResponse('base:    ${dio.options.baseUrl}');
        printResponse('url:    $endPoint');
        printResponse('header:    ${dio.options.headers}');
        printResponse('body:    $data');
        printResponse('response:    $e');
        return ApiFailure(' ${e.response}11111111111111111111');
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure("تأكد من اتصالك بالانترنت");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("غير قادر علي الاتصال بالسيرفر");
      } else {
        return ApiFailure("حدث خطأ حاول مرة اخري");
      }
    } catch (e) {
      return ApiFailure("$eحدث خطأ حاول مرة اخري ");
    }
  }

  //put data
  Future<ApiResults> putData({
    required String endPoint,
    dynamic data,
    String? token,
  }) async {
    try {
      var response = await dio.put(
        endPoint,
        data: data,
      );
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("لا يوجد اتصال بالانترنت");
    } on FormatException {
      return ApiFailure("حدث خطأ في صيغة البيانات");
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        // return ApiFailure(e.response!.data['message']);
        printResponse('base:    ${dio.options.baseUrl}');
        printResponse('url:    $endPoint');
        printResponse('header:    ${dio.options.headers}');
        printResponse('body:    $data');
        printResponse('response:    $e');
        return ApiFailure(' ${e.response}11111111111111111111');
      }
      else if (e.type == DioErrorType.connectionTimeout) {
        return ApiFailure("تأكد من اتصالك بالانترنت");
      } else if (e.type == DioErrorType.receiveTimeout) {
        return ApiFailure("غير قادر علي الاتصال بالسيرفر");
      } else {
        return ApiFailure("حدث خطأ حاول مرة اخري");
      }
    } catch (e) {
      return ApiFailure("$eحدث خطأ حاول مرة اخري ");
    }
  }
}

void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printTest(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

abstract class ApiResults {}

class ApiSuccess extends ApiResults {
  dynamic data;
  int? statusCode;

  ApiSuccess(this.data, this.statusCode);
}

class ApiFailure extends ApiResults {
  String message;

  ApiFailure(this.message);
}
