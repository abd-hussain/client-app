import 'package:client_app/models/https/archive.dart';
import 'package:client_app/screens/archive/widgets/video_view.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ArchiveTileView extends StatelessWidget {
  final ArchiveData data;
  const ArchiveTileView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var parsedFromDate = DateTime.parse(data.dateFrom!);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedFromDate = formatter.format(parsedFromDate);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xff034061),
                    radius: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: data.profileImg != ""
                          ? FadeInImage(
                              placeholder:
                                  const AssetImage("assets/images/avatar.jpeg"),
                              image: NetworkImage(
                                  AppConstant.imagesBaseURLForMentors +
                                      data.profileImg!,
                                  scale: 1),
                            )
                          : Image.asset(
                              'assets/images/avatar.jpeg',
                              width: 110.0,
                              height: 110.0,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: data.suffixeName!,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textColor: const Color(0xff554d56),
                      ),
                      CustomText(
                        title: "${data.firstName!} ${data.lastName!}",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textColor: const Color(0xff554d56),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title:
                                "${AppLocalizations.of(context)!.category} :",
                            fontSize: 14,
                            textColor: const Color(0xff554d56),
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            title: data.categoryName!,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            textColor: const Color(0xff554d56),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              CustomText(
                title:
                    "-- ${AppLocalizations.of(context)!.appointmentdetails} --",
                fontSize: 16,
                textColor: const Color(0xff554d56),
              ),
              itemInGrid(
                  title: AppLocalizations.of(context)!.meetingdate,
                  value: formattedFromDate),
              meetingDetailsView(context, data),
              CustomText(
                title: "-- ${AppLocalizations.of(context)!.payments} --",
                fontSize: 16,
                textColor: const Color(0xff554d56),
              ),
              meetingPricingView(context, data),
              CustomText(
                title: "-- ${AppLocalizations.of(context)!.notes} --",
                fontSize: 16,
                textColor: const Color(0xff554d56),
              ),
              meetingNotesView(context, data),
              const SizedBox(height: 10),
              //TODO: Handle Video
              VideoView(videoUrl: data.attachment!),
              IconButton(onPressed: () {}, icon: const Icon(Icons.play_circle))
            ],
          ),
        ),
      ),
    );
  }

  Widget meetingDetailsView(BuildContext context, ArchiveData data) {
    final box = Hive.box(DatabaseBoxConstant.userInfo);
    DateTime now = DateTime.now();
    DateTime timeDifference = DateTime.parse(data.dateFrom!).isAfter(now)
        ? DateTime.parse(data.dateFrom!).subtract(Duration(
            hours: now.hour,
            minutes: now.minute,
            seconds: now.second,
          ))
        : DateTime(now.year, now.month, now.day);

    String meetingday = box.get(DatabaseFieldConstant.language) == "en"
        ? DateFormat('EEEE').format(timeDifference)
        : DayTime()
            .convertDayToArabic(DateFormat('EEEE').format(timeDifference));

    String meetingtime =
        DateFormat('hh:mm a').format(DateTime.parse(data.dateFrom!));

    String meetingduration =
        "${DateTime.parse(data.dateTo!).difference(DateTime.parse(data.dateFrom!)).inMinutes}";

    return Padding(
      padding: const EdgeInsets.only(top: 8),
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
          itemInGrid(
              title: AppLocalizations.of(context)!.eventday, value: meetingday),
          itemInGrid(
              title: AppLocalizations.of(context)!.meetingtime,
              value: meetingtime),
          itemInGrid(
              title: AppLocalizations.of(context)!.meetingduration,
              value: "$meetingduration ${AppLocalizations.of(context)!.min}"),
          itemInGrid(
              title: AppLocalizations.of(context)!.appointmenttype,
              value: data.appointmentType == 1
                  ? AppLocalizations.of(context)!.schudule
                  : AppLocalizations.of(context)!.instant),
        ],
      ),
    );
  }

  Widget meetingPricingView(BuildContext context, ArchiveData data) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
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
          itemInGrid(
            title: AppLocalizations.of(context)!.free,
            value: data.isFree!
                ? AppLocalizations.of(context)!.yes
                : AppLocalizations.of(context)!.no,
          ),
          itemInGrid(
            title: AppLocalizations.of(context)!.hasdiscount,
            value: data.discountId != null
                ? AppLocalizations.of(context)!.yes
                : AppLocalizations.of(context)!.no,
          ),
          itemInGrid(
              title: AppLocalizations.of(context)!.price,
              value: "${data.price!} ${data.currency!}"),
          itemInGrid(
              title: AppLocalizations.of(context)!.priceafter,
              value: "${data.discountedPrice!} ${data.currency!}"),
        ],
      ),
    );
  }

  Widget meetingNotesView(BuildContext context, ArchiveData data) {
    return SizedBox(
      height: 125,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          children: [
            itemInGrid(
                title: AppLocalizations.of(context)!.clientnote,
                value: checkNote(data.noteFromClient),
                valueHight: 90),
            itemInGrid(
                title: AppLocalizations.of(context)!.mentornote,
                value: checkNote(data.noteFromMentor),
                valueHight: 90),
          ],
        ),
      ),
    );
  }

  Widget itemInGrid(
      {required String title, required String value, double valueHight = 25}) {
    return Column(
      children: [
        Container(
          height: 25,
          color: Colors.grey[300],
          child: Center(
            child: CustomText(
              title: title,
              fontSize: 16,
              textColor: Colors.black,
            ),
          ),
        ),
        Container(
          height: valueHight,
          color: Colors.grey[400],
          child: Center(
            child: CustomText(
              title: value,
              fontSize: 16,
              textColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  String checkNote(String? note) {
    if (note == null) {
      return "-";
    } else if (note == "") {
      return "-";
    } else {
      return note;
    }
  }
}
