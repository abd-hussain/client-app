import 'package:client_app/locator.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';
import 'package:client_app/screens/mycalender_tab/mycalender_bloc.dart';
import 'package:client_app/screens/mycalender_tab/utils/calender_bottom_sheet.dart';
import 'package:client_app/screens/mycalender_tab/utils/meeting_datasource.dart';
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
        const SizedBox(height: 8),
        Expanded(
          child: StreamBuilder<List<CalenderMeetings>>(
              initialData: const [],
              stream: locator<MainContainerBloc>().eventsMeetingsListStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SfCalendar(
                      view: CalendarView.month,
                      firstDayOfWeek: 6,
                      allowAppointmentResize: true,
                      initialSelectedDate: DateTime.now(),
                      todayHighlightColor: const Color(0xff4CB6EA),
                      dataSource: MeetingDataSource(context, snapshot.data!),
                      monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                        showAgenda: true,
                        numberOfWeeksInView: 6,
                        appointmentDisplayCount: 10,
                        agendaStyle: AgendaStyle(
                          backgroundColor: Color(0xffE8E8E8),
                          dayTextStyle: TextStyle(fontSize: 16, color: Colors.black),
                          dateTextStyle: TextStyle(fontSize: 25, color: Colors.black),
                          placeholderTextStyle: TextStyle(fontSize: 25, color: Colors.grey),
                        ),
                      ),
                      onTap: (calendarTapDetails) {
                        if (calendarTapDetails.appointments != null &&
                            calendarTapDetails.targetElement == CalendarElement.appointment) {
                          final item = calendarTapDetails.appointments![0] as CalenderMeetings;
                          final soso = CalenderBottomSheetsUtil(
                            context: context,
                            metingDetails: item,
                            language: bloc.box.get(DatabaseFieldConstant.language),
                          );

                          soso.bookMeetingBottomSheet(
                            cancel: () {
                              bloc.cancelMeeting(item.meetingId!).whenComplete(() async {
                                locator<MainContainerBloc>().getAppointmentsAndEvents();

                                setState(() {});
                              });
                            },
                            editNote: () {
                              soso.addNoteMeetingBottomSheet(confirm: (value) {
                                bloc.editNoteMeeting(meetingId: item.meetingId!, note: value).whenComplete(() async {
                                  locator<MainContainerBloc>().getAppointmentsAndEvents();
                                  setState(() {});
                                });
                              });
                            },
                            openEventDetails: () {
                              //TODO
                              // Navigator.of(context, rootNavigator: true)
                              //     .pushNamed(RoutesConstants.eventDetailsScreen, arguments: {
                              //   "event_details": MainEvent(
                              //     title: item.title!,
                              //     id: item.reservationId,
                              //     image: "",
                              //     description: "",
                              //     joiningClients: 0,
                              //     maxNumberOfAttendance: 0,
                              //     dateFrom: item.fromTime.toString(),
                              //     dateTo: item.toTime.toString(),
                              //     price: 0,
                              //     state: 0,
                              //   )
                              // });
                            },
                          );
                        }
                      });
                } else {
                  return const SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }
}
