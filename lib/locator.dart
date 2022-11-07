import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/repository/http_interceptor.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:client_app/sevices/auth_services.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/sevices/general/network_info_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<NetworkInfoService>(NetworkInfoService());
  locator.registerFactory<FilterService>(() => FilterService());
  locator.registerFactory<AccountService>(() => AccountService());
  locator.registerFactory<AuthService>(() => AuthService());

  locator.registerFactory<Dio>(() => Dio());
  locator.registerFactory<HttpInterceptor>(() => HttpInterceptor());
  locator.registerSingleton<HttpRepository>(HttpRepository());
  locator.registerSingleton<DayTime>(DayTime());
}
