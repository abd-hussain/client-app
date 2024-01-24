import 'package:client_app/models/https/mentor_appoitments.dart';
import 'package:client_app/models/https/mentor_details_model.dart';
import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
import 'package:client_app/shared_widgets/booking/schadual_booking_bottom_sheet.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MentorProfileFooterView extends StatelessWidget {
  final bool isUserLoggedin;
  final int mentorId;
  final String currency;
  final double hourRate;
  final String suffixeName;
  final String firstName;
  final String lastName;
  final String gender;
  final bool freeCall;
  final int categoryID;
  final String countryName;
  final String countryFlag;
  final String profileImageUrl;
  final String categoryName;
  final List<Major> listOfMajors;
  final List<int>? workingHoursSaturday;
  final List<int>? workingHoursSunday;
  final List<int>? workingHoursMonday;
  final List<int>? workingHoursTuesday;
  final List<int>? workingHoursWednesday;
  final List<int>? workingHoursThursday;
  final List<int>? workingHoursFriday;
  final List<MentorAppointmentsResponseData> listOfAppointments;

  const MentorProfileFooterView({
    required this.isUserLoggedin,
    required this.mentorId,
    required this.currency,
    required this.hourRate,
    super.key,
    required this.suffixeName,
    required this.firstName,
    required this.lastName,
    required this.countryName,
    required this.countryFlag,
    required this.gender,
    required this.freeCall,
    required this.listOfMajors,
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
    required this.categoryID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE4E9EF),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            CustomText(
              title: Currency().calculateHourRate(
                  hourRate, Timing.halfHour, currency, false),
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
                  await SchaduleBookingBottomSheetsUtil()
                      .bookMeetingBottomSheet(
                    context: context,
                    hourRate: hourRate,
                    freeCall: freeCall,
                    currency: currency,
                    listOfMajors: listOfMajors,
                    workingHoursSaturday: workingHoursSaturday,
                    workingHoursSunday: workingHoursSunday,
                    workingHoursMonday: workingHoursMonday,
                    workingHoursTuesday: workingHoursTuesday,
                    workingHoursWednesday: workingHoursWednesday,
                    workingHoursThursday: workingHoursThursday,
                    workingHoursFriday: workingHoursFriday,
                    listOfAppointments: listOfAppointments,
                    onEndSelection: (
                      selectedMajor,
                      selectedMeetingDuration,
                      selectedMeetingDate,
                      selectedMeetingTime,
                    ) {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        RoutesConstants.bookingScreen,
                        arguments: {
                          "bookingType": BookingType.schudule,
                          "mentor_id": mentorId,
                          "profileImageUrl": profileImageUrl,
                          "suffixeName": suffixeName,
                          "firstName": firstName,
                          "lastName": lastName,
                          "hourRate": hourRate,
                          "currency": currency,
                          "gender": gender,
                          "freeCall": freeCall,
                          "categoryID": categoryID,
                          "categoryName": categoryName,
                          "meetingduration": selectedMeetingDuration,
                          "majorID": selectedMajor.id,
                          "majorName": selectedMajor.name,
                          "countryName": countryName,
                          "countryFlag": countryFlag,
                          "meetingDate": selectedMeetingDate,
                          "meetingTime": selectedMeetingTime
                        },
                      );
                    },
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
