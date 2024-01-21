import 'package:client_app/models/https/mentor_info_avaliable_model.dart';
import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
import 'package:client_app/screens/booking_meeting/widgets/mentor_profile_info.dart';
import 'package:client_app/screens/booking_meeting/widgets/serching_for_mentor.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';

import 'package:flutter/material.dart';
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
    bloc.handleReadingArguments(context,
        arguments: ModalRoute.of(context)!.settings.arguments);
    // bloc.handleLisinnerOfDiscountController();
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
                ValueListenableBuilder<List<MentorInfoAvaliableResponseData>?>(
                    valueListenable: bloc.avaliableMentors,
                    builder: (context, snapshot, child) {
                      if (snapshot == null) {
                        return const SearchForMentorView();
                      } else {
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                              itemCount: snapshot.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                return SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: MentorProfileInfoView(
                                    suffixeName: snapshot[index].suffixeName!,
                                    firstName: snapshot[index].firstName!,
                                    lastName: snapshot[index].lastName!,
                                    profileImg: snapshot[index].profileImg!,
                                  ),
                                );
                              }),
                        );
                      }
                      // return bloc.bookingType == BookingType.schudule || snapshot == AvaliableMentorStatus.found
                      //     ? MentorProfileInfoView(
                      //         suffixeName: bloc.mentorSuffixName!,
                      //         firstName: bloc.mentorFirstName!,
                      //         lastName: bloc.mentorLastName!,
                      //         profileImg: bloc.mentorProfileImageUrl!,
                      //       )
                      //     : const SearchForMentorView();
                    }),
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
                      title: bloc.categoryName!,
                      fontSize: 12,
                      textColor: const Color(0xff554d56),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    title:
                        "-- ${AppLocalizations.of(context)!.appointmentdetails} --",
                    fontSize: 16,
                    textColor: const Color(0xff554d56),
                  ),
                ),
                // ValueListenableBuilder<AvaliableMentorStatus>(
                //     valueListenable: bloc.checkingAvaliableMentors,
                //     builder: (context, snapshot, child) {
                //       return AppointmentDetailsView(
                //         title: AppLocalizations.of(context)!.meetingdate,
                //         desc: bloc.bookingType == BookingType.schudule || snapshot == AvaliableMentorStatus.found
                //             ? bloc.meetingdate!
                //             : "-----",
                //       );
                //     }),
                // ValueListenableBuilder<AvaliableMentorStatus>(
                //     valueListenable: bloc.checkingAvaliableMentors,
                //     builder: (context, snapshot, child) {
                //       return AppointmentDetailsView(
                //         title: AppLocalizations.of(context)!.meetingday,
                //         desc: bloc.bookingType == BookingType.schudule || snapshot == AvaliableMentorStatus.found
                //             ? bloc.box.get(DatabaseFieldConstant.language) == "en"
                //                 ? bloc.meetingday!
                //                 : DayTime().convertDayToArabic(bloc.meetingday!)
                //             : "-----",
                //       );
                //     }),
                // ValueListenableBuilder<AvaliableMentorStatus>(
                //     valueListenable: bloc.checkingAvaliableMentors,
                //     builder: (context, snapshot, child) {
                //       return AppointmentDetailsView(
                //         title: AppLocalizations.of(context)!.meetingtime,
                //         desc: bloc.bookingType == BookingType.schudule || snapshot == AvaliableMentorStatus.found
                //             ? bloc.meetingtime!
                //             : "-----",
                //       );
                //     }),
                // AppointmentDetailsView(
                //   title: AppLocalizations.of(context)!.meetingduration,
                //   desc: "${bloc.meetingduration!} ${AppLocalizations.of(context)!.min}",
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 16, left: 16),
                //   child: Container(height: 0.5, color: const Color(0xff444444)),
                // ),
                // NoteView(bloc: bloc),
                // Padding(
                //   padding: const EdgeInsets.only(right: 16, left: 16),
                //   child: Container(height: 0.5, color: const Color(0xff444444)),
                // ),
                // DiscountView(bloc: bloc),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Container(height: 0.5, color: const Color(0xff444444)),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8),
                //   child: CustomText(
                //     title: "-- ${AppLocalizations.of(context)!.billdetails} --",
                //     fontSize: 16,
                //     textColor: const Color(0xff554d56),
                //   ),
                // ),
                // ValueListenableBuilder<AvaliableMentorStatus>(
                //     valueListenable: bloc.checkingAvaliableMentors,
                //     builder: (context, snapshot, child) {
                //       return AppointmentDetailsView(
                //         title: AppLocalizations.of(context)!.meetingcost,
                //         desc: bloc.meetingcost!,
                //       );
                //     }),
                // ValueListenableBuilder<AvaliableMentorStatus>(
                //     valueListenable: bloc.checkingAvaliableMentors,
                //     builder: (context, snapshot, child) {
                //       return AppointmentDetailsView(
                //         title: AppLocalizations.of(context)!.servicefee,
                //         desc: "\$0.0",
                //       );
                //     }),
                // ValueListenableBuilder<String?>(
                //     valueListenable: bloc.discountErrorMessage,
                //     builder: (context, snapshot, child) {
                //       return AppointmentDetailsView(
                //         title: AppLocalizations.of(context)!.discount,
                //         desc: snapshot == null || snapshot == "error" ? "0 %" : "$snapshot %",
                //       );
                //     }),
                // ValueListenableBuilder<String?>(
                //     valueListenable: bloc.discountErrorMessage,
                //     builder: (context, snapshot, child) {
                //       return AppointmentDetailsView(
                //           title: AppLocalizations.of(context)!.totalamount,
                //           desc: bloc.calculateTotalAmount(
                //               double.parse(Currency().getHourRateWithoutCurrency(bloc.meetingcost!)),
                //               snapshot == null || snapshot == "error" ? 0 : double.parse(snapshot)));
                //     }),
                CustomButton(
                  enableButton: true,
                  buttonTitle: AppLocalizations.of(context)!.pay,
                  onTap: () async {
                    // final bottomSheet = PaymentBottomSheetsUtil(
                    //     context: context,
                    //     language: bloc.box.get(DatabaseFieldConstant.language),
                    //     totalAmount: bloc.calculateTotalAmount(
                    //         double.parse(Currency().getHourRateWithoutCurrency(bloc.meetingcost!)),
                    //         bloc.discountErrorMessage.value == null || bloc.discountErrorMessage.value == "error"
                    //             ? 0
                    //             : double.parse(bloc.discountErrorMessage.value!)));
                    // await bottomSheet.paymentBottomSheet(
                    //     faze: PaymentFaze.welcoming,
                    //     openNext: () async {
                    // final parsedFromDate = DateTime.parse(bloc.meetingdate!);

                    // var fromDateTime = DateTime(
                    //     parsedFromDate.year,
                    //     parsedFromDate.month,
                    //     parsedFromDate.day,
                    //     DayTime().getHourFromTimeString(bloc.meetingtime!),
                    //     DayTime().getMinFromTimeString(bloc.meetingtime!));

                    // var toDateTime = fromDateTime.add(Duration(minutes: int.parse(bloc.meetingduration!)));

                    // if (bloc.bookingType == BookingType.schudule) {
                    //   final appointment = AppointmentRequest(
                    //     mentorId: bloc.mentorId!,
                    //     priceBeforeDiscount:
                    //         double.parse(Currency().getHourRateWithoutCurrency(bloc.meetingcost!)),
                    //     priceAfterDiscount: bloc.calculateTotalAmountDouble(
                    //         double.parse(Currency().getHourRateWithoutCurrency(bloc.meetingcost!)),
                    //         bloc.discountErrorMessage.value == null || bloc.discountErrorMessage.value == "error"
                    //             ? 0
                    //             : double.parse(bloc.discountErrorMessage.value!)),
                    //     type: "schudule",
                    //     dateFrom: CustomDate(
                    //         year: fromDateTime.year,
                    //         month: fromDateTime.month,
                    //         day: fromDateTime.day,
                    //         hour: fromDateTime.hour,
                    //         min: fromDateTime.minute),
                    //     dateTo: CustomDate(
                    //         year: toDateTime.year,
                    //         month: toDateTime.month,
                    //         day: toDateTime.day,
                    //         hour: toDateTime.hour,
                    //         min: toDateTime.minute),
                    //     note: bloc.noteController.text.isEmpty ? null : bloc.noteController.text,
                    //   );
                    //TODO
                    // bloc
                    //     .bookMeetingRequest(appointment: appointment)
                    //     .then((value) {
                    //   Navigator.of(context).pop();
                    //   Navigator.of(context).pop();
                    //   locator<MainContainerBloc>().getAppointments();
                    //   locator<MainContainerBloc>()
                    //       .appBarKey
                    //       .currentState!
                    //       .animateTo(2);
                    //   locator<MainContainerBloc>()
                    //       .currentTabIndexNotifier
                    //       .value = SelectedTab.call;
                    // }).catchError((error) {
                    //   if (error is DioError) {
                    //     final exception = error.error;
                    //     if (exception is HttpException) {
                    //       ScaffoldMessenger.of(context)
                    //           .showSnackBar(SnackBar(
                    //         content: Text(exception.message),
                    //       ));
                    //     }
                    //   }
                    // });
                    // } else {
                    //   final appointment = AppointmentRequest(
                    //     mentorId: bloc.mentorId!,
                    //     priceBeforeDiscount:
                    //         double.parse(Currency().getHourRateWithoutCurrency(bloc.meetingcost!)),
                    //     priceAfterDiscount: bloc.calculateTotalAmountDouble(
                    //         double.parse(Currency().getHourRateWithoutCurrency(bloc.meetingcost!)),
                    //         bloc.discountErrorMessage.value == null || bloc.discountErrorMessage.value == "error"
                    //             ? 0
                    //             : double.parse(bloc.discountErrorMessage.value!)),
                    //     type: "instant",
                    //     dateFrom: CustomDate(
                    //         year: fromDateTime.year,
                    //         month: fromDateTime.month,
                    //         day: fromDateTime.day,
                    //         hour: fromDateTime.hour,
                    //         min: fromDateTime.minute),
                    //     dateTo: CustomDate(
                    //         year: toDateTime.year,
                    //         month: toDateTime.month,
                    //         day: toDateTime.day,
                    //         hour: toDateTime.hour,
                    //         min: toDateTime.minute),
                    //     note: bloc.noteController.text.isEmpty ? null : bloc.noteController.text,
                    //   );
                    //TODO
                    // bloc.bookMeetingRequest(appointment: appointment).then((value) {
                    //   locator<MainContainerBloc>().getAppointments();
                    //   Navigator.of(context).pop();
                    // });
                    // }
                    // });
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
