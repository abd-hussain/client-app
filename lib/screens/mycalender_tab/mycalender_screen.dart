import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/screens/mycalender_tab/mycalender_bloc.dart';
import 'package:client_app/screens/mycalender_tab/utils/calender_bottom_sheet.dart';
import 'package:client_app/screens/mycalender_tab/utils/meeting_datasource.dart';
import 'package:client_app/shared_widgets/booking/cancel_booking_bottom_sheet.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalenderScreen extends StatefulWidget {
  const MyCalenderScreen({super.key});

  @override
  State<MyCalenderScreen> createState() => _MyCalenderScreenState();
}

class _MyCalenderScreenState extends State<MyCalenderScreen> {
  final bloc = MyCalenderBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Calender init Called ...');
    if (bloc.checkIfUserIsLoggedIn()) {
      bloc.getClientAppointments(context);
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
              bloc.getClientAppointments(context);
            }
          },
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ValueListenableBuilder<List<AppointmentData>>(
              valueListenable: bloc.meetingsListNotifier,
              builder: (context, snapshot, child) {
                return SfCalendar(
                    view: CalendarView.month,
                    firstDayOfWeek: 6,
                    allowAppointmentResize: true,
                    initialSelectedDate: DateTime.now(),
                    todayHighlightColor: const Color(0xff4CB6EA),
                    dataSource: MeetingDataSource(context, snapshot),
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator,
                      showAgenda: true,
                      numberOfWeeksInView: 6,
                      appointmentDisplayCount: 10,
                      agendaStyle: AgendaStyle(
                        backgroundColor: Color(0xffE8E8E8),
                        dayTextStyle:
                            TextStyle(fontSize: 16, color: Colors.black),
                        dateTextStyle:
                            TextStyle(fontSize: 25, color: Colors.black),
                        placeholderTextStyle:
                            TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                    ),
                    onTap: (calendarTapDetails) {
                      if (calendarTapDetails.appointments != null &&
                          calendarTapDetails.targetElement ==
                              CalendarElement.appointment) {
                        final item = calendarTapDetails.appointments![0]
                            as AppointmentData;
                        CalenderBottomSheetsUtil(
                          context: context,
                          metingDetails: item,
                          language:
                              bloc.box.get(DatabaseFieldConstant.language),
                        ).bookMeetingBottomSheet(
                          cancel: () {
                            CancelBookingBottomSheetsUtil()
                                .bookMeetingBottomSheet(
                              context: context,
                              confirm: () {
                                bloc
                                    .cancelMeeting(item.id!)
                                    .whenComplete(() async {
                                  bloc
                                      .getClientAppointments(context)
                                      .then((value) {
                                    setState(() {});
                                  });
                                });
                              },
                            );
                          },
                          editNote: () {
                            CalenderBottomSheetsUtil(
                              context: context,
                              metingDetails: item,
                              language:
                                  bloc.box.get(DatabaseFieldConstant.language),
                            ).showAddEditNoteDialog(
                                note: item.noteFromClient ?? "",
                                confirm: (note) {
                                  bloc
                                      .editNoteMeeting(
                                          meetingId: item.id!, note: note)
                                      .whenComplete(() async {
                                    bloc
                                        .getClientAppointments(context)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  });
                                });
                          },
                        );
                      }
                    });
              }),
        ),
      ],
    );
  }
}
