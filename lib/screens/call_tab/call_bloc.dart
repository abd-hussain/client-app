import 'package:client_app/locator.dart';
import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
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

  Future<Appointment> getClientAppointments() {
    return locator<AppointmentsService>().getClientAppointments();
  }

  List<AppointmentData> checkIfThereIsAnyMeetingToday(List<AppointmentData>? listOfData) {
    if (listOfData != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      List<AppointmentData> newList = [];
      for (var appointment in listOfData) {
        final parsedFromDate = DateTime.parse(appointment.dateFrom!);
        if (DateTime(parsedFromDate.year, parsedFromDate.month, parsedFromDate.day) == today) {
          newList.add(appointment);
        }
      }
      return newList;
    } else {
      return [];
    }
  }

  @override
  onDispose() {}
}
