import 'package:client_app/main_context.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/sevices/archive_service.dart';
import 'package:client_app/sevices/discount_service.dart';
import 'package:client_app/sevices/home_services.dart';
import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/sevices/noticitions_services.dart';
import 'package:client_app/sevices/report_service.dart';
import 'package:client_app/sevices/settings_service.dart';
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
  locator.registerLazySingleton(() => MainContext());

  locator.registerSingleton<NetworkInfoService>(NetworkInfoService());
  locator.registerFactory<FilterService>(() => FilterService());
  locator.registerFactory<AccountService>(() => AccountService());
  locator.registerFactory<AuthService>(() => AuthService());
  locator.registerFactory<ReportService>(() => ReportService());
  locator.registerFactory<MentorService>(() => MentorService());
  locator.registerFactory<NotificationsService>(() => NotificationsService());
  locator.registerFactory<SettingService>(() => SettingService());
  locator.registerFactory<HomeService>(() => HomeService());
  locator.registerFactory<DiscountService>(() => DiscountService());
  locator.registerFactory<AppointmentsService>(() => AppointmentsService());
  locator.registerFactory<ArchiveService>(() => ArchiveService());

  locator.registerFactory<Dio>(() => Dio());
  locator.registerFactory<HttpInterceptor>(() => HttpInterceptor());
  locator.registerSingleton<HttpRepository>(HttpRepository());
  locator.registerSingleton<DayTime>(DayTime());
  locator.registerSingleton<MainContainerBloc>(MainContainerBloc());
}
