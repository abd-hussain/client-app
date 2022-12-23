import 'package:client_app/shared_widgets/booking/booking_bottom_sheet.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MentorProfileFooterView extends StatelessWidget {
  final double hourRate;
  final int classMin;
  const MentorProfileFooterView({required this.hourRate, required this.classMin, super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(DatabaseBoxConstant.userInfo);

    return Container(
      color: const Color(0xffE4E9EF),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            CustomText(
              title: Currency().calculateHourRate(hourRate, Timing.halfHour),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff034061),
            ),
            const SizedBox(width: 5),
            const CustomText(
              title: "/",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: Color(0xff034061),
            ),
            const SizedBox(width: 5),
            CustomText(
              title: "$classMin ${AppLocalizations.of(context)!.min}",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff034061),
            ),
            const Expanded(child: SizedBox()),
            CustomButton(
              enableButton: true,
              width: MediaQuery.of(context).size.width * 0.3,
              buttonTitle: AppLocalizations.of(context)!.booknow,
              onTap: () async {
                final bottomSheet = BookingBottomSheetsUtil();
                await bottomSheet.bookMeetingBottomSheet(
                  context: context,
                  language: box.get(DatabaseFieldConstant.language),
                  hourRate: hourRate,
                  faze: BookingFaze.one,
                  openNext: () async {
                    await bottomSheet.bookMeetingBottomSheet(
                      context: context,
                      hourRate: hourRate,
                      language: box.get(DatabaseFieldConstant.language),
                      faze: BookingFaze.two,
                      openNext: () async {
                        await bottomSheet.bookMeetingBottomSheet(
                          context: context,
                          hourRate: hourRate,
                          language: box.get(DatabaseFieldConstant.language),
                          faze: BookingFaze.three,
                          openNext: () {
                            Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.bookingScreen);
                          },
                        );
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
