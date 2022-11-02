import 'dart:async';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/errors/exceptions.dart';
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

    // options.headers.putIfAbsent("user_id", () => "123");
    options.headers.putIfAbsent("lang", () => box.get(DatabaseFieldConstant.language));
    // options.headers.putIfAbsent("apikey", () => "123");

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      if (await validateResponse(response)) {
        return handler.next(response);
      }
    } catch (error) {
      handler.reject(error as DioError);
    }
  }

  Future<bool> validateResponse<T extends Model, TR>(Response response) async {
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;
      default:
        throw DioError(
            error: HttpException(
                status: response.statusCode!,
                message: response.data["detail"]["message"],
                requestId: response.data["detail"]["request_id"]),
            requestOptions: response.requestOptions);
    }
  }
}
