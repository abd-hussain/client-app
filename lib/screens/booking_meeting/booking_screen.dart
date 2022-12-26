import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
import 'package:client_app/screens/booking_meeting/widgets/appointment_details_view.dart';
import 'package:client_app/screens/booking_meeting/widgets/mentor_profile_info.dart';
import 'package:client_app/screens/booking_meeting/widgets/serching_for_mentor.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final bloc = BookingBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context, arguments: ModalRoute.of(context)!.settings.arguments);
    bloc.handleLisinnerOfDiscountController();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: customAppBar(title: AppLocalizations.of(context)!.payments),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                bloc.bookingType == BookingType.schudule
                    ? MentorProfileInfoView(
                        suffixeName: bloc.suffixeName!,
                        firstName: bloc.firstName!,
                        lastName: bloc.lastName!,
                        profileImg: bloc.profileImageUrl!,
                      )
                    : const SearchForMentorView(),
                CustomText(
                  title: bloc.categoryName!,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: const Color(0xff554d56),
                ),
                const SizedBox(height: 20),
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
                  desc: bloc.bookingType == BookingType.schudule
                      ? bloc.meetingType!
                      : AppLocalizations.of(context)!.meetingnow,
                ),
                AppointmentDetailsView(
                  title: AppLocalizations.of(context)!.meetingduration,
                  desc: "${bloc.meetingduration!} ${AppLocalizations.of(context)!.min}",
                ),
                AppointmentDetailsView(
                  title: AppLocalizations.of(context)!.meetingtime,
                  desc: bloc.bookingType == BookingType.schudule
                      ? bloc.meetingtime!
                      : AppLocalizations.of(context)!.withinhour,
                  forceView: true,
                ),
                AppointmentDetailsView(
                  title: AppLocalizations.of(context)!.meetingdate,
                  desc: bloc.bookingType == BookingType.schudule
                      ? bloc.meetingdate!
                      : AppLocalizations.of(context)!.withinhour,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(height: 1, color: const Color(0xff444444)),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          child: CustomTextField(
                            controller: bloc.discountController,
                            fontSize: 25,
                            hintText: AppLocalizations.of(context)!.discountcode,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                            ],
                            suffixWidget: IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              ),
                              onPressed: () {
                                bloc.discountController.text = "";
                              },
                            ),
                          ),
                        ),
                        ValueListenableBuilder<String?>(
                            valueListenable: bloc.discountErrorMessage,
                            builder: (context, snapshot, child) {
                              return snapshot != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
                                      child: CustomText(
                                        title: snapshot == "error"
                                            ? AppLocalizations.of(context)!.notvaliddiscountcode
                                            : "",
                                        fontSize: 14,
                                        textColor: Colors.red,
                                      ),
                                    )
                                  : const SizedBox();
                            }),
                      ],
                    ),
                    Expanded(child: Container()),
                    ValueListenableBuilder<bool>(
                        valueListenable: bloc.applyDiscountButton,
                        builder: (context, snapshot, child) {
                          return CustomButton(
                            enableButton: snapshot,
                            width: MediaQuery.of(context).size.width * 0.2,
                            buttonTitle: AppLocalizations.of(context)!.apply,
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              bloc.verifyCode();
                            },
                          );
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(height: 1, color: const Color(0xff444444)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomText(
                    title: "-- ${AppLocalizations.of(context)!.billdetails} --",
                    fontSize: 16,
                    textColor: const Color(0xff554d56),
                  ),
                ),
                AppointmentDetailsView(
                  title: AppLocalizations.of(context)!.meetingcost,
                  desc: bloc.meetingcost!,
                ),
                ValueListenableBuilder<String?>(
                    valueListenable: bloc.discountErrorMessage,
                    builder: (context, snapshot, child) {
                      return AppointmentDetailsView(
                        title: AppLocalizations.of(context)!.discount,
                        desc: snapshot == null || snapshot == "error" ? "0 %" : "$snapshot %",
                      );
                    }),
                ValueListenableBuilder<String?>(
                    valueListenable: bloc.discountErrorMessage,
                    builder: (context, snapshot, child) {
                      return AppointmentDetailsView(
                          title: AppLocalizations.of(context)!.totalamount,
                          desc: bloc.calculateTotalAmount(
                              double.parse(Currency().getHourRateWithoutCurrency(bloc.meetingcost!)),
                              snapshot == null || snapshot == "error" ? 0 : double.parse(snapshot)));
                    }),
                CustomButton(
                  enableButton: false,
                  buttonTitle: AppLocalizations.of(context)!.pay,
                  onTap: () async {
                    //TODO : Payment View
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
