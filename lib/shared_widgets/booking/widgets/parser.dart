import 'dart:async';

import 'package:client_app/utils/currency.dart';

class ParserTimer {
  String getTime(Timing time) {
    switch (time) {
      case Timing.hour:
        return "60";
      case Timing.halfHour:
        return "30";
      case Timing.quarterHour:
        return "15";
    }
  }
}
