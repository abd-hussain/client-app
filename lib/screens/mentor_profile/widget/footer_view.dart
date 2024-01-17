import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
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
  final bool isUserLoggedin;
  final int mentorId;
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
  final List<AppointmentData> listOfAppointments;

  const MentorProfileFooterView({
    required this.isUserLoggedin,
    required this.mentorId,
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
    required this.listOfAppointments,
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
              title:
                  Currency().calculateHourRate(hourRate, Timing.halfHour, "JD"),
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
                if (isUserLoggedin) {
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
                    listOfAppointments: listOfAppointments,
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
                            doneSelection: (meetingduration, meetingtime,
                                meetingdate, meetingday, meetingcost) {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                                RoutesConstants.bookingScreen,
                                arguments: {
                                  "bookingType": BookingType.schudule,
                                  "profileImageUrl": profileImageUrl,
                                  "suffixeName": suffixeName,
                                  "firstName": firstName,
                                  "lastName": lastName,
                                  "mentor_id": mentorId,
                                  "categoryName": categoryName,
                                  "meetingduration": meetingduration,
                                  "meetingtime": meetingtime,
                                  "meetingdate": meetingdate,
                                  "meetingday": meetingday,
                                  "meetingcost": meetingcost
                                },
                              );
                            },
                          );
                        },
                        doneSelection: (meetingdate, meetingduration,
                                meetingtime, meetingday, meetingcost) =>
                            null,
                      );
                    },
                    doneSelection: (meetingdate, meetingduration, meetingtime,
                            meetingday, meetingcost) =>
                        null,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!
                          .youhavetobeloggedintodothat),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
