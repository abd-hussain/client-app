import 'package:client_app/screens/booking_meeting/widgets/appointment_details_view.dart';
import 'package:client_app/shared_widgets/booking/cancel_booking_bottom_sheet.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';

class WaitingCallView extends StatefulWidget {
  final int timerStartNumberHour;
  final int timerStartNumberMin;
  final int timerStartNumberSec;
  final String profileImage;
  final String suffixeName;
  final String firstName;
  final String lastName;
  final String categoryName;
  final String meetingduration;
  final String meetingtime;
  final String meetingday;
  final String clientMeetingNote;
  final String mentorMeetingNote;

  final Function() cancelMeetingTapped;

  const WaitingCallView({
    super.key,
    required this.suffixeName,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.timerStartNumberHour,
    required this.timerStartNumberMin,
    required this.timerStartNumberSec,
    required this.categoryName,
    required this.cancelMeetingTapped,
    required this.meetingduration,
    required this.meetingtime,
    required this.meetingday,
    required this.clientMeetingNote,
    required this.mentorMeetingNote,
  });

  @override
  State<WaitingCallView> createState() => _WaitingCallViewState();
}

class _WaitingCallViewState extends State<WaitingCallView> {
  Timer? timer;
  int timerStartNumberSec = 59;
  int timerStartNumberMin = 0;
  int timerStartNumberHour = 23;

  @override
  void didChangeDependencies() {
    timerStartNumberSec = widget.timerStartNumberSec;
    timerStartNumberMin = widget.timerStartNumberMin;
    timerStartNumberHour = widget.timerStartNumberHour;

    startTimer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/115245-medical-heart-pressure-timer.zip', height: 200),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CustomText(
            title: AppLocalizations.of(context)!.remanintime,
            fontSize: 20,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: CustomText(
            title:
                "${timerStartNumberHour > 9 ? "$timerStartNumberHour" : "0$timerStartNumberHour"} : ${timerStartNumberMin > 9 ? "$timerStartNumberMin" : "0$timerStartNumberMin"} : ${timerStartNumberSec > 9 ? "$timerStartNumberSec" : "0$timerStartNumberSec"}",
            fontSize: 30,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(
            title: "-- ${AppLocalizations.of(context)!.appointmentdetails} --",
            fontSize: 16,
            textColor: const Color(0xff554d56),
          ),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingday,
          desc: widget.meetingday,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingtime,
          desc: widget.meetingtime,
          forceView: true,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc: "${widget.meetingduration} ${AppLocalizations.of(context)!.min}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.clientnote,
          desc: widget.clientMeetingNote,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.mentornote,
          desc: widget.mentorMeetingNote,
        ),
        mentorBoxView(),
        CustomButton(
            enableButton: true,
            buttonTitle: AppLocalizations.of(context)!.cancelappointment,
            width: MediaQuery.of(context).size.width / 2,
            buttonColor: const Color(0xffda1100),
            onTap: () {
              CancelBookingBottomSheetsUtil(context: context).bookMeetingBottomSheet(
                confirm: () {
                  widget.cancelMeetingTapped();
                },
              );
            }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget mentorBoxView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: 75,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: widget.profileImage != ""
                    ? FadeInImage(
                        placeholder: const AssetImage("assets/images/avatar.jpeg"),
                        image: NetworkImage(AppConstant.imagesBaseURLForMentors + widget.profileImage, scale: 1),
                      )
                    : Image.asset(
                        'assets/images/avatar.jpeg',
                        fit: BoxFit.fill,
                      ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title: "${widget.suffixeName} ${widget.firstName} ${widget.lastName}",
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    maxLins: 3,
                    textColor: const Color(0xff554d56),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title: "${AppLocalizations.of(context)!.category} :",
                        fontSize: 12,
                        textColor: const Color(0xff554d56),
                      ),
                      const SizedBox(width: 8),
                      CustomText(
                        title: widget.categoryName,
                        fontSize: 12,
                        textColor: const Color(0xff554d56),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerStartNumberHour == 0 && timerStartNumberMin == 0 && timerStartNumberSec == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            if (timerStartNumberSec > 0) {
              timerStartNumberSec = timerStartNumberSec - 1;
            } else {
              if (timerStartNumberMin > 0) {
                timerStartNumberMin = timerStartNumberMin - 1;
                timerStartNumberSec = 59;
              } else {
                timerStartNumberHour = timerStartNumberHour - 1;
                timerStartNumberMin = 59;
                timerStartNumberSec = 59;
              }
            }
          });
        }
      },
    );
  }
}
