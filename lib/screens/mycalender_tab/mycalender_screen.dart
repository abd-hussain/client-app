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
            child: SfCalendar(
              view: CalendarView.month,
              firstDayOfWeek: 6,
              dataSource: MeetingDataSource(bloc.getDataSource()),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true,
                numberOfWeeksInView: 6,
                appointmentDisplayCount: 10,
              ),
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.appointments != null &&
                    calendarTapDetails.targetElement == CalendarElement.appointment) {
                  //TODO handle Clicke
                  print(calendarTapDetails.appointments![0].eventName);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
