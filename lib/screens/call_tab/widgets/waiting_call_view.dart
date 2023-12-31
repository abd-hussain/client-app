import 'package:client_app/models/https/calender_model.dart';
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
  final String meetingduration;
  final String meetingtime;
  final String meetingday;
  final CalenderMeetings metingDetails;
  final Function() cancelMeetingTapped;
  final Function() timesup;

  const WaitingCallView({
    super.key,
    required this.timerStartNumberHour,
    required this.timerStartNumberMin,
    required this.timerStartNumberSec,
    required this.cancelMeetingTapped,
    required this.meetingduration,
    required this.meetingtime,
    required this.meetingday,
    required this.metingDetails,
    required this.timesup,
  });

  @override
  State<WaitingCallView> createState() => _WaitingCallViewState();
}

class _WaitingCallViewState extends State<WaitingCallView> {
  ValueNotifier<int> loadingForTimer = ValueNotifier<int>(0);
  int timerStartNumberSec = 0;
  int timerStartNumberMin = 0;
  int timerStartNumberHour = 0;

  @override
  void didChangeDependencies() {
    timerStartNumberSec = widget.timerStartNumberSec;
    timerStartNumberMin = widget.timerStartNumberMin;
    timerStartNumberHour = widget.timerStartNumberHour;
    loadingForTimer.value = timerStartNumberSec;

    startTimer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    loadingForTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/115245-medical-heart-pressure-timer.zip',
            height: 200),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CustomText(
            title: AppLocalizations.of(context)!.remanintime,
            fontSize: 20,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        ValueListenableBuilder<int>(
            valueListenable: loadingForTimer,
            builder: (context, snapshot, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: CustomText(
                  title:
                      "${timerStartNumberHour > 9 ? "$timerStartNumberHour" : "0$timerStartNumberHour"} : ${timerStartNumberMin > 9 ? "$timerStartNumberMin" : "0$timerStartNumberMin"} : ${timerStartNumberSec > 9 ? "$timerStartNumberSec" : "0$timerStartNumberSec"}",
                  fontSize: 30,
                  textColor: const Color(0xff554d56),
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
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
          desc:
              "${widget.meetingduration} ${AppLocalizations.of(context)!.min}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.clientnote,
          desc: widget.metingDetails.noteFromClient ?? "",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.mentornote,
          desc: widget.metingDetails.noteFromMentor ?? "",
        ),
        mentorBoxView(metingDetails: widget.metingDetails),
        CustomButton(
            enableButton:
                DateTime.now().isBefore(widget.metingDetails.fromTime) &&
                    widget.metingDetails.state == AppointmentsState.active,
            padding: const EdgeInsets.all(8.0),
            buttonTitle: AppLocalizations.of(context)!.cancelappointment,
            width: MediaQuery.of(context).size.width / 2,
            buttonColor: const Color(0xffda1100),
            onTap: () {
              CancelBookingBottomSheetsUtil(context: context)
                  .bookMeetingBottomSheet(
                confirm: () {
                  widget.cancelMeetingTapped();
                },
              );
            }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget mentorBoxView({required CalenderMeetings metingDetails}) {
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
                child: (metingDetails.profileImg != null &&
                        metingDetails.profileImg != "")
                    ? FadeInImage(
                        placeholder:
                            const AssetImage("assets/images/avatar.jpeg"),
                        image: NetworkImage(
                            AppConstant.imagesBaseURLForMentors +
                                metingDetails.profileImg!,
                            scale: 1),
                      )
                    : Image.asset(
                        'assets/images/avatar.jpeg',
                        fit: BoxFit.fill,
                      ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title:
                        "${metingDetails.mentorPrefix} ${metingDetails.mentorFirstName} ${metingDetails.mentorLastName}",
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
                        title: metingDetails.categoryName ?? "",
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
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_isTimerFinished()) {
          timer.cancel();
          widget.timesup();
        } else {
          _decrementTimer();
          loadingForTimer.value = timerStartNumberSec - 1;
        }
      },
    );
  }

  void _decrementTimer() {
    if (timerStartNumberSec > 0) {
      timerStartNumberSec--;
    } else if (timerStartNumberMin > 0) {
      timerStartNumberMin--;
      timerStartNumberSec = 59;
    } else if (timerStartNumberHour > 0) {
      timerStartNumberHour--;
      timerStartNumberMin = 59;
      timerStartNumberSec = 59;
    }
  }

  bool _isTimerFinished() {
    return timerStartNumberHour == 0 &&
        timerStartNumberMin == 0 &&
        timerStartNumberSec == 0;
  }
}
