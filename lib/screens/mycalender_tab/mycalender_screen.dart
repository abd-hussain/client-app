import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/screens/mycalender_tab/mycalender_bloc.dart';
import 'package:client_app/screens/mycalender_tab/utils/calender_bottom_sheet.dart';
import 'package:client_app/screens/mycalender_tab/utils/meeting_datasource.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/routes.dart';
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
    return Scaffold(
      body: Column(
        children: [
          const HeaderHomePage(),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<CalenderMeetings>>(
                initialData: [],
                future: bloc.getClientAppointments(),
                builder: (context, snapshot) {
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
                          CalenderBottomSheetsUtil(
                            context: context,
                            metingDetails: item,
                            language: bloc.box.get(DatabaseFieldConstant.language),
                          ).bookMeetingBottomSheet(
                            cancel: () {
                              if (item.type == Type.meeting) {
                                bloc.cancelMeeting(item.meetingId).whenComplete(() async {
                                  await bloc.getClientAppointments();
                                  setState(() {});
                                });
                              } else if (item.type == Type.event) {
                                bloc.cancelEvent(item.meetingId).whenComplete(() async {
                                  await bloc.getClientAppointments();
                                  setState(() {});
                                });
                              }
                            },
                            openEventDetails: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(RoutesConstants.eventDetailsScreen, arguments: {
                                "event_details": MainEvent(
                                  title: item.title!,
                                  id: item.meetingId,
                                  image: "",
                                  description: "",
                                  joiningClients: 0,
                                  maxNumberOfAttendance: 0,
                                  dateFrom: item.fromTime.toString(),
                                  dateTo: item.toTime.toString(),
                                  price: 0,
                                  state: 0,
                                )
                              });
                            },
                          );
                        }
                      });
                }),
          ),
        ],
      ),
    );
  }
}
