import 'package:client_app/locator.dart';
import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/models/https/notifications_response.dart';
import 'package:client_app/sevices/home_services.dart';
import 'package:client_app/sevices/noticitions_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeBloc extends Bloc<HomeService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<List<MainBannerData>?> getHome() async {
    final value = await service.getHome();
    if (value.data != null) {
      return value.data ?? [];
    } else {
      return [];
    }
  }

  Future<List<NotificationsResponseData>?> listOfNotifications() async {
    final value = await locator<NotificationsService>().listOfNotifications();
    return value.data;
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  @override
  onDispose() {}
}
