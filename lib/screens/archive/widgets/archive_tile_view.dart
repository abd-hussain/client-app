import 'package:client_app/models/https/archive.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ArchiveTileView extends StatelessWidget {
  final Function(ArchiveData) onTap;
  final ArchiveData data;
  const ArchiveTileView({super.key, required this.onTap, required this.data});

  @override
  Widget build(BuildContext context) {
    var parsedFromDate = DateTime.parse(data.dateFrom!);
    var parsedToDate = DateTime.parse(data.dateTo!);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedFromDate = formatter.format(parsedFromDate);
    var duration = parsedToDate.difference(parsedFromDate);
    String durationString = duration.toString().replaceAll(".000000", "");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTap(data);
        },
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
          height: 185,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff034061),
                    radius: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
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
                ),
                const SizedBox(height: 8),
                CustomText(
                  title:
                      "${data.suffixeName!} ${data.firstName!} ${data.lastName!}",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textColor: const Color(0xff554d56),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: "${AppLocalizations.of(context)!.category} :",
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: "${AppLocalizations.of(context)!.meetingtype} :",
                      fontSize: 14,
                      textColor: const Color(0xff554d56),
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                      title: data.appointmentType! == 1
                          ? AppLocalizations.of(context)!.meetingshuduled
                          : AppLocalizations.of(context)!.meetingnow,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textColor: const Color(0xff554d56),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: "${AppLocalizations.of(context)!.meetingdate} :",
                      fontSize: 14,
                      textColor: const Color(0xff554d56),
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                      title: formattedFromDate,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textColor: const Color(0xff554d56),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title:
                          "${AppLocalizations.of(context)!.meetingduration} :",
                      fontSize: 14,
                      textColor: const Color(0xff554d56),
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                      title: durationString,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textColor: const Color(0xff554d56),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
