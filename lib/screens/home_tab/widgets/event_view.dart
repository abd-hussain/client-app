import 'package:client_app/models/https/event.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventView extends StatelessWidget {
  final List<Event> listOfEvents;
  final Function(Event) onTipSelected;

  const EventView({super.key, required this.listOfEvents, required this.onTipSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
            color: Colors.grey[300],
            width: MediaQuery.of(context).size.width,
            child: CustomText(
              title: AppLocalizations.of(context)!.comingevent,
              fontSize: 16,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: ListView.builder(
                itemCount: listOfEvents.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final Event event = listOfEvents[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => onTipSelected(event),
                      child: Container(
                        width: 275,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xff444444), width: 0.5),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                              child: Image.network(
                                event.image,
                                width: 275,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 4, left: 8, right: 8),
                              child: SizedBox(
                                height: 15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      title: event.eventDate,
                                      fontSize: 14,
                                      textAlign: TextAlign.center,
                                      textColor: const Color(0xff444444),
                                    ),
                                    CustomText(
                                      title: event.eventDay,
                                      fontSize: 14,
                                      textAlign: TextAlign.center,
                                      textColor: const Color(0xff444444),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 8, left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    title: event.fromHour,
                                    fontSize: 14,
                                    textAlign: TextAlign.center,
                                    textColor: const Color(0xff444444),
                                  ),
                                  CustomText(
                                    title: event.duration,
                                    fontSize: 14,
                                    textAlign: TextAlign.center,
                                    textColor: const Color(0xff444444),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: CustomText(
                                  title: event.eventName,
                                  fontSize: 18,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.bold,
                                  maxLins: 3,
                                  textColor: const Color(0xff444444),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              title:
                                  "${event.intrestedcount} ${AppLocalizations.of(context)!.intrestedfrom} ${event.intrestedTotalcount}",
                              fontSize: 14,
                              textAlign: TextAlign.center,
                              textColor: const Color(0xff444444),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 40,
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
                                                : "${AppLocalizations.of(context)!.registernow} (${event.price} JD)",
                                            fontSize: 16,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            textColor: const Color(0xff444444),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
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
                                      width: 40,
                                      child: const Center(
                                        child: Icon(Icons.share_sharp),
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
          ),
        ],
      ),
    );
  }
}
