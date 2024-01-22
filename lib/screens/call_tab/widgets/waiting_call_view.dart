import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/shared_widgets/mentor_info_view.dart';
import 'package:client_app/shared_widgets/booking/cancel_booking_bottom_sheet.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/gender_format.dart';
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
  final AppointmentData metingDetails;
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
        meetingTimingView(),
        CustomText(
          title: "-- ${AppLocalizations.of(context)!.payments} --",
          fontSize: 16,
          textColor: const Color(0xff554d56),
        ),
        meetingPricingView(),
        CustomText(
          title: "-- ${AppLocalizations.of(context)!.notes} --",
          fontSize: 16,
          textColor: const Color(0xff554d56),
        ),
        meetingNotesView(),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: MentorInfoView(
            profileImg: widget.metingDetails.profileImg,
            flagImage: widget.metingDetails.flagImage,
            suffixName: widget.metingDetails.suffixeName,
            firstName: widget.metingDetails.firstName,
            lastName: widget.metingDetails.lastName,
            gender: GenderFormat()
                .convertIndexToString(context, widget.metingDetails.gender!),
            category: widget.metingDetails.categoryName,
          ),
        ),
        CustomButton(
          enableButton: DateTime.now()
                  .isBefore(DateTime.parse(widget.metingDetails.dateFrom!)) &&
              widget.metingDetails.state == 1,
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width / 2,
          buttonColor: const Color(0xffda1100),
          buttonTitle: AppLocalizations.of(context)!.cancelappointment,
          buttonTitleColor: Colors.white,
          onTap: () {
            CancelBookingBottomSheetsUtil().bookMeetingBottomSheet(
              context: context,
              confirm: () {
                widget.cancelMeetingTapped();
              },
            );
          },
        ),
        const SizedBox(height: 25),
      ],
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

  Widget meetingTimingView() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 8,
          childAspectRatio: 3.2,
        ),
        children: [
          itemInGrid(
              title: AppLocalizations.of(context)!.eventday,
              value: widget.meetingday),
          itemInGrid(
              title: AppLocalizations.of(context)!.meetingtime,
              value: widget.meetingtime),
          itemInGrid(
              title: AppLocalizations.of(context)!.meetingduration,
              value:
                  "${widget.meetingduration} ${AppLocalizations.of(context)!.min}"),
          itemInGrid(
              title: AppLocalizations.of(context)!.appointmenttype,
              value: widget.metingDetails.appointmentType == 1
                  ? AppLocalizations.of(context)!.schudule
                  : AppLocalizations.of(context)!.instant),
        ],
      ),
    );
  }

  Widget meetingPricingView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 8,
          childAspectRatio: 3.2,
        ),
        children: [
          itemInGrid(
            title: AppLocalizations.of(context)!.free,
            value: widget.metingDetails.isFree!
                ? AppLocalizations.of(context)!.yes
                : AppLocalizations.of(context)!.no,
          ),
          itemInGrid(
            title: AppLocalizations.of(context)!.hasdiscount,
            value: widget.metingDetails.discountId != null
                ? AppLocalizations.of(context)!.yes
                : AppLocalizations.of(context)!.no,
          ),
          itemInGrid(
              title: AppLocalizations.of(context)!.price,
              value:
                  "${widget.metingDetails.price!} ${widget.metingDetails.currency!}"),
          itemInGrid(
              title: AppLocalizations.of(context)!.priceafter,
              value:
                  "${widget.metingDetails.discountedPrice!} ${widget.metingDetails.currency!}"),
        ],
      ),
    );
  }

  Widget meetingNotesView() {
    return SizedBox(
      height: 125,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          children: [
            itemInGrid(
                title: AppLocalizations.of(context)!.clientnote,
                value: checkNote(widget.metingDetails.noteFromClient),
                valueHight: 90),
            itemInGrid(
                title: AppLocalizations.of(context)!.mentornote,
                value: checkNote(widget.metingDetails.noteFromMentor),
                valueHight: 90),
          ],
        ),
      ),
    );
  }

  String checkNote(String? note) {
    if (note == null) {
      return "-";
    } else if (note == "") {
      return "-";
    } else {
      return note;
    }
  }

  Widget itemInGrid(
      {required String title, required String value, double valueHight = 25}) {
    return Column(
      children: [
        Container(
          height: 25,
          color: Colors.grey[300],
          child: Center(
            child: CustomText(
              title: title,
              fontSize: 16,
              textColor: Colors.black,
            ),
          ),
        ),
        Container(
          height: valueHight,
          color: Colors.grey[400],
          child: Center(
            child: CustomText(
              title: value,
              fontSize: 16,
              textColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
