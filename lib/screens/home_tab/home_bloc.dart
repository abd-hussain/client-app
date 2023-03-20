import 'package:client_app/locator.dart';
import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/sevices/home_services.dart';
import 'package:client_app/sevices/report_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeBloc extends Bloc<HomeService> {
  final ValueNotifier<List<MainBanner>?> bannerListNotifier = ValueNotifier<List<MainBanner>?>(null);
  final ValueNotifier<List<MainEvent>?> eventListNotifier = ValueNotifier<List<MainEvent>?>(null);

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void getHome() {
    service.getHome().then((value) {
      if (value.data != null) {
        bannerListNotifier.value = value.data!.mainBanner;
        eventListNotifier.value = value.data!.mainEvent;
      }
    });
  }

  void reportEvent({required int eventId}) async {
    await locator<ReportService>().reportEvent(eventId: eventId);
  }

  @override
  onDispose() {
    bannerListNotifier.dispose();
    eventListNotifier.dispose();
  }
}
