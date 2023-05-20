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

  CalenderMeetings? checkIfThereIsAnyMeetingTodayAndReturnTheNearOne(List<CalenderMeetings> listOfData) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<CalenderMeetings> newList = [];
    for (var appointment in listOfData) {
      Duration diffrent =
          today.difference(DateTime(appointment.fromTime.year, appointment.fromTime.month, appointment.fromTime.day));

      if (diffrent.inHours <= 24) {
        newList.add(appointment);
      }
    }
    if (newList.isNotEmpty) {
      CalenderMeetings returnedAppointment = newList[0];

      for (CalenderMeetings appoint in newList) {
        if (appoint.fromTime.isBefore(returnedAppointment.fromTime)) {
          returnedAppointment = appoint;
        }
      }
      return returnedAppointment;
    } else {
      return null;
    }
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
