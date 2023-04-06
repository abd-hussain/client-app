import 'package:client_app/locator.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/screens/call_tab/call_bloc.dart';
import 'package:client_app/screens/call_tab/widgets/call_ready_view.dart';
import 'package:client_app/screens/call_tab/widgets/waiting_call_view.dart';
import 'package:client_app/screens/call_tab/widgets/no_call_view.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final bloc = CallBloc();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<List<CalenderMeetings>>(
        valueListenable: locator<MainContainerBloc>().eventsMeetingsListNotifier,
        builder: (BuildContext context, List<CalenderMeetings> value, Widget? child) {
          if (value.isNotEmpty) {
            final appointment = bloc.checkIfThereIsAnyMeetingTodayAndReturnTheNearOne(value);

            if (appointment != null) {
              final timeDifference = appointment.fromTime.subtract(Duration(
                  days: 0, hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second));

              if (timeDifference.hour > 0 || timeDifference.minute > 0 || timeDifference.second > 0) {
                return WaitingCallView(
                  timerStartNumberHour: timeDifference.hour,
                  timerStartNumberMin: timeDifference.minute,
                  timerStartNumberSec: timeDifference.second,
                  cancelMeetingTapped: () {
                    bloc.cancelAppointment(id: appointment.meetingId!).then((value) async {
                      await locator<MainContainerBloc>().getAppointmentsAndEvents();
                    });
                  },
                  profileImage: appointment.type == Type.meeting ? appointment.profileImg! : appointment.eventImg!,
                  suffixeName: appointment.mentorPrefix!,
                  firstName: appointment.mentorFirstName!,
                  lastName: appointment.mentorLastName!,
                  categoryName: appointment.categoryName!,
                  meetingtime: DateFormat('hh:mm a').format(appointment.fromTime),
                  meetingduration: "${appointment.toTime.difference(appointment.fromTime).inMinutes}",
                  meetingday: bloc.box.get(DatabaseFieldConstant.language) == "en"
                      ? DateFormat('EEEE').format(timeDifference)
                      : DayTime().convertDayToArabic(DateFormat('EEEE').format(timeDifference)),
                  clientMeetingNote: appointment.noteFromClient ?? "",
                  mentorMeetingNote: appointment.noteFromMentor ?? "",
                );
              } else {
                return CallReadyView();
              }
            } else {
              return noCallView();
            }
          } else {
            return noCallView();
          }
        },
      ),
    );
  }

  Widget noCallView() {
    return FutureBuilder(
        future: bloc.listOfCategories(),
        builder: (context, snapshot2) {
          return NoCallView(
            isUserLoggedIn: bloc.checkIfUserIsLoggedIn(),
            language: bloc.box.get(DatabaseFieldConstant.language),
            listOfCategories: snapshot2.data ?? [],
          );
        });
  }
}
