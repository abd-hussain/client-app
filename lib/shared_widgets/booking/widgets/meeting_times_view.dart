import 'package:client_app/models/https/mentor_appointment.dart';
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
  final List<MentorAppointmentData> listOfAppointments;

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
    List<int>? list;
    list = checkDayOfTheWeek(selectedMeetingDate);

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
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return BookingCell(
                        title: DayTime().convertingTimingToRealTime(list![index]),
                        isSelected: (snapshot ?? 0) == list[index],
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

  List<int>? checkDayOfTheWeek(DateTime? dateTime) {
    if (dateTime != null) {
      final dayOfTheWeek = DateFormat('EEEE').format(dateTime);
      if (dayOfTheWeek == "Saturday") {
        return chackifTheDateSelectedExsistInAppotmentsList(dateTime, workingHoursSaturday);
      } else if (dayOfTheWeek == "Sunday") {
        return chackifTheDateSelectedExsistInAppotmentsList(dateTime, workingHoursSunday);
      } else if (dayOfTheWeek == "Monday") {
        return chackifTheDateSelectedExsistInAppotmentsList(dateTime, workingHoursMonday);
      } else if (dayOfTheWeek == "Tuesday") {
        return chackifTheDateSelectedExsistInAppotmentsList(dateTime, workingHoursTuesday);
      } else if (dayOfTheWeek == "Wednesday") {
        return chackifTheDateSelectedExsistInAppotmentsList(dateTime, workingHoursWednesday);
      } else if (dayOfTheWeek == "Thursday") {
        return chackifTheDateSelectedExsistInAppotmentsList(dateTime, workingHoursThursday);
      } else if (dayOfTheWeek == "Friday") {
        return chackifTheDateSelectedExsistInAppotmentsList(dateTime, workingHoursFriday);
      } else {
        return [];
      }
    } else {
      return null;
    }
  }

  //TODO: handle Timing UTC

  List<int>? chackifTheDateSelectedExsistInAppotmentsList(DateTime selectedDateTime, List<int>? listOFHours) {
    if (listOFHours != null) {
      List<int> newListOFHours = listOFHours;
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final DateFormat formatterHour = DateFormat('HH');
      final String formattedSelectedDateTime = formatter.format(selectedDateTime);
      for (var date in listOfAppointments) {
        var parsedDate = DateTime.parse(date.date!);
        final String formattedparsedDate = formatter.format(parsedDate);
        if (formattedSelectedDateTime == formattedparsedDate) {
          final value = int.parse(formatterHour.format(parsedDate));
          newListOFHours.removeWhere((item) => item == value);
        }
      }
      return newListOFHours;
    } else {
      return null;
    }
  }
}
