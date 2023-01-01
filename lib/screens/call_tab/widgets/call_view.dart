import 'package:client_app/screens/booking_meeting/widgets/appointment_details_view.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';

class CallView extends StatefulWidget {
  final int timerStartNumberHour;
  final int timerStartNumberMin;
  final int timerStartNumberSec;

  const CallView(
      {super.key,
      required this.timerStartNumberHour,
      required this.timerStartNumberMin,
      required this.timerStartNumberSec});

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
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
        Lottie.asset('assets/lottie/115245-medical-heart-pressure-timer.zip', height: 250),
        Padding(
          padding: const EdgeInsets.all(8),
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
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(
            title: "-- ${AppLocalizations.of(context)!.appointmentdetails} --",
            fontSize: 16,
            textColor: const Color(0xff554d56),
          ),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingtype,
          desc: "", //"bloc.category",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc: "", //"${bloc.meetingduration!} ${AppLocalizations.of(context)!.min}",
        ),
        CustomButton(
            enableButton: true,
            buttonTitle: AppLocalizations.of(context)!.cancelappointment,
            width: MediaQuery.of(context).size.width / 2,
            buttonColor: const Color(0xffda1100),
            onTap: () {})
      ],
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
