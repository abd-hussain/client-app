import 'package:intl/intl.dart';

class DayTime {
  String gettheCorrentImageDependOnCurrentTime() {
    final currentTime = DateTime.now();
    if (currentTime.hour > 8 && currentTime.hour < 20) {
      return "assets/images/days/sun.png";
    }
    return "assets/images/days/moon.png";
  }

  String dateFormatter(String dateAsString) {
    var parsedDate = DateTime.parse(dateAsString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(parsedDate);
  }

  String convertingTimingToRealTime(int time) {
    if (time > 0 && time <= 9) {
      return "0$time:00 am";
    } else if (time > 9 && time <= 12) {
      return "$time:00 am";
    } else {
      return "${time - 12}:00 pm";
    }
  }
}
