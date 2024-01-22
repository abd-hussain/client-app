import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
import 'package:client_app/shared_widgets/grid_view/item_in_gred.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeetingTimingView extends StatelessWidget {
  final String? date;
  final String? time;
  final String? duration;
  final BookingType? type;
  final EdgeInsetsGeometry padding;

  const MeetingTimingView({
    super.key,
    required this.date,
    required this.time,
    required this.duration,
    required this.type,
    this.padding = const EdgeInsets.only(top: 8, left: 16, right: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
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
          ItemInGrid(
            title: AppLocalizations.of(context)!.eventday,
            value: date,
          ),
          ItemInGrid(
            title: AppLocalizations.of(context)!.meetingtime,
            value: time,
          ),
          ItemInGrid(
              title: AppLocalizations.of(context)!.meetingduration,
              value: duration != null
                  ? "$duration ${AppLocalizations.of(context)!.min}"
                  : null),
          ItemInGrid(
              title: AppLocalizations.of(context)!.appointmenttype,
              value: type == BookingType.schudule
                  ? AppLocalizations.of(context)!.schudule
                  : AppLocalizations.of(context)!.instant),
        ],
      ),
    );
  }
}
