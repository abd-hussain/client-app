import 'package:client_app/locator.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/models/https/categories_model.dart';

import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../sevices/appointments_service.dart';

class CallBloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<List<Category>?> listOfCategories() async {
    final api = await service.categories();
    if (api.data != null) {
      return api.data!..sort((a, b) => a.id!.compareTo(b.id!));
    }
    return null;
  }

  Future<void> cancelAppointment({required int id}) {
    return locator<AppointmentsService>().cancelAppointment(id: id);
  }

  CalenderMeetings? getNearestMeetingToday(List<CalenderMeetings> meetings) {
    final now = DateTime.now();

    var activeMeetings =
        meetings.where((meeting) => meeting.state == 1).toList();
    var removeOldMeetingFromTheList =
        activeMeetings.where((meeting) => meeting.toTime.isAfter(now)).toList();
    var filtermeetingavaliablewithing24Hour = removeOldMeetingFromTheList
        .where((meeting) =>
            meeting.fromTime.isBefore(now.add(const Duration(hours: 24))))
        .toList();
    return filtermeetingavaliablewithing24Hour.isNotEmpty
        ? filtermeetingavaliablewithing24Hour.reduce((closest, current) =>
            current.fromTime.isBefore(closest.fromTime) ? current : closest)
        : null;
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  bool isTimeDifferencePositive(DateTime timeDifference) {
    return timeDifference.hour > 0 ||
        timeDifference.minute > 0 ||
        timeDifference.second > 0;
  }

  @override
  onDispose() {}
}
