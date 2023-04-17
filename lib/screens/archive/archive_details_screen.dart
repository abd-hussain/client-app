import 'package:client_app/models/https/archive.dart';
import 'package:client_app/screens/booking_meeting/widgets/appointment_details_view.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ArchiveDetailsScreen extends StatefulWidget {
  const ArchiveDetailsScreen({super.key});

  @override
  State<ArchiveDetailsScreen> createState() => _ArchiveDetailsScreenState();
}

class _ArchiveDetailsScreenState extends State<ArchiveDetailsScreen> {
  final ValueNotifier<ArchiveData?> archiveNotifier = ValueNotifier<ArchiveData?>(null);

  late VideoPlayerController videoPlayerController;

  @override
  void didChangeDependencies() {
    handleReadingArguments(context, arguments: ModalRoute.of(context)!.settings.arguments);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  void handleReadingArguments(BuildContext context, {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      final data = (newArguments["data"] as ArchiveData?)!;
      //TODO
      videoPlayerController =
          VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
      print(AppConstant.imagesBaseURLForAttachmentArchive + data.attachment!);
      // videoPlayerController =
      //     VideoPlayerController.network(AppConstant.imagesBaseURLForAttachmentArchive + data.attachment!);
      archiveNotifier.value = data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: customAppBar(title: AppLocalizations.of(context)!.archive),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<ArchiveData?>(
            valueListenable: archiveNotifier,
            builder: (context, snapshot, child) {
              var parsedFromDate = DateTime.parse(snapshot!.dateFrom!);
              var parsedToDate = DateTime.parse(snapshot.dateTo!);
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              final String formattedFromDate = formatter.format(parsedFromDate);
              var duration = parsedToDate.difference(parsedFromDate);
              String durationString = duration.toString().replaceAll(".000000", "");
              return FutureBuilder(
                  future: videoPlayerController.initialize(),
                  builder: (context, snapshot0) {
                    if (snapshot0.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: const Color(0xff034061),
                              radius: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: snapshot.profileImg != ""
                                    ? FadeInImage(
                                        placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                        image: NetworkImage(AppConstant.imagesBaseURLForMentors + snapshot.profileImg!,
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
                            title: "${snapshot.suffixeName!} ${snapshot.firstName!} ${snapshot.lastName!}",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: const Color(0xff554d56),
                          ),
                          const SizedBox(height: 10),
                          AppointmentDetailsView(
                            title: AppLocalizations.of(context)!.category,
                            desc: snapshot.categoryName!,
                          ),
                          AppointmentDetailsView(
                            title: AppLocalizations.of(context)!.meetingtype,
                            desc: snapshot.appointmentType! == 1
                                ? AppLocalizations.of(context)!.meetingshuduled
                                : AppLocalizations.of(context)!.meetingnow,
                          ),
                          AppointmentDetailsView(
                            title: AppLocalizations.of(context)!.meetingdate,
                            desc: formattedFromDate,
                          ),
                          AppointmentDetailsView(
                            title: AppLocalizations.of(context)!.meetingduration,
                            desc: durationString,
                          ),
                          AppointmentDetailsView(
                            title: AppLocalizations.of(context)!.price,
                            desc: "\$${snapshot.priceAfterDiscount!}",
                          ),
                          AppointmentDetailsView(
                            title: AppLocalizations.of(context)!.note,
                            desc: snapshot.noteFromClient!,
                          ),
                          AppointmentDetailsView(
                            title: AppLocalizations.of(context)!.mentornote,
                            desc: snapshot.noteFromMentor!,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 200,
                            child: Chewie(
                              controller: ChewieController(
                                videoPlayerController: videoPlayerController,
                                autoPlay: false,
                                looping: false,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  });
            }),
      ),
    );
  }
}

// String? attachment;
