import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/screens/call_tab/call_bloc.dart';
import 'package:client_app/screens/call_tab/widgets/call_ready_view.dart';
import 'package:client_app/screens/call_tab/widgets/waiting_call_view.dart';
import 'package:client_app/screens/call_tab/widgets/no_call_view.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/logger.dart';
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
    logDebugMessage(message: 'Call init Called ...');
    if (bloc.checkIfUserIsLoggedIn()) {
      bloc.getActiveClientAppointments(context);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderHomePage(
          refreshCallBack: () {
            if (bloc.checkIfUserIsLoggedIn()) {
              bloc.getActiveClientAppointments(context);
            }
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ValueListenableBuilder<List<AppointmentData>>(
                valueListenable: bloc.activeClientAppointmentsListNotifier,
                builder: (context, snapshot, child) {
                  if (snapshot.isEmpty) {
                    return noCallView();
                  }

                  final appointment = bloc.getNearestMeetingToday(snapshot);
                  if (appointment == null) {
                    return noCallView();
                  }

                  DateTime now = DateTime.now();
                  DateTime timeDifference =
                      DateTime.parse(appointment.dateFrom!).isAfter(now)
                          ? DateTime.parse(appointment.dateFrom!)
                              .subtract(Duration(
                              hours: now.hour,
                              minutes: now.minute,
                              seconds: now.second,
                            ))
                          : DateTime(now.year, now.month, now.day);

                  if (bloc.isTimeDifferencePositive(timeDifference)) {
                    return WaitingCallView(
                      timerStartNumberHour: timeDifference.hour,
                      timerStartNumberMin: timeDifference.minute,
                      timerStartNumberSec: timeDifference.second,
                      metingDetails: appointment,
                      meetingtime: DateFormat('hh:mm a')
                          .format(DateTime.parse(appointment.dateFrom!)),
                      meetingduration:
                          "${DateTime.parse(appointment.dateTo!).difference(DateTime.parse(appointment.dateFrom!)).inMinutes}",
                      meetingday:
                          bloc.box.get(DatabaseFieldConstant.language) == "en"
                              ? DateFormat('EEEE').format(timeDifference)
                              : DayTime().convertDayToArabic(
                                  DateFormat('EEEE').format(timeDifference)),
                      cancelMeetingTapped: () {
                        bloc
                            .cancelAppointment(id: appointment.id!)
                            .then((value) async {
                          bloc.getActiveClientAppointments(context);
                        });
                      },
                      timesup: () {
                        setState(() {});
                      },
                    );
                  }

                  if (chechIfClientNotExiedTheTimeAllowedToEnter(
                      appointmentFromDate:
                          DateTime.parse(appointment.dateFrom!))) {
                    return CallReadyView(
                      channelId: appointment.channelId!,
                      appointmentId: appointment.id!,
                      meetingDurationInMin: DateTime.parse(appointment.dateTo!)
                          .difference(DateTime.parse(appointment.dateFrom!))
                          .inMinutes,
                      callEnd: () {
                        bloc.getActiveClientAppointments(context);
                      },
                    );
                  } else {
                    return noCallView();
                  }
                }),
          ),
        ),
      ],
    );
  }

  bool chechIfClientNotExiedTheTimeAllowedToEnter(
      {required DateTime appointmentFromDate}) {
    final currentDate = DateTime.now();
    final difference = currentDate.difference(appointmentFromDate).inMinutes;
    return difference < 10;
  }

  Widget noCallView() {
    return FutureBuilder(
        future: bloc.listOfCategories(),
        builder: (context, categoriesSnapShot) {
          return FutureBuilder(
              future: bloc.listOfMajords(),
              builder: (context, majorsSnapShot) {
                return NoCallView(
                  isUserLoggedIn: bloc.checkIfUserIsLoggedIn(),
                  language: bloc.box.get(DatabaseFieldConstant.language),
                  listOfCategories: categoriesSnapShot.data ?? [],
                  listOfMajors: majorsSnapShot.data ?? [],
                  refreshThePage: () {
                    if (bloc.checkIfUserIsLoggedIn()) {
                      bloc.getActiveClientAppointments(context);
                    }
                  },
                );
              });
        });
  }
}
