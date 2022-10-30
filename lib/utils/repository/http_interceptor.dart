import 'dart:async';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HttpInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final token = await storage.readEncrypted(key: AppConstants.accessToken);
    // if (token != null) {
    //   options.headers.putIfAbsent("Authorization", () => "Bearer $token");
    //   options.headers.putIfAbsent("X-Version", () => "1.0");
    // }
    var box = Hive.box(DatabaseBoxConstant.userInfo);

    options.headers.putIfAbsent("user_id", () => "123");
    options.headers.putIfAbsent("language", () => box.get(DatabaseFieldConstant.language));
    options.headers.putIfAbsent("apikey", () => "123");

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (await validateResponse(response)) {
      super.onResponse(response, handler);
    }
  }

  Future<bool> validateResponse<T extends Model, TR>(Response response) async {
    switch (response.statusCode) {
      case 200:
        return true;
      case 401:
        return false;
      // case 403:
      //   FirebaseCrashlytics.instance.recordError(HttpException(response.statusCode, 'Unauthorized Request'), StackTrace.current);
      //   logger.d("------------------ Token Expired with status code 401 or 403");
      //   throw DioError(error: HttpException(response.statusCode, 'Unauthorized Request'), requestOptions: response.requestOptions);
      // case 400:
      //   var error;
      //   if (response.requestOptions.path == 'token') {
      //     error = AuthBadRequestException.fromJson(response.data, response.statusCode);
      //     FirebaseCrashlytics.instance.recordError(HttpException(response.statusCode, (error as AuthBadRequestException).errorDescription), StackTrace.current);
      //   } else if (response.requestOptions.path == 'account/forgot-password') {
      //     error = ResetPasswordRequestException.fromJson(response.data);
      //   } else {
      //     error = BadRequestException.fromJson(response.data, response.statusCode);
      //     FirebaseCrashlytics.instance.recordError(HttpException(response.statusCode, (error as BadRequestException).invalidRequest.first), StackTrace.current);
      //   }
      //   throw DioError(error: error, requestOptions: response.requestOptions);
      //   break;
      default:
        return false;

      // var error = HttpException(response.statusCode, '${response.requestOptions.path.split('?').first}- ${response.statusCode} - Error occured while Communication with Server with StatusCode');
      // FirebaseCrashlytics.instance.recordError(HttpException(response.statusCode, error.message), StackTrace.current);
      // throw DioError(error: error, requestOptions: response.requestOptions);
    }
  }
}
