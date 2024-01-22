import 'package:client_app/models/https/appointment.dart';
import 'package:client_app/shared_widgets/appointment_details_view.dart';
import 'package:client_app/shared_widgets/mentor_info_view.dart';
import 'package:client_app/screens/mycalender_tab/utils/price_view.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/gender_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class CalenderBottomSheetsUtil {
  final BuildContext context;
  final AppointmentData metingDetails;
  final String language;

  CalenderBottomSheetsUtil({
    required this.context,
    required this.metingDetails,
    required this.language,
  });

  Future<dynamic> showAddEditNoteDialog({
    required String note,
    required Function(String) confirm,
  }) {
    TextEditingController controller = TextEditingController();
    controller.text = note;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      CustomText(
                        title: AppLocalizations.of(context)!.note,
                        textColor: const Color(0xff444444),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    maxLines: 3,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.note,
                      prefixIcon: const Icon(Icons.message),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        });
  }

  Future bookMeetingBottomSheet({
    required Function() cancel,
    required Function() editNote,
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
            padding:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Wrap(
              children: [
                Row(
                  children: [
                    CustomText(
                      title: AppLocalizations.of(context)!.meeting,
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
                meetingView(),
                CustomButton(
                  enableButton: true,
                  padding: const EdgeInsets.all(8.0),
                  buttonColor: const Color(0xff4CB6EA),
                  buttonTitle: AppLocalizations.of(context)!.editnote,
                  onTap: () {
                    Navigator.pop(context);
                    editNote();
                  },
                ),
                CustomButton(
                  enableButton: DateTime.now()
                          .isBefore(DateTime.parse(metingDetails.dateFrom!)) &&
                      metingDetails.state == 1,
                  padding: const EdgeInsets.all(8.0),
                  buttonColor: const Color(0xffda1100),
                  buttonTitle: AppLocalizations.of(context)!.cancelappointment,
                  onTap: () {
                    Navigator.pop(context);
                    cancel();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget meetingView() {
    DateTime fromTime = DateTime.parse(metingDetails.dateFrom!);
    DateTime toTime = DateTime.parse(metingDetails.dateTo!);
    final difference = toTime.difference(fromTime).inMinutes;

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
        MentorInfoView(
          profileImg: metingDetails.profileImg,
          flagImage: metingDetails.flagImage,
          firstName: metingDetails.firstName,
          lastName: metingDetails.lastName,
          suffixName: metingDetails.suffixeName,
          category: metingDetails.categoryName,
          gender: GenderFormat()
              .convertIndexToString(context, metingDetails.gender!),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventdate,
          desc: "${fromTime.year}/${fromTime.month}/${fromTime.day}",
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventday,
          desc: language == "en"
              ? DateFormat('EEEE').format(fromTime)
              : DayTime().convertDayToArabic(
                  DateFormat('EEEE').format(fromTime),
                ),
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.sessiontype,
          desc: _sessionType(metingDetails.appointmentType!),
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingtime,
          desc: DayTime().convertingTimingWithMinToRealTime(
              fromTime.hour, fromTime.minute),
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc: "$difference ${AppLocalizations.of(context)!.min}",
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingstatus,
          desc: _sessionStatusString(_handleMeetingState(metingDetails.state!)),
          descColor: _handleMeetingState(metingDetails.state!) ==
                  AppointmentsState.active
              ? Colors.green
              : Colors.red,
          padding: const EdgeInsets.all(8),
        ),
        PriceView(
          priceBeforeDiscount: metingDetails.price!,
          priceAfterDiscount: metingDetails.discountedPrice!,
          currency: metingDetails.currency!,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.clientnote,
          desc: metingDetails.noteFromClient == ""
              ? "-"
              : metingDetails.noteFromClient!,
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.mentornote,
          desc: metingDetails.noteFromMentor == ""
              ? "-"
              : metingDetails.noteFromMentor!,
          padding: const EdgeInsets.all(8),
        ),
        Container(height: 1, color: const Color(0xff444444)),
      ],
    );
  }

  AppointmentsState _handleMeetingState(int index) {
    if (index == 1) {
      return AppointmentsState.active;
    } else if (index == 2) {
      return AppointmentsState.mentorCancel;
    } else if (index == 3) {
      return AppointmentsState.clientCancel;
    } else if (index == 4) {
      return AppointmentsState.clientMiss;
    } else if (index == 5) {
      return AppointmentsState.mentorMiss;
    } else {
      return AppointmentsState.completed;
    }
  }

  String _sessionType(int id) {
    if (id == 1) {
      return AppLocalizations.of(context)!.schudule;
    } else {
      return AppLocalizations.of(context)!.instant;
    }
  }

  String _sessionStatusString(AppointmentsState state) {
    switch (state) {
      case AppointmentsState.active:
        return AppLocalizations.of(context)!.active;

      case AppointmentsState.clientCancel:
        return AppLocalizations.of(context)!.clientcancelcall;

      case AppointmentsState.mentorCancel:
        return AppLocalizations.of(context)!.mentorcancelcall;

      case AppointmentsState.clientMiss:
        return AppLocalizations.of(context)!.clientmisscall;

      case AppointmentsState.mentorMiss:
        return AppLocalizations.of(context)!.mentormisscall;

      case AppointmentsState.completed:
        return AppLocalizations.of(context)!.compleated;
    }
  }
}
