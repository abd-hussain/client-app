import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoriesHomePage extends StatelessWidget {
  final List<MainStory> listOfStories;
  final Function(int id) openMentorProfile;
  final Function(int id) reportStory;
  const StoriesHomePage(
      {required this.listOfStories, required this.openMentorProfile, required this.reportStory, Key? key})
      : super(key: key);

  //TODO : Handle Stories
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOfStories.length,
        itemBuilder: (context, index) {
          return storyWidget(context: context, story: listOfStories[index], openProfile: (id) => openMentorProfile(id));
        },
      ),
    );
  }

  Widget storyWidget({required BuildContext context, required MainStory story, required Function(int) openProfile}) {
    return InkWell(
      onTap: () async {
        await BottomSheetsUtil().showStoryFullView(
            profileId: story.owner!.id!,
            profileName: story.owner!.firstName! + story.owner!.lastName!,
            profileImg: story.owner!.profileImg != null
                ? AppConstant.imagesBaseURLForMentors + story.owner!.profileImg!
                : "${AppConstant.imagesBaseURLForMentors}1.png",
            context: context,
            assets: story.assets!,
            openProfile: (id) => openProfile(id),
            reportStory: (id) async {
              await BottomSheetsUtil().areYouShoureButtomSheet(
                context: context,
                message: AppLocalizations.of(context)!.reportstory,
                sure: () => reportStory(story.owner!.id!),
              );
            });
      },
      child: SizedBox(
        width: 110,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xff034061),
                radius: 60,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.transparent,
                  backgroundImage: story.owner!.profileImg != null
                      ? NetworkImage(AppConstant.imagesBaseURLForMentors + story.owner!.profileImg!)
                      : const NetworkImage("${AppConstant.imagesBaseURLForMentors}1.png"),
                ),
              ),
              CustomText(
                title: story.owner!.firstName! + story.owner!.lastName!,
                fontSize: 10,
                maxLins: 4,
                textAlign: TextAlign.center,
                textColor: const Color(0xff444444),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
