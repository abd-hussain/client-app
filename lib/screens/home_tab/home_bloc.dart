import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/sevices/home_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeBloc extends Bloc<HomeService> {
  final ValueNotifier<List<MainBanner>?> bannerListNotifier = ValueNotifier<List<MainBanner>?>(null);

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void getHome() {
    service.getHome().then((value) {
      if (value.data != null) {
        bannerListNotifier.value = value.data!.mainBanner;
      }
    });
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  @override
  onDispose() {
    bannerListNotifier.dispose();
  }
}
