import 'package:client_app/locator.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
import 'package:client_app/screens/call_tab/call_bloc.dart';
import 'package:client_app/screens/call_tab/widgets/call_view.dart';
import 'package:client_app/screens/call_tab/widgets/no_call_view.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';
import 'package:client_app/utils/constants/database_constant.dart';
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

  //TODO handle when the user is not loggedin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderHomePage(),
            ValueListenableBuilder<List<CalenderMeetings>>(
              valueListenable: locator<MainContainerBloc>().eventsmeetingsListNotifier,
              builder: (BuildContext context, List<CalenderMeetings> value, Widget? child) {
                if (value.isNotEmpty) {
                  final appointment = bloc.checkIfThereIsAnyMeetingTodayAndReturnTheNearsOne(value);
                  if (appointment != null) {
                    final timeDifference = appointment.fromTime.subtract(Duration(
                        days: 0,
                        hours: DateTime.now().hour,
                        minutes: DateTime.now().minute,
                        seconds: DateTime.now().second));

                    return CallView(
                      timerStartNumberHour: timeDifference.hour,
                      timerStartNumberMin: timeDifference.minute,
                      timerStartNumberSec: timeDifference.second,
                      cancelMeetingTapped: () {
                        bloc.cancelAppointment(id: appointment.meetingId).then((value) {
                          locator<MainContainerBloc>().getAppointmentsAndEvents();
                          setState(() {});
                        });
                      },
                      profileImage: appointment.type == Type.meeting ? appointment.profileImg! : appointment.eventImg!,
                      suffixeName: appointment.mentorPrefix,
                      firstName: appointment.mentorFirstName,
                      lastName: appointment.mentorLastName,
                      categoryName: appointment.categoryName,
                      meetingtime: DateFormat('hh:mm a').format(appointment.fromTime),
                      meetingduration: "${appointment.toTime.difference(appointment.fromTime).inMinutes}",
                    );
                  } else {
                    return noCallView();
                  }
                } else {
                  return noCallView();
                }
              },
            ),

            //TODO: handle status of the call is arrived
          ],
        ),
      ),
    );
  }

  Widget noCallView() {
    return FutureBuilder(
        future: bloc.listOfCategories(),
        builder: (context, snapshot2) {
          return NoCallView(
            language: bloc.box.get(DatabaseFieldConstant.language),
            listOfCategories: snapshot2.data ?? [],
          );
        });
  }
}
