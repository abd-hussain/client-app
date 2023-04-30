import 'package:client_app/screens/booking_meeting/widgets/appointment_details_view.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:client_app/models/https/calender_model.dart';
import 'package:intl/intl.dart';

class CalenderBottomSheetsUtil {
  final BuildContext context;
  final CalenderMeetings metingDetails;
  final String language;

  CalenderBottomSheetsUtil({
    required this.context,
    required this.metingDetails,
    required this.language,
  });

  Future addNoteMeetingBottomSheet({
    required Function(String) confirm,
  }) async {
    TextEditingController controller = TextEditingController();
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
            child: Wrap(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Expanded(child: SizedBox()),
                    CustomText(
                      title: AppLocalizations.of(context)!.editnote,
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
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.note,
                    icon: const Icon(Icons.message),
                  ),
                ),
                Container(height: 1, color: const Color(0xff444444)),
                CustomButton(
                  enableButton: true,
                  padding: const EdgeInsets.all(8.0),
                  buttonColor: const Color(0xff4CB6EA),
                  buttonTitle: AppLocalizations.of(context)!.submit,
                  onTap: () {
                    Navigator.pop(context);
                    confirm(controller.text);
                  },
                ),
                const SizedBox(height: 300)
              ],
            ),
          );
        });
  }

  Future bookMeetingBottomSheet({
    required Function() cancel,
    required Function() editNote,
    required Function() openEventDetails,
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
            child: Wrap(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Expanded(child: SizedBox()),
                    CustomText(
                      title: metingDetails.type == Type.event
                          ? AppLocalizations.of(context)!.event
                          : AppLocalizations.of(context)!.meeting,
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
                const SizedBox(height: 8),
                metingDetails.type == Type.event ? eventView() : meetingView(),
                metingDetails.type == Type.meeting
                    ? CustomButton(
                        enableButton: true,
                        padding: const EdgeInsets.all(8.0),
                        buttonColor: const Color(0xff4CB6EA),
                        buttonTitle: AppLocalizations.of(context)!.editnote,
                        onTap: () {
                          Navigator.pop(context);
                          editNote();
                        },
                      )
                    : CustomButton(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                        enableButton: DateTime.now().isBefore(metingDetails.fromTime),
                        buttonColor: const Color(0xff4CB6EA),
                        buttonTitle: AppLocalizations.of(context)!.openeventdetails,
                        onTap: () {
                          Navigator.pop(context);
                          openEventDetails();
                        },
                      ),
                CustomButton(
                  enableButton: DateTime.now().isBefore(metingDetails.fromTime),
                  padding: const EdgeInsets.all(8.0),
                  buttonColor: const Color(0xffda1100),
                  buttonTitle: AppLocalizations.of(context)!.cancelappointment,
                  onTap: () {
                    Navigator.pop(context);
                    cancel();
                  },
                )
              ],
            ),
          );
        });
  }

  Widget eventView() {
    final difference = metingDetails.toTime.difference(metingDetails.fromTime).inMinutes;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomText(
              title: metingDetails.title!,
              textColor: const Color(0xff444444),
              fontSize: 16,
              textAlign: TextAlign.center,
              maxLins: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: CustomText(
            title: AppLocalizations.of(context)!.by,
            textColor: const Color(0xff444444),
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomText(
              title: "${metingDetails.mentorPrefix} ${metingDetails.mentorFirstName} ${metingDetails.mentorLastName}",
              textColor: const Color(0xff444444),
              fontSize: 14,
              textAlign: TextAlign.center,
              maxLins: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: CustomText(
            title: metingDetails.categoryName!,
            textColor: const Color(0xff444444),
            fontSize: 14,
            textAlign: TextAlign.center,
            maxLins: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventdate,
          desc: "${metingDetails.fromTime.year}/${metingDetails.fromTime.month}/${metingDetails.fromTime.day}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventday,
          desc: language == "en"
              ? DateFormat('EEEE').format(metingDetails.fromTime)
              : DayTime().convertDayToArabic(
                  DateFormat('EEEE').format(metingDetails.fromTime),
                ),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventtime,
          desc: DayTime().convertingTimingWithMinToRealTime(metingDetails.fromTime.hour, metingDetails.fromTime.minute),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventDuration,
          desc: "$difference ${AppLocalizations.of(context)!.min}",
        ),
        Container(height: 1, color: const Color(0xff444444)),
      ],
    );
  }

  Widget meetingView() {
    final difference = metingDetails.toTime.difference(metingDetails.fromTime).inMinutes;

    return Column(
      children: [
        Center(
          child: CustomText(
            title: AppLocalizations.of(context)!.witha,
            textColor: const Color(0xff444444),
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomText(
              title: "${metingDetails.mentorPrefix} ${metingDetails.mentorFirstName} ${metingDetails.mentorLastName}",
              textColor: const Color(0xff444444),
              fontSize: 14,
              textAlign: TextAlign.center,
              maxLins: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: CustomText(
            title: metingDetails.categoryName!,
            textColor: const Color(0xff444444),
            fontSize: 14,
            textAlign: TextAlign.center,
            maxLins: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventdate,
          desc: "${metingDetails.fromTime.year}/${metingDetails.fromTime.month}/${metingDetails.fromTime.day}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventday,
          desc: language == "en"
              ? DateFormat('EEEE').format(metingDetails.fromTime)
              : DayTime().convertDayToArabic(
                  DateFormat('EEEE').format(metingDetails.fromTime),
                ),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingtime,
          desc: DayTime().convertingTimingWithMinToRealTime(metingDetails.fromTime.hour, metingDetails.fromTime.minute),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc: "$difference ${AppLocalizations.of(context)!.min}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.mentornote,
          desc: metingDetails.noteFromMentor ?? "",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.clientnote,
          desc: metingDetails.noteFromClient ?? "",
        ),
        Container(height: 1, color: const Color(0xff444444)),
      ],
    );
  }
}
