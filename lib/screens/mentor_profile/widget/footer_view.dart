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
  final String suffixeName;
  final String firstName;
  final String lastName;
  final String profileImageUrl;
  final String categoryName;
  final List<int>? workingHoursSaturday;
  final List<int>? workingHoursSunday;
  final List<int>? workingHoursMonday;
  final List<int>? workingHoursTuesday;
  final List<int>? workingHoursWednesday;
  final List<int>? workingHoursThursday;
  final List<int>? workingHoursFriday;

  const MentorProfileFooterView({
    required this.hourRate,
    super.key,
    required this.suffixeName,
    required this.firstName,
    required this.lastName,
    required this.categoryName,
    required this.profileImageUrl,
    required this.workingHoursSaturday,
    required this.workingHoursSunday,
    required this.workingHoursMonday,
    required this.workingHoursTuesday,
    required this.workingHoursWednesday,
    required this.workingHoursThursday,
    required this.workingHoursFriday,
  });

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
              title: "30 ${AppLocalizations.of(context)!.min}",
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
                final bottomSheet = BookingBottomSheetsUtil(
                  context: context,
                  hourRate: hourRate,
                  language: box.get(DatabaseFieldConstant.language),
                  workingHoursSaturday: workingHoursSaturday,
                  workingHoursSunday: workingHoursSunday,
                  workingHoursFriday: workingHoursFriday,
                  workingHoursThursday: workingHoursThursday,
                  workingHoursMonday: workingHoursMonday,
                  workingHoursTuesday: workingHoursTuesday,
                  workingHoursWednesday: workingHoursWednesday,
                );
                await bottomSheet.bookMeetingBottomSheet(
                  faze: BookingFaze.one,
                  openNext: () async {
                    await bottomSheet.bookMeetingBottomSheet(
                      faze: BookingFaze.two,
                      openNext: () async {
                        await bottomSheet.bookMeetingBottomSheet(
                          faze: BookingFaze.three,
                          openNext: () => null,
                          doneSelection: (meetingType, meetingduration, meetingtime, meetingdate, meetingcost) {
                            Navigator.of(context, rootNavigator: true).pushNamed(
                              RoutesConstants.bookingScreen,
                              arguments: {
                                "profileImageUrl": profileImageUrl,
                                "suffixeName": suffixeName,
                                "firstName": firstName,
                                "lastName": lastName,
                                "categoryName": categoryName,
                                "meetingType": meetingType,
                                "meetingduration": meetingduration,
                                "meetingtime": meetingtime,
                                "meetingdate": meetingdate,
                                "meetingcost": meetingcost
                              },
                            );
                          },
                        );
                      },
                      doneSelection: (meetingType, meetingdate, meetingduration, meetingtime, meetingcost) => null,
                    );
                  },
                  doneSelection: (meetingType, meetingdate, meetingduration, meetingtime, meetingcost) => null,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
