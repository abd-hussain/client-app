import 'package:client_app/models/https/mentors_model.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuggestedMentorsForYouView extends StatelessWidget {
  final MentorsModelData mentorInfo;
  final String language;
  const SuggestedMentorsForYouView({required this.mentorInfo, required this.language, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.mentorProfileScreen, arguments: {"id": mentorInfo.id});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff034061), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xff034061),
                      radius: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: mentorInfo.profileImg != ""
                            ? FadeInImage(
                                placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                image: NetworkImage(AppConstant.imagesBaseURLForMentors + mentorInfo.profileImg!,
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
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "${mentorInfo.suffixeName!} ${mentorInfo.firstName!} ${mentorInfo.lastName!}",
                            fontSize: 14,
                            maxLins: 2,
                            textColor: const Color(0xff554d56),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              CustomText(
                                title: "${AppLocalizations.of(context)!.specialist} :",
                                fontSize: 10,
                                textColor: const Color(0xff554d56),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              CustomText(
                                title: mentorInfo.categoryName!,
                                fontSize: 10,
                                textColor: const Color(0xff554d56),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Container(
                  height: 0.3,
                  color: const Color(0xff034061),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.face,
                          color: Color(0xff034061),
                          size: 20,
                        ),
                        CustomText(
                          title: AppLocalizations.of(context)!.rate,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          textColor: const Color(0xff034061),
                        ),
                      ],
                    ),
                    RatingBarIndicator(
                      rating: mentorInfo.rate!,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    const SizedBox()
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  height: 0.3,
                  color: const Color(0xff034061),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: Currency().getCorrectAmountAndCurrency(mentorInfo.hourRateByJD!),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textColor: const Color(0xff034061),
                    ),
                    CustomText(
                      title: "${mentorInfo.classMin!} ${AppLocalizations.of(context)!.min}",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textColor: const Color(0xff034061),
                    ),
                    Icon(language == "en" ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
