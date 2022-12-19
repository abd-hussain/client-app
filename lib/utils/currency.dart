import 'package:client_app/utils/constants/database_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Currency {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  String getCorrectAmountAndCurrency(double amount) {
    //TODO must save object and return obj

    if (box.get(DatabaseFieldConstant.language) == "en") {
      return "${amount} JD";
    }

    return "${amount} د.أ";
  }
}
