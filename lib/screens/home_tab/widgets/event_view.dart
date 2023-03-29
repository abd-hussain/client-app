import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/screens/home_tab/widgets/timing_event_view.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class EventView extends StatelessWidget {
  final String language;
  final List<MainEvent> listOfEvents;
  final Function(MainEvent) onEventSelected;
  final Function(MainEvent) onOptionSelected;

  const EventView(
      {super.key,
      required this.listOfEvents,
      required this.onEventSelected,
      required this.onOptionSelected,
      required this.language});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: ListView.builder(
          itemCount: listOfEvents.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // new
          itemBuilder: (context, index) {
            final MainEvent event = listOfEvents[index];
            final fromDateTime = DateTime.parse(event.dateFrom!);
            final toDateTime = DateTime.parse(event.dateTo!);
            final dayName = DateFormat('EEEE').format(fromDateTime);

            final difference = toDateTime.difference(fromDateTime).inMinutes;

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(
                onTap: () => onEventSelected(event),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xff444444), width: 0.5),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                              child: event.image != ""
                                  ? FadeInImage(
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                      image: NetworkImage(
                                        AppConstant.imagesBaseURLForEvents + event.image!,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/images/avatar.jpeg',
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => onOptionSelected(event),
                                child: Container(
                                  width: 50,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.more_horiz,
                                      color: Color(0xff444444),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TimingEventView(
                        text1: "${fromDateTime.year}/${fromDateTime.month}/${fromDateTime.day}",
                        text2: language == "en" ? dayName : DayTime().convertDayToArabic(dayName),
                      ),
                      TimingEventView(
                        text1: DayTime().convertingTimingWithMinToRealTime(fromDateTime.hour, fromDateTime.minute),
                        text2: "$difference ${AppLocalizations.of(context)!.min}",
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              title: event.title!,
                              fontSize: 18,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.bold,
                              maxLins: 3,
                              textColor: const Color(0xff444444),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        title:
                            "${event.joiningClients!} ${AppLocalizations.of(context)!.intrestedfrom} ${event.maxNumberOfAttendance}",
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        textColor: const Color(0xff444444),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      title: event.price == 0
                                          ? "${AppLocalizations.of(context)!.registernow} ( ${AppLocalizations.of(context)!.free} )"
                                          : "${AppLocalizations.of(context)!.registernow} ( ${Currency().calculateHourRate(event.price!, Timing.hour)} )",
                                      fontSize: 16,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                      textColor: const Color(0xff444444),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
