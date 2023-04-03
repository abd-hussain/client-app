import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/shared_widgets/booking/booking_bottom_sheet.dart';
import 'package:client_app/shared_widgets/booking/widgets/cell_of_booking.dart';
import 'package:client_app/shared_widgets/booking/widgets/parser.dart';
import 'package:client_app/shared_widgets/booking/widgets/points_in_last_view.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstantBookingBottomSheetsUtil {
  final BuildContext context;
  final String language;
  final List<Category> listOfCategories;

  InstantBookingBottomSheetsUtil({
    required this.listOfCategories,
    required this.context,
    this.language = "en",
  });

  ValueNotifier<String?> selectedCategories = ValueNotifier<String?>(null);
  ValueNotifier<Timing> selectedMeetingDuration = ValueNotifier<Timing>(Timing.halfHour);
  int selectedCategoryID = 0;

  Future bookMeetingBottomSheet({
    required BookingFaze faze,
    required Function() openNext,
    required Function({required int categoryID, required String categoryName, required String meetingduration})
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
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 20),
          child: Wrap(children: [
            Row(
              children: [
                const SizedBox(width: 50),
                const Expanded(child: SizedBox()),
                CustomText(
                  title: AppLocalizations.of(context)!.meetingnow,
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
                title: "${faze == BookingFaze.one ? 1 : 2} / 2",
                textColor: const Color(0xff444444),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            faze == BookingFaze.one
                ? faze1View(
                    context: context,
                    listOfCategories: listOfCategories,
                    openNext: () => openNext(),
                  )
                : faze2View(
                    context: context,
                    doneSelection: () => doneSelection(
                        categoryID: selectedCategoryID,
                        categoryName: selectedCategories.value!,
                        meetingduration: ParserTimer().getTime(selectedMeetingDuration.value)),
                  ),
          ]),
        );
      },
    );
  }

  Widget faze1View(
      {required BuildContext context, required List<Category> listOfCategories, required Function() openNext}) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomText(
          title: AppLocalizations.of(context)!.specialist,
          textColor: const Color(0xff444444),
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 190,
          child: ValueListenableBuilder<String?>(
              valueListenable: selectedCategories,
              builder: (context, snapshot, child) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 50),
                    shrinkWrap: true,
                    itemCount: listOfCategories.length,
                    itemBuilder: (context, index) {
                      return BookingCell(
                        title: listOfCategories[index].name!,
                        isSelected: snapshot != null ? snapshot == listOfCategories[index].name! : false,
                        onPress: () {
                          selectedCategories.value = listOfCategories[index].name!;
                          selectedCategoryID = listOfCategories[index].id!;
                        },
                      );
                    });
              }),
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
                    title: "45 ${AppLocalizations.of(context)!.min}",
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
                  ValueListenableBuilder<String?>(
                      valueListenable: selectedCategories,
                      builder: (context, selectedCategoriesSnapshot, child) {
                        return footerBottomSheet(
                          context: context,
                          selectedMeetingDuration: snapshot,
                          isButtonEnable: selectedCategoriesSnapshot != null ? true : false,
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

  Widget faze2View({required BuildContext context, required Function() doneSelection}) {
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
        PointsInLastViewBooking(
          number: "4",
          text: AppLocalizations.of(context)!.bookinglaststeptext4,
        ),
        const SizedBox(height: 20),
        footerBottomSheet(
          context: context,
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
                        ? "00 ${AppLocalizations.of(context)!.min}"
                        : "${ParserTimer().getTime(selectedMeetingDuration)} ${AppLocalizations.of(context)!.min}",
                    textColor: const Color(0xff444444),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
