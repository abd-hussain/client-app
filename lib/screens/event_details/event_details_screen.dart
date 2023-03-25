import 'package:client_app/locator.dart';
import 'package:client_app/screens/booking_meeting/widgets/appointment_details_view.dart';
import 'package:client_app/screens/event_details/event_details_bloc.dart';
import 'package:client_app/screens/event_details/widgets/event_info_box.dart';
import 'package:client_app/screens/event_details/widgets/event_mentor_view.dart';
import 'package:client_app/screens/event_details/widgets/event_timing_view.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';
import 'package:client_app/shared_widgets/booking/payment_bottom_sheet.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final bloc = EventDetailsBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context: context, arguments: ModalRoute.of(context)!.settings.arguments);
    bloc.getEventDetails(context);
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
      appBar: customAppBar(title: AppLocalizations.of(context)!.eventdetails),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatus,
              builder: (context, snapshot, child) {
                if (snapshot != LoadingStatus.inprogress) {
                  return Column(
                    children: [
                      Image.network(
                        bloc.image!,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: CustomText(
                            title: bloc.eventName!,
                            fontSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            maxLins: 3,
                            textColor: const Color(0xff444444),
                          ),
                        ),
                      ),
                      EventTimingView(
                        eventDate: bloc.eventDate!,
                        eventDayName: bloc.box.get(DatabaseFieldConstant.language) == "en"
                            ? bloc.eventDayName!
                            : DayTime().convertDayToArabic(bloc.eventDayName!),
                        eventDuration: bloc.eventDuration!,
                        eventHour: bloc.eventHour!,
                        eventPrice: bloc.eventPrice!,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: "-- ${AppLocalizations.of(context)!.eventdesc} --",
                          fontSize: 16,
                          textColor: const Color(0xff554d56),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: bloc.eventDescripton!,
                          fontSize: 14,
                          textAlign: TextAlign.center,
                          maxLins: 40,
                          textColor: const Color(0xff444444),
                        ),
                      ),
                      EventMentorView(
                        mentorId: bloc.mentorId!,
                        mentorFirstName: bloc.mentorFirstName!,
                        mentorLastName: bloc.mentorLastName!,
                        mentorProfileImage: bloc.mentorProfileImage!,
                        mentorCategoryName: bloc.mentorCategoryName!,
                        mentorSuffixeName: bloc.mentorSuffixeName!,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: "-- ${AppLocalizations.of(context)!.eventhowattend} --",
                          fontSize: 16,
                          textColor: const Color(0xff554d56),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: AppLocalizations.of(context)!.eventhowattenddetails,
                          fontSize: 14,
                          textAlign: TextAlign.center,
                          maxLins: 40,
                          textColor: const Color(0xff444444),
                        ),
                      ),
                      AppointmentDetailsView(
                        title: AppLocalizations.of(context)!.freeseat,
                        desc: (bloc.maxNumberOfAttendance - bloc.joiningClients).toString(),
                      ),
                      CustomButton(
                        enableButton: bloc.joiningClients < bloc.maxNumberOfAttendance,
                        buttonTitle: AppLocalizations.of(context)!.registernow,
                        onTap: () async {
                          if (bloc.checkIfUserIsLoggedIn()) {
                            if (bloc.isEventFree) {
                              bloc.bookEventRequest().whenComplete(() {
                                locator<MainContainerBloc>().getAppointmentsAndEvents();
                                Navigator.of(context).pop();
                              });
                            } else {
                              final bottomSheet = PaymentBottomSheetsUtil(
                                context: context,
                                language: bloc.box.get(DatabaseFieldConstant.language),
                                totalAmount: bloc.eventPrice.toString(),
                              );
                              await bottomSheet.paymentBottomSheet(
                                  faze: PaymentFaze.welcoming,
                                  openNext: () async {
                                    bloc.bookEventRequest().whenComplete(() {
                                      locator<MainContainerBloc>().getAppointmentsAndEvents();
                                      Navigator.of(context).pop();
                                    });
                                  });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)!.youhavetobeloggedintodothat),
                              ),
                            );
                          }
                        },
                      ),
                    ],
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
      ),
    );
  }
}
