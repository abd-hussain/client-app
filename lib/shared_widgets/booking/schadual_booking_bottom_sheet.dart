import 'package:client_app/models/https/mentor_appoitments.dart';
import 'package:client_app/models/https/mentor_details_model.dart';
import 'package:client_app/shared_widgets/booking/widgets/meeting_times_view.dart';
import 'package:client_app/shared_widgets/booking/widgets/parser.dart';
import 'package:client_app/shared_widgets/booking/widgets/points_in_last_view.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:client_app/shared_widgets/booking/widgets/cell_of_booking.dart';
import 'package:client_app/shared_widgets/custom_button.dart';

enum SchaduleBookingFaze { one, two, three, four }

class SchaduleBookingBottomSheetsUtil {
  ValueNotifier<Major?> selectedMajor = ValueNotifier<Major?>(null);
  ValueNotifier<Timing> selectedMeetingDuration =
      ValueNotifier<Timing>(Timing.halfHour);
  ValueNotifier<DateTime> selectedMeetingDate =
      ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<int?> selectedMeetingTime = ValueNotifier<int?>(null);
  ValueNotifier<SchaduleBookingFaze> registrationFase =
      ValueNotifier<SchaduleBookingFaze>(SchaduleBookingFaze.one);

  Future bookMeetingBottomSheet({
    required BuildContext context,
    required double hourRate,
    required String currency,
    required bool freeCall,
    required List<Major> listOfMajors,
    required List<int>? workingHoursSaturday,
    required List<int>? workingHoursSunday,
    required List<int>? workingHoursMonday,
    required List<int>? workingHoursTuesday,
    required List<int>? workingHoursWednesday,
    required List<int>? workingHoursThursday,
    required List<int>? workingHoursFriday,
    required List<MentorAppointmentsResponseData> listOfAppointments,
    required Function(
      Major selectedMajor,
      Timing selectedMeetingDuration,
      DateTime selectedMeetingDate,
      int selectedMeetingTime,
    ) onEndSelection,
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
          padding:
              const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
          child: Wrap(
            children: [
              Row(
                children: [
                  const SizedBox(width: 50),
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
              ValueListenableBuilder<SchaduleBookingFaze>(
                valueListenable: registrationFase,
                builder: (context, snapshotFase, child) {
                  return Column(
                    children: [
                      Center(
                        child: CustomText(
                          title: faseTitle(snapshotFase),
                          textColor: const Color(0xff444444),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      showCorrectViewDependOnFase(
                        fase: snapshotFase,
                        context: context,
                        hourRate: hourRate,
                        freeCall: freeCall,
                        listOfMajors: listOfMajors,
                        currency: currency,
                        workingHoursSaturday: workingHoursSaturday,
                        workingHoursSunday: workingHoursSunday,
                        workingHoursMonday: workingHoursMonday,
                        workingHoursTuesday: workingHoursTuesday,
                        workingHoursWednesday: workingHoursWednesday,
                        workingHoursThursday: workingHoursThursday,
                        workingHoursFriday: workingHoursFriday,
                        listOfAppointments: listOfAppointments,
                        onEndSelection: (major, duration, date, time) {
                          Navigator.pop(context);
                          onEndSelection(major, duration, date, time);
                        },
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget faze1View({
    required BuildContext context,
    required List<Major> listOfMajors,
    required double hourRate,
    required String currency,
    required bool freeCall,
  }) {
    return ValueListenableBuilder<Major?>(
        valueListenable: selectedMajor,
        builder: (context, selectedMajorSnapshot, child) {
          return Column(
            children: [
              const SizedBox(height: 10),
              CustomText(
                title: "-- ${AppLocalizations.of(context)!.majors} --",
                textColor: const Color(0xff444444),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 400,
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            childAspectRatio: 1,
                            mainAxisExtent: 100),
                    itemCount: listOfMajors.length,
                    itemBuilder: (context, index) {
                      return BookingCell(
                        title: listOfMajors[index].name!,
                        isSelected: selectedMajorSnapshot != null
                            ? selectedMajorSnapshot == listOfMajors[index]
                            : false,
                        onPress: () {
                          selectedMajor.value = listOfMajors[index];
                        },
                      );
                    }),
              ),
              const SizedBox(height: 8),
              footerBottomSheet(
                context: context,
                majorName: selectedMajorSnapshot != null
                    ? selectedMajorSnapshot.name!
                    : "",
                selectedMeetingDuration: null,
                currency: currency,
                freeCall: freeCall,
                hourRate: hourRate,
                isButtonEnable: selectedMajorSnapshot != null ? true : false,
                openNext: () {
                  registrationFase.value = SchaduleBookingFaze.two;
                },
              ),
            ],
          );
        });
  }

  Widget faze2View({
    required BuildContext context,
    required double hourRate,
    required String currency,
    required bool freeCall,
  }) {
    return ValueListenableBuilder<Timing?>(
        valueListenable: selectedMeetingDuration,
        builder: (context, selectedDurationsSnapshot, child) {
          return Column(
            children: [
              const SizedBox(height: 10),
              CustomText(
                title: AppLocalizations.of(context)!.meetingduration,
                textColor: const Color(0xff444444),
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              BookingCell(
                title:
                    "15 ${AppLocalizations.of(context)!.min} ${freeCall ? "(${AppLocalizations.of(context)!.free})" : ""}",
                isSelected: (selectedDurationsSnapshot ?? Timing.hour) ==
                    Timing.quarterHour,
                onPress: () {
                  selectedMeetingDuration.value = Timing.quarterHour;
                },
              ),
              BookingCell(
                title: "30 ${AppLocalizations.of(context)!.min}",
                isSelected: (selectedDurationsSnapshot ?? Timing.hour) ==
                    Timing.halfHour,
                onPress: () {
                  selectedMeetingDuration.value = Timing.halfHour;
                },
              ),
              BookingCell(
                title: "45  ${AppLocalizations.of(context)!.min}",
                isSelected: (selectedDurationsSnapshot ?? Timing.hour) ==
                    Timing.threeQuarter,
                onPress: () {
                  selectedMeetingDuration.value = Timing.threeQuarter;
                },
              ),
              BookingCell(
                title: "60 ${AppLocalizations.of(context)!.min}",
                isSelected:
                    (selectedDurationsSnapshot ?? Timing.hour) == Timing.hour,
                onPress: () {
                  selectedMeetingDuration.value = Timing.hour;
                },
              ),
              const SizedBox(height: 8),
              footerBottomSheet(
                context: context,
                majorName: selectedMajor.value!.name!,
                selectedMeetingDuration: selectedDurationsSnapshot,
                hourRate: hourRate,
                freeCall: freeCall,
                currency: currency,
                isButtonEnable:
                    selectedDurationsSnapshot != null ? true : false,
                openNext: () {
                  registrationFase.value = SchaduleBookingFaze.three;
                },
              )
            ],
          );
        });
  }

  Widget faze3View(
      {required BuildContext context,
      required double hourRate,
      required String currency,
      required bool freeCall,
      required List<int>? workingHoursSaturday,
      required List<int>? workingHoursSunday,
      required List<int>? workingHoursMonday,
      required List<int>? workingHoursTuesday,
      required List<int>? workingHoursWednesday,
      required List<int>? workingHoursThursday,
      required List<int>? workingHoursFriday,
      required List<MentorAppointmentsResponseData> listOfAppointments}) {
    return Column(
      children: [
        const SizedBox(height: 10),
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
                    workingHours: _getWorkingDayForSelectedDate(
                      dateTime: snapshot,
                      workingHoursSaturday: workingHoursSaturday,
                      workingHoursSunday: workingHoursSunday,
                      workingHoursMonday: workingHoursMonday,
                      workingHoursTuesday: workingHoursTuesday,
                      workingHoursWednesday: workingHoursWednesday,
                      workingHoursThursday: workingHoursThursday,
                      workingHoursFriday: workingHoursFriday,
                    ),
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
                          currency: currency,
                          freeCall: freeCall,
                          isButtonEnable: snapshot2 != null,
                          selectedMeetingDuration:
                              selectedMeetingDuration.value,
                          majorName: selectedMajor.value!.name!,
                          openNext: () {
                            registrationFase.value = SchaduleBookingFaze.four;
                          },
                        );
                      })
                ],
              );
            }),
      ],
    );
  }

  Widget faze4View(
      {required BuildContext context,
      required double hourRate,
      required String currency,
      required bool freeCall,
      required Function(
        Major selectedMajor,
        Timing selectedMeetingDuration,
        DateTime selectedMeetingDate,
        int selectedMeetingTime,
      ) onEndSelection}) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: const Color(0xffE4E9EF),
                borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.security,
              color: Color(0xff444444),
              size: 75,
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
          currency: currency,
          freeCall: freeCall,
          isButtonEnable: true,
          selectedMeetingDuration: selectedMeetingDuration.value,
          majorName: selectedMajor.value!.name!,
          openNext: () {
            onEndSelection(
              selectedMajor.value!,
              selectedMeetingDuration.value,
              selectedMeetingDate.value,
              selectedMeetingTime.value!,
            );
          },
        ),
      ],
    );
  }

  Widget footerBottomSheet(
      {required BuildContext context,
      required bool isButtonEnable,
      required String majorName,
      required bool freeCall,
      required Timing? selectedMeetingDuration,
      required double hourRate,
      required String currency,
      required Function() openNext}) {
    return Column(
      children: [
        Container(height: 1, color: const Color(0xff444444)),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    title: majorName,
                    textColor: const Color(0xff444444),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  CustomText(
                    title: selectedMeetingDuration == null
                        ? "00 $currency"
                        : Currency().calculateHourRate(hourRate,
                            selectedMeetingDuration, currency, freeCall),
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
            const SizedBox(width: 4),
            SizedBox(
              height: 80,
              child: CustomButton(
                padding: const EdgeInsets.only(top: 8),
                enableButton: isButtonEnable,
                width: MediaQuery.of(context).size.width / 4,
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

  List<int> _getWorkingDayForSelectedDate({
    required DateTime dateTime,
    required List<int>? workingHoursSaturday,
    required List<int>? workingHoursSunday,
    required List<int>? workingHoursMonday,
    required List<int>? workingHoursTuesday,
    required List<int>? workingHoursWednesday,
    required List<int>? workingHoursThursday,
    required List<int>? workingHoursFriday,
  }) {
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

  String faseTitle(SchaduleBookingFaze fase) {
    switch (fase) {
      case SchaduleBookingFaze.one:
        return "1/4";
      case SchaduleBookingFaze.two:
        return "2/4";
      case SchaduleBookingFaze.three:
        return "3/4";
      case SchaduleBookingFaze.four:
        return "4/4";
    }
  }

  Widget showCorrectViewDependOnFase(
      {required SchaduleBookingFaze fase,
      required BuildContext context,
      required double hourRate,
      required String currency,
      required bool freeCall,
      required List<Major> listOfMajors,
      required List<int>? workingHoursSaturday,
      required List<int>? workingHoursSunday,
      required List<int>? workingHoursMonday,
      required List<int>? workingHoursTuesday,
      required List<int>? workingHoursWednesday,
      required List<int>? workingHoursThursday,
      required List<int>? workingHoursFriday,
      required List<MentorAppointmentsResponseData> listOfAppointments,
      required Function(
        Major selectedMajor,
        Timing selectedMeetingDuration,
        DateTime selectedMeetingDate,
        int selectedMeetingTime,
      ) onEndSelection}) {
    switch (fase) {
      case SchaduleBookingFaze.one:
        return faze1View(
            context: context,
            listOfMajors: listOfMajors,
            hourRate: hourRate,
            currency: currency,
            freeCall: freeCall);
      case SchaduleBookingFaze.two:
        return faze2View(
            context: context,
            hourRate: hourRate,
            currency: currency,
            freeCall: freeCall);
      case SchaduleBookingFaze.three:
        return faze3View(
          context: context,
          hourRate: hourRate,
          currency: currency,
          freeCall: freeCall,
          workingHoursSaturday: workingHoursSaturday,
          workingHoursSunday: workingHoursSunday,
          workingHoursMonday: workingHoursMonday,
          workingHoursTuesday: workingHoursTuesday,
          workingHoursWednesday: workingHoursWednesday,
          workingHoursThursday: workingHoursThursday,
          workingHoursFriday: workingHoursFriday,
          listOfAppointments: listOfAppointments,
        );
      case SchaduleBookingFaze.four:
        return faze4View(
          context: context,
          hourRate: hourRate,
          currency: currency,
          freeCall: freeCall,
          onEndSelection: (major, duration, date, time) {
            onEndSelection(major, duration, date, time);
          },
        );
    }
  }
}
