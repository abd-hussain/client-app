import 'package:client_app/screens/event_details/widgets/event_info_box.dart';
import 'package:client_app/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventTimingView extends StatelessWidget {
  final String eventDayName;
  final String eventDate;
  final String eventHour;
  final String eventDuration;

  final double eventPrice;

  const EventTimingView(
      {required this.eventDayName,
      required this.eventDate,
      required this.eventHour,
      required this.eventDuration,
      required this.eventPrice,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: [
              Expanded(child: EventInfoBox(title: AppLocalizations.of(context)!.eventdate, desc: eventDate)),
              Expanded(child: EventInfoBox(title: AppLocalizations.of(context)!.eventday, desc: eventDayName)),
              Expanded(child: EventInfoBox(title: AppLocalizations.of(context)!.eventhour, desc: eventHour)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 1,
                  child: EventInfoBox(title: AppLocalizations.of(context)!.eventDuration, desc: eventDuration)),
              Expanded(
                flex: 3,
                child: EventInfoBox(
                    title: AppLocalizations.of(context)!.price,
                    desc: eventPrice == 0
                        ? "( ${AppLocalizations.of(context)!.free} )"
                        : "( ${Currency().calculateHourRate(eventPrice, Timing.hour)} )"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
