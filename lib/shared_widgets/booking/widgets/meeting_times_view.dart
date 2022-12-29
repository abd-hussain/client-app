import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/shared_widgets/booking/widgets/cell_of_booking.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeetingTimeView extends StatelessWidget {
  final List<int>? workingHoursSaturday;
  final List<int>? workingHoursSunday;
  final List<int>? workingHoursMonday;
  final List<int>? workingHoursTuesday;
  final List<int>? workingHoursWednesday;
  final List<int>? workingHoursThursday;
  final List<int>? workingHoursFriday;
  final ValueNotifier<int?> selectedMeetingTime;
  final DateTime? selectedMeetingDate;
  final List<AppointmentData> listOfAppointments;
  const MeetingTimeView({
    super.key,
    required this.workingHoursSaturday,
    required this.workingHoursSunday,
    required this.workingHoursMonday,
    required this.workingHoursTuesday,
    required this.workingHoursWednesday,
    required this.workingHoursThursday,
    required this.workingHoursFriday,
    required this.selectedMeetingTime,
    required this.listOfAppointments,
    required this.selectedMeetingDate,
  });

  @override
  Widget build(BuildContext context) {
    List<int>? list = _getWorkingDayForSelectedDate(selectedMeetingDate);
    list = chackifTheDateSelectedExsistInAppotmentsList(selectedMeetingDate, list);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (DateTime(selectedMeetingDate!.year, selectedMeetingDate!.month, selectedMeetingDate!.day) == today) {
      list = filterListWithCurrentTime(list);
    }

    return SizedBox(
      height: 200,
      child: ValueListenableBuilder<int?>(
          valueListenable: selectedMeetingTime,
          builder: (context, snapshot, child) {
            return list != null
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 50),
                    shrinkWrap: true,
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      return BookingCell(
                        title: DayTime().convertingTimingToRealTime(list![index]),
                        isSelected: (snapshot ?? false) == list![index],
                        onPress: () {
                          selectedMeetingTime.value = list![index];
                        },
                      );
                    },
                  )
                : Center(
                    child: CustomText(
                      title: AppLocalizations.of(context)!.noavaliabletime,
                      textColor: const Color(0xff444444),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
          }),
    );
  }

  List<int>? _getWorkingDayForSelectedDate(DateTime? dateTime) {
    if (dateTime != null) {
      final dayOfTheWeek = DateFormat('EEEE').format(dateTime);

      if (dayOfTheWeek == "Saturday") {
        return workingHoursSaturday;
      } else if (dayOfTheWeek == "Sunday") {
        return workingHoursSunday;
      } else if (dayOfTheWeek == "Monday") {
        return workingHoursMonday;
      } else if (dayOfTheWeek == "Tuesday") {
        return workingHoursTuesday;
      } else if (dayOfTheWeek == "Wednesday") {
        return workingHoursWednesday;
      } else if (dayOfTheWeek == "Thursday") {
        return workingHoursThursday;
      } else if (dayOfTheWeek == "Friday") {
        return workingHoursFriday;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  List<int>? filterListWithCurrentTime(List<int>? list) {
    if (list != null) {
      List<int> filteredList = [];
      int currentHour = DateTime.now().hour;
      for (int time in list) {
        if (time > currentHour) {
          filteredList.add(time);
        }
      }
      return filteredList;
    } else {
      return null;
    }
  }

  List<int>? chackifTheDateSelectedExsistInAppotmentsList(DateTime? selectedDateTime, List<int>? listOFHours) {
    if (listOFHours != null && selectedDateTime != null) {
      List<int>? newListOFHours = listOFHours;
      for (var appointment in listOfAppointments) {
        var parsedDateFrom = DateTime.parse(appointment.dateFrom!);
        if (newListOFHours.contains(parsedDateFrom.hour)) {
          newListOFHours.remove(parsedDateFrom.hour);
        }
      }

      return newListOFHours;
    } else {
      return null;
    }
  }
}
