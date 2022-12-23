import 'package:client_app/shared_widgets/booking/widgets/parser.dart';
import 'package:client_app/shared_widgets/booking/widgets/points_in_last_view.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:client_app/shared_widgets/booking/widgets/cell_of_booking.dart';
import 'package:client_app/shared_widgets/custom_button.dart';

enum BookingFaze { one, two, three }

class BookingBottomSheetsUtil {
  ValueNotifier<Timing> selectedMeetingDuration = ValueNotifier<Timing>(Timing.halfHour);
  ValueNotifier<DateTime?> selectedMeetingDate = ValueNotifier<DateTime?>(null);
  ValueNotifier<int?> selectedMeetingTime = ValueNotifier<int?>(null);

  Future bookMeetingBottomSheet(
      {required BuildContext context,
      required double hourRate,
      required BookingFaze faze,
      String language = "en",
      required Function() openNext}) async {
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
                        openNext: () => openNext(),
                      )
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
          title: AppLocalizations.of(context)!.meetingtype,
          textColor: const Color(0xff444444),
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        BookingCell(
          title: AppLocalizations.of(context)!.bookingonetime,
          isSelected: true,
          onPress: () {},
        ),
        const SizedBox(height: 8),
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
          onTap: (calendarTapDetails) {
            selectedMeetingDate.value = calendarTapDetails.date;
          },
        ),
        const SizedBox(height: 8),
        CustomText(
          title: AppLocalizations.of(context)!.meetingtime,
          textColor: const Color(0xff444444),
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<int?>(
            valueListenable: selectedMeetingTime,
            builder: (context, snapshot, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: BookingCell(
                          title: "9:00 a.m",
                          isSelected: (snapshot ?? 0) == 9,
                          onPress: () {
                            selectedMeetingTime.value = 9;
                          },
                        ),
                      ),
                      Expanded(
                        child: BookingCell(
                          title: "10:00 a.m",
                          isSelected: (snapshot ?? 0) == 10,
                          onPress: () {
                            selectedMeetingTime.value = 10;
                          },
                        ),
                      ),
                      Expanded(
                        child: BookingCell(
                          title: "11:00 a.m",
                          isSelected: (snapshot ?? 0) == 11,
                          onPress: () {
                            selectedMeetingTime.value = 11;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: BookingCell(
                          title: "12:00 a.m",
                          isSelected: (snapshot ?? 0) == 12,
                          onPress: () {
                            selectedMeetingTime.value = 12;
                          },
                        ),
                      ),
                      Expanded(
                        child: BookingCell(
                          title: "1:00 p.m",
                          isSelected: (snapshot ?? 0) == 13,
                          onPress: () {
                            selectedMeetingTime.value = 13;
                          },
                        ),
                      ),
                      Expanded(
                        child: BookingCell(
                          title: "2:00 p.m",
                          isSelected: (snapshot ?? 0) == 14,
                          onPress: () {
                            selectedMeetingTime.value = 14;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: BookingCell(
                          title: "3:00 p.m",
                          isSelected: (snapshot ?? 0) == 15,
                          onPress: () {
                            selectedMeetingTime.value = 15;
                          },
                        ),
                      ),
                      Expanded(
                        child: BookingCell(
                          title: "4:00 p.m",
                          isSelected: (snapshot ?? 0) == 16,
                          onPress: () {
                            selectedMeetingTime.value = 16;
                          },
                        ),
                      ),
                      Expanded(
                        child: BookingCell(
                          title: "5:00 p.m",
                          isSelected: (snapshot ?? 0) == 17,
                          onPress: () {
                            selectedMeetingTime.value = 17;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: BookingCell(
                          title: "6:00 p.m",
                          isSelected: (snapshot ?? 0) == 18,
                          onPress: () {
                            selectedMeetingTime.value = 18;
                          },
                        ),
                      ),
                      Expanded(
                        child: BookingCell(
                          title: "7:00 p.m",
                          isSelected: (snapshot ?? 0) == 19,
                          onPress: () {
                            selectedMeetingTime.value = 19;
                          },
                        ),
                      ),
                      Expanded(
                        child: BookingCell(
                          title: "8:00 p.m",
                          isSelected: (snapshot ?? 0) == 20,
                          onPress: () {
                            selectedMeetingTime.value = 20;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<DateTime?>(
                      valueListenable: selectedMeetingDate,
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

  Widget faze3View({required BuildContext context, required double hourRate, required Function() openNext}) {
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
            openNext();
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
}
