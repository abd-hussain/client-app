import 'package:client_app/utils/constants/database_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum Timing { hour, threeQuarter, halfHour, quarterHour }

class Currency {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  String calculateHourRate(double hourRate, Timing timing) {
    String currency = "\$";

    switch (timing) {
      case Timing.hour:
        return "$currency$hourRate";
      case Timing.threeQuarter:
        return "$currency${hourRate - (hourRate / 4)}";
      case Timing.halfHour:
        return "$currency${hourRate / 2}";
      case Timing.quarterHour:
        return "$currency${hourRate / 4}";
    }
  }

  String getHourRateWithoutCurrency(String hourRate) {
    String currency = "\$";
    return hourRate.replaceAll(currency, "");
  }
}
