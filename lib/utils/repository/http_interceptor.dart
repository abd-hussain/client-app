import 'dart:async';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/errors/exceptions.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HttpInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var box = Hive.box(DatabaseBoxConstant.userInfo);
    if (box.get(DatabaseFieldConstant.token) != null || box.get(DatabaseFieldConstant.token) != "") {
      String bearerToken = "Bearer ${box.get(DatabaseFieldConstant.token)}";
      options.headers = {"Authorization": bearerToken, "lang": box.get(DatabaseFieldConstant.language)};
    } else {
      options.headers.putIfAbsent("lang", () => box.get(DatabaseFieldConstant.language));
    }
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

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }

  Future<bool> validateResponse<T extends Model, TR>(Response response) async {
    logger.wtf("status code ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;
      default:
        logger.wtf("request url => ${response.realUri} response.data ${response.data.toString()}");
        throw DioError(
            error: HttpException(status: response.statusCode!, message: response.data["detail"]["message"]),
            requestOptions: response.requestOptions);
    }
  }
}
