import 'package:client_app/shared_widgets/booking/booking_bottom_sheet.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO  HERE
class InstantBookingBottomSheetsUtil {
  final BuildContext context;
  final String language;

  InstantBookingBottomSheetsUtil({
    required this.context,
    this.language = "en",
  });

  Future bookMeetingBottomSheet({
    required BookingFaze faze,
    required Function() openNext,
    required Function(
      String meetingType,
      String meetingduration,
      String meetingtime,
      String meetingdate,
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
                title: "${faze == BookingFaze.one ? 1 : faze == BookingFaze.two ? 2 : 3} / 3",
                textColor: const Color(0xff444444),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // faze == BookingFaze.one
            //     ? faze1View(
            //         context: context,
            //         hourRate: hourRate,
            //         openNext: () => openNext(),
            //       )
            //     : faze == BookingFaze.two
            //         ? faze2View(
            //             context: context,
            //             hourRate: hourRate,
            //             openNext: () => openNext(),
            //           )
            //         : faze3View(
            //             context: context,
            //             hourRate: hourRate,
            //             doneSelection: () => doneSelection(
            //               AppLocalizations.of(context)!.bookingonetime,
            //               ParserTimer().getTime(selectedMeetingDuration.value),
            //               ParserTimer().getHours(selectedMeetingTime.value!),
            //               DayTime().dateFormatter(selectedMeetingDate.value.toString()),
            //               Currency().calculateHourRate(hourRate, selectedMeetingDuration.value),
            //             ),
            //           ),
          ]),
        );
      },
    );
  }
}
