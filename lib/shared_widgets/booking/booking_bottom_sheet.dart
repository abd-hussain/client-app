import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/shared_widgets/booking/widgets/meeting_times_view.dart';
import 'package:client_app/shared_widgets/booking/widgets/parser.dart';
import 'package:client_app/shared_widgets/booking/widgets/points_in_last_view.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:client_app/shared_widgets/booking/widgets/cell_of_booking.dart';
import 'package:client_app/shared_widgets/custom_button.dart';

enum BookingFaze { one, two, three }

class BookingBottomSheetsUtil {
  final BuildContext context;
  final double hourRate;
  final String language;

  final List<int>? workingHoursSaturday;
  final List<int>? workingHoursSunday;
  final List<int>? workingHoursMonday;
  final List<int>? workingHoursTuesday;
  final List<int>? workingHoursWednesday;
  final List<int>? workingHoursThursday;
  final List<int>? workingHoursFriday;
  final List<AppointmentData> listOfAppointments;

  BookingBottomSheetsUtil({
    required this.workingHoursSaturday,
    required this.workingHoursSunday,
    required this.workingHoursMonday,
    required this.workingHoursTuesday,
    required this.workingHoursWednesday,
    required this.workingHoursThursday,
    required this.workingHoursFriday,
    required this.listOfAppointments,
    required this.context,
    required this.hourRate,
    this.language = "en",
  });

  ValueNotifier<Timing> selectedMeetingDuration = ValueNotifier<Timing>(Timing.halfHour);
  ValueNotifier<DateTime> selectedMeetingDate = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<int?> selectedMeetingTime = ValueNotifier<int?>(null);

  Future bookMeetingBottomSheet({
    required BookingFaze faze,
    required Function() openNext,
    required Function(
      String meetingduration,
      String meetingtime,
      String meetingdate,
      String meetingday,
      String meetingcost,
    )
        doneSelection,
  }) async {
    return await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      enableDrag: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
          child: Wrap(children: [
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                const Expanded(child: SizedBox()),
                CustomText(
                  title: AppLocalizations.of(context)!.booknow,
                  textColor: const Color(0xff444444),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Center(
              child: CustomText(
                title: "${faze == BookingFaze.one ? 1 : faze == BookingFaze.two ? 2 : 3} / 3",
                textColor: const Color(0xff444444),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            faze == BookingFaze.one
                ? faze1View(
                    context: context,
                    hourRate: hourRate,
                    openNext: () => openNext(),
                  )
                : faze == BookingFaze.two
                    ? faze2View(
                        context: context,
                        hourRate: hourRate,
                        openNext: () => openNext(),
                      )
                    : faze3View(
                        context: context,
                        hourRate: hourRate,
                        doneSelection: () => doneSelection(
                          ParserTimer().getTime(selectedMeetingDuration.value),
                          ParserTimer().getHours(selectedMeetingTime.value!),
                          DayTime().dateFormatter(selectedMeetingDate.value.toString()),
                          DayTime().dayFormatter(selectedMeetingDate.value.toString()),
                          Currency().calculateHourRate(hourRate, selectedMeetingDuration.value),
                        ),
                      ),
          ]),
        );
      },
    );
  }

  Widget faze1View({required BuildContext context, required double hourRate, required Function() openNext}) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomText(
          title: AppLocalizations.of(context)!.meetingduration,
          textColor: const Color(0xff444444),
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<Timing?>(
            valueListenable: selectedMeetingDuration,
            builder: (context, snapshot, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BookingCell(
                    title: "15 ${AppLocalizations.of(context)!.min}",
                    isSelected: (snapshot ?? Timing.hour) == Timing.quarterHour,
                    onPress: () {
                      selectedMeetingDuration.value = Timing.quarterHour;
                    },
                  ),
                  BookingCell(
                    title: "30 ${AppLocalizations.of(context)!.min}",
                    isSelected: (snapshot ?? Timing.hour) == Timing.halfHour,
                    onPress: () {
                      selectedMeetingDuration.value = Timing.halfHour;
                    },
                  ),
                  BookingCell(
                    title: "45  ${AppLocalizations.of(context)!.min}",
                    isSelected: (snapshot ?? Timing.hour) == Timing.threeQuarter,
                    onPress: () {
                      selectedMeetingDuration.value = Timing.threeQuarter;
                    },
                  ),
                  BookingCell(
                    title: "60 ${AppLocalizations.of(context)!.min}",
                    isSelected: (snapshot ?? Timing.hour) == Timing.hour,
                    onPress: () {
                      selectedMeetingDuration.value = Timing.hour;
                    },
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<Timing?>(
                      valueListenable: selectedMeetingDuration,
                      builder: (context, selectedMeetingDurationSnapshot, child) {
                        return footerBottomSheet(
                          context: context,
                          hourRate: hourRate,
                          selectedMeetingDuration: selectedMeetingDurationSnapshot,
                          isButtonEnable: selectedMeetingDurationSnapshot != null ? true : false,
                          openNext: () {
                            Navigator.pop(context);
                            openNext();
                          },
                        );
                      })
                ],
              );
            }),
      ],
    );
  }

  Widget faze2View({required BuildContext context, required double hourRate, required Function() openNext}) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomText(
          title: AppLocalizations.of(context)!.meetingdate,
          textColor: const Color(0xff444444),
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        SfCalendar(
          view: CalendarView.month,
          firstDayOfWeek: 6,
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            numberOfWeeksInView: 6,
            appointmentDisplayCount: 10,
          ),
          minDate: DateTime.now(),
          initialSelectedDate: DateTime.now(),
          onTap: (calendarTapDetails) {
            selectedMeetingDate.value = calendarTapDetails.date!;
            selectedMeetingTime.value = null;
          },
        ),
        const SizedBox(height: 8),
        CustomText(
          title: AppLocalizations.of(context)!.meetingtime,
          textColor: const Color(0xff444444),
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<DateTime>(
            valueListenable: selectedMeetingDate,
            builder: (context, snapshot, child) {
              return Column(
                children: [
                  MeetingTimeView(
                    workingHours: _getWorkingDayForSelectedDate(snapshot),
                    selectedMeetingDate: snapshot,
                    selectedMeetingTime: selectedMeetingTime,
                    listOfAppointments: listOfAppointments,
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<int?>(
                      valueListenable: selectedMeetingTime,
                      builder: (context, snapshot2, child) {
                        return footerBottomSheet(
                          context: context,
                          hourRate: hourRate,
                          isButtonEnable: snapshot != null && snapshot2 != null,
                          selectedMeetingDuration: selectedMeetingDuration.value,
                          openNext: () {
                            Navigator.pop(context);
                            openNext();
                          },
                        );
                      })
                ],
              );
            }),
      ],
    );
  }

  Widget faze3View({required BuildContext context, required double hourRate, required Function() doneSelection}) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(color: const Color(0xffE4E9EF), borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.security,
              color: Color(0xff444444),
              size: 100,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomText(
          title: AppLocalizations.of(context)!.bookinglaststeptitle,
          textColor: const Color(0xff444444),
          fontSize: 14,
          maxLins: 3,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 20),
        PointsInLastViewBooking(
          number: "1",
          text: AppLocalizations.of(context)!.bookinglaststeptext1,
        ),
        const SizedBox(height: 20),
        PointsInLastViewBooking(
          number: "2",
          text: AppLocalizations.of(context)!.bookinglaststeptext2,
        ),
        const SizedBox(height: 20),
        PointsInLastViewBooking(
          number: "3",
          text: AppLocalizations.of(context)!.bookinglaststeptext3,
        ),
        const SizedBox(height: 20),
        footerBottomSheet(
          context: context,
          hourRate: hourRate,
          isButtonEnable: true,
          selectedMeetingDuration: selectedMeetingDuration.value,
          openNext: () {
            Navigator.pop(context);
            doneSelection();
          },
        )
      ],
    );
  }

  Widget footerBottomSheet(
      {required BuildContext context,
      required bool isButtonEnable,
      required Timing? selectedMeetingDuration,
      required double hourRate,
      required Function() openNext}) {
    return Column(
      children: [
        Container(height: 1, color: const Color(0xff444444)),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  CustomText(
                    title: selectedMeetingDuration == null
                        ? "00 JD"
                        : Currency().calculateHourRate(hourRate, selectedMeetingDuration),
                    textColor: const Color(0xff444444),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  CustomText(
                    title: selectedMeetingDuration == null
                        ? "00 ${AppLocalizations.of(context)!.min}"
                        : "${ParserTimer().getTime(selectedMeetingDuration)} ${AppLocalizations.of(context)!.min}",
                    textColor: const Color(0xff444444),
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: CustomButton(
                enableButton: isButtonEnable,
                buttonTitle: AppLocalizations.of(context)!.next,
                onTap: () {
                  openNext();
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  List<int> _getWorkingDayForSelectedDate(DateTime dateTime) {
    final dayOfTheWeek = DateFormat('EEEE').format(dateTime);

    if (dayOfTheWeek == "Saturday") {
      return workingHoursSaturday ?? [];
    } else if (dayOfTheWeek == "Sunday") {
      return workingHoursSunday ?? [];
    } else if (dayOfTheWeek == "Monday") {
      return workingHoursMonday ?? [];
    } else if (dayOfTheWeek == "Tuesday") {
      return workingHoursTuesday ?? [];
    } else if (dayOfTheWeek == "Wednesday") {
      return workingHoursWednesday ?? [];
    } else if (dayOfTheWeek == "Thursday") {
      return workingHoursThursday ?? [];
    } else if (dayOfTheWeek == "Friday") {
      return workingHoursFriday ?? [];
    } else {
      return [];
    }
  }
}
