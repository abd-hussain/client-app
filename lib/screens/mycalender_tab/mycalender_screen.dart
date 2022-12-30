import 'package:client_app/models/https/calender_model.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/screens/mycalender_tab/mycalender_bloc.dart';
import 'package:client_app/screens/mycalender_tab/utils/meeting_datasource.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalenderScreen extends StatefulWidget {
  const MyCalenderScreen({super.key});

  @override
  State<MyCalenderScreen> createState() => _MyCalenderScreenState();
}

class _MyCalenderScreenState extends State<MyCalenderScreen> {
  final bloc = MyCalenderBloc();

  //TODO : return data from server
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
                        //TODO handle Clicke
                        print(calendarTapDetails.appointments![0].eventName);
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
