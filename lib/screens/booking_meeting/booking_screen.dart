import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
import 'package:client_app/screens/booking_meeting/widgets/instance_booking_view.dart';
import 'package:client_app/screens/booking_meeting/widgets/bill_details_view.dart';
import 'package:client_app/screens/booking_meeting/widgets/discount_view.dart';
import 'package:client_app/shared_widgets/grid_view/item_in_gred.dart';
import 'package:client_app/shared_widgets/grid_view/meeting_timing_view.dart';
import 'package:client_app/screens/booking_meeting/widgets/note_view.dart';
import 'package:client_app/screens/booking_meeting/widgets/schedule_booking_view.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/enums/loading_status.dart';

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
      appBar: customAppBar(title: AppLocalizations.of(context)!.booknow),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, loadingsnapshot, child) {
              if (loadingsnapshot != LoadingStatus.inprogress) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bloc.bookingType == BookingType.schudule
                            ? ScheduleBookingView(
                                profileImg: bloc.scheduleMentorProfileImageUrl,
                                flagImage: bloc.scheduleMentorCountryFlag,
                                gender: bloc.scheduleMentorGender,
                                firstName: bloc.scheduleMentorFirstName,
                                lastName: bloc.scheduleMentorLastName,
                                suffixName: bloc.scheduleMentorSuffixName,
                                categoryName: bloc.categoryName,
                              )
                            : InstanceBookingView(
                                avaliableMentors: bloc.avaliableMentors,
                                categoryName: bloc.categoryName,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
                          child: CustomText(
                            title: AppLocalizations.of(context)!.appointmentdetails,
                            fontSize: 12,
                            textColor: const Color(0xff554d56),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ItemInGrid(
                            title: AppLocalizations.of(context)!.meetingdate,
                            value: bloc.meetingDate(bloc.scheduleMentorMeetingdate),
                          ),
                        ),
                        MeetingTimingView(
                          date: bloc.scheduleMeetingDay,
                          time: bloc.meetingTime(bloc.scheduleMentorMeetingtime),
                          duration:
                              bloc.meetingduration != null ? bloc.meetingDurationParser(bloc.meetingduration!) : null,
                          type: bloc.bookingType,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Container(height: 0.5, color: const Color(0xff444444)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 8),
                          child: CustomText(
                            title: AppLocalizations.of(context)!.writenoteformentor,
                            fontSize: 12,
                            textColor: const Color(0xff554d56),
                          ),
                        ),
                        NoteView(controller: bloc.noteController),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                          child: CustomText(
                            title: AppLocalizations.of(context)!.writenoteformentorsmallMessage,
                            fontSize: 12,
                            textColor: const Color(0xff554d56),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Container(height: 0.5, color: const Color(0xff444444)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 8),
                          child: CustomText(
                            title: AppLocalizations.of(context)!.billdetails,
                            fontSize: 12,
                            textColor: const Color(0xff554d56),
                          ),
                        ),
                        ValueListenableBuilder<String>(
                            valueListenable: bloc.discountErrorMessage,
                            builder: (context, discountErrorsnapshot, child) {
                              return BillDetailsView(
                                currency: bloc.scheduleMentorCurrency!,
                                meetingCostAmount: bloc.calculateMeetingCost(
                                    hourRate: bloc.scheduleMentorHourRate, duration: bloc.meetingduration),
                                totalAmount: bloc.calculateTotalAmount(
                                    hourRate: bloc.scheduleMentorHourRate,
                                    duration: bloc.meetingduration,
                                    discount: discountErrorsnapshot),
                                discountPercent: bloc.calculateDiscountPercent(discountErrorsnapshot),
                              );
                            }),
                        const SizedBox(height: 8),
                        DiscountView(
                          controller: bloc.discountController,
                          discountErrorMessage: bloc.discountErrorMessage,
                          applyDiscountButton: bloc.applyDiscountButton,
                          applyDiscountButtonCallBack: () {
                            bloc.verifyCode();
                            bloc.applyDiscountButton.value = false;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
                          child: Container(height: 0.5, color: const Color(0xff444444)),
                        ),
                        CustomButton(
                          enableButton: true,
                          buttonTitle: AppLocalizations.of(context)!.pay,
                          onTap: () async {
                            //TODO: Handle this Button
                            //TODO: handle Timing UTC
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
                );
              } else {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
