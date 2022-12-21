import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/screens/mentor_profile/mentor_profile_bloc.dart';
import 'package:client_app/screens/mentor_profile/widget/footer_view.dart';
import 'package:client_app/screens/mentor_profile/widget/grid_item.dart';
import 'package:client_app/screens/mentor_profile/widget/review_header_view.dart';
import 'package:client_app/screens/mentor_profile/widget/reviews_body_view.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MentorProfileScreen extends StatefulWidget {
  const MentorProfileScreen({super.key});

  @override
  State<MentorProfileScreen> createState() => _MentorProfileScreenState();
}

class _MentorProfileScreenState extends State<MentorProfileScreen> {
  final bloc = MentorProfileBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context, arguments: ModalRoute.of(context)!.settings.arguments);
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
      backgroundColor: const Color(0xffFAFAFA),
      appBar: customAppBar(title: "", actions: [
        IconButton(
          onPressed: () {
            //TODO
          },
          icon: const Icon(Icons.share),
        )
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatus,
              builder: (context, loadingsnapshot, child) {
                if (loadingsnapshot != LoadingStatus.inprogress) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff034061),
                          radius: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: bloc.profileImageUrl != ""
                                ? FadeInImage(
                                    placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                    image: NetworkImage(AppConstant.imagesBaseURLForMentors + bloc.profileImageUrl!,
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
                      const SizedBox(height: 20),
                      CustomText(
                        title: "${bloc.suffixeName!} ${bloc.firstName!} ${bloc.lastName!}",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textColor: const Color(0xff554d56),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: "${AppLocalizations.of(context)!.specialist} :",
                            fontSize: 12,
                            textColor: const Color(0xff554d56),
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            title: bloc.categoryName!.toString(),
                            fontSize: 12,
                            textColor: const Color(0xff554d56),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: bloc.bio!.toString(),
                          fontSize: 12,
                          maxLins: 5,
                          textColor: const Color(0xff554d56),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.language,
                                  value: bloc.speakingLanguage!,
                                  icon: const Icon(
                                    Icons.translate,
                                    color: Color(0xff444444),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.gender,
                                  value: bloc.gender!,
                                  icon: Icon(
                                    bloc.genderIndex == 1 ? Icons.male : Icons.female,
                                    color: const Color(0xff444444),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.countryprofile,
                                  value: bloc.countryName!,
                                  icon: SizedBox(
                                    width: 30,
                                    child: FadeInImage(
                                      placeholder: const AssetImage("assets/images/flagPlaceHolderImg.png"),
                                      image: NetworkImage(AppConstant.imagesBaseURLForCountries + bloc.countryFlag!),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.dbprofile,
                                  value: bloc.dateOfBirth!,
                                  icon: const Icon(
                                    Icons.date_range_outlined,
                                    color: Color(0xff444444),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: "-- ${AppLocalizations.of(context)!.specialist} --",
                          fontSize: 14,
                          maxLins: 5,
                          textColor: const Color(0xff554d56),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MultiSelectContainer(items: bloc.majors, onChange: (allSelectedItems, selectedItem) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: "-- ${AppLocalizations.of(context)!.ratingandreview} --",
                          fontSize: 14,
                          maxLins: 5,
                          textColor: const Color(0xff554d56),
                        ),
                      ),
                      ReviewHeaderView(
                        ratesCount: bloc.reviews.length,
                        totalRates: bloc.totalRate,
                      ),
                      SizedBox(height: 400, child: ReviewBodyView(reviews: bloc.reviews)),
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
      bottomNavigationBar: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatus,
          builder: (context, loadingsnapshot, child) {
            if (loadingsnapshot != LoadingStatus.inprogress) {
              return MentorProfileFooterView(hourRate: bloc.hourRate!, classMin: bloc.classMin!);
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
    );
  }
}
