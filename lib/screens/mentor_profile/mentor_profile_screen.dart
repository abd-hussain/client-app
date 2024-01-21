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
import 'package:ionicons/ionicons.dart';

class MentorProfileScreen extends StatefulWidget {
  const MentorProfileScreen({super.key});

  @override
  State<MentorProfileScreen> createState() => _MentorProfileScreenState();
}

class _MentorProfileScreenState extends State<MentorProfileScreen> {
  final bloc = MentorProfileBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context,
        arguments: ModalRoute.of(context)!.settings.arguments);
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
      appBar: customAppBar(title: AppLocalizations.of(context)!.mentorprofile),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatus,
              builder: (context, loadingsnapshot, child) {
                if (loadingsnapshot != LoadingStatus.inprogress) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: bloc.profileImageUrl != ""
                                    ? Image.network(
                                        AppConstant.imagesBaseURLForMentors +
                                            bloc.profileImageUrl!,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        'assets/images/avatar.jpeg',
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: bloc.suffixeName!,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  textColor: const Color(0xff554d56),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 160,
                                  child: CustomText(
                                    title:
                                        "${bloc.firstName!} ${bloc.lastName!}",
                                    fontSize: 18,
                                    maxLins: 3,
                                    fontWeight: FontWeight.bold,
                                    textColor: const Color(0xff554d56),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      title:
                                          "${AppLocalizations.of(context)!.category} :",
                                      fontSize: 12,
                                      textColor: const Color(0xff554d56),
                                    ),
                                    const SizedBox(width: 8),
                                    CustomText(
                                      title: bloc.categoryName!,
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
                        const SizedBox(height: 10),
                        CustomText(
                          title: bloc.bio!.toString(),
                          fontSize: 12,
                          maxLins: 5,
                          textColor: const Color(0xff554d56),
                        ),
                        const SizedBox(height: 10),
                        Row(
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
                                const SizedBox(height: 10),
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.gender,
                                  value: bloc.gender!,
                                  icon: Icon(
                                    bloc.genderIndex == 1
                                        ? Icons.male
                                        : Icons.female,
                                    color: const Color(0xff444444),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.hourrate,
                                  value: "${bloc.hourRate} ${bloc.currency}",
                                  icon: const Icon(
                                    Ionicons.wallet_outline,
                                    color: Color(0xff444444),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!
                                      .countryprofile,
                                  value: bloc.countryName!,
                                  icon: SizedBox(
                                    width: 30,
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          "assets/images/flagPlaceHolderImg.png"),
                                      image: NetworkImage(AppConstant
                                              .imagesBaseURLForCountries +
                                          bloc.countryFlag!),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MentorGridItem(
                                  title:
                                      AppLocalizations.of(context)!.experience,
                                  value:
                                      "${bloc.calculateExperience(bloc.experienceSince)} ${AppLocalizations.of(context)!.year}",
                                  icon: const Icon(
                                    Ionicons.library_outline,
                                    color: Color(0xff444444),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!
                                      .freecallexsist,
                                  value: bloc.freeCall
                                      ? AppLocalizations.of(context)!.avaliable
                                      : AppLocalizations.of(context)!
                                          .notavaliable,
                                  icon: const Icon(
                                    Ionicons.magnet_outline,
                                    color: Color(0xff444444),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          title:
                              "-- ${AppLocalizations.of(context)!.specialist} --",
                          fontSize: 14,
                          textColor: const Color(0xff554d56),
                        ),
                        const SizedBox(height: 10),
                        MultiSelectContainer(
                          items: bloc.majors,
                          singleSelectedItem: true,
                          highlightColor: const Color(0xff034061),
                          splashColor: const Color(0xff034061),
                          onChange: (allSelectedItems, selectedItem) {},
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          title:
                              "-- ${AppLocalizations.of(context)!.ratingandreview} --",
                          fontSize: 14,
                          textColor: const Color(0xff554d56),
                        ),
                        ReviewHeaderView(
                          ratesCount: bloc.reviews.length,
                          totalRates: bloc.totalRate,
                        ),
                        SizedBox(
                          height: bloc.reviews.isEmpty ? 20 : 400,
                          child: ReviewBodyView(reviews: bloc.reviews),
                        ),
                      ],
                    ),
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
              return MentorProfileFooterView(
                isUserLoggedin: bloc.checkIfUserIsLoggedIn(),
                mentorId: bloc.mentorId!,
                hourRate: bloc.hourRate!,
                currency: bloc.currency!,
                suffixeName: bloc.suffixeName!,
                firstName: bloc.firstName!,
                gender: bloc.gender!,
                lastName: bloc.lastName!,
                countryName: bloc.countryName!,
                countryFlag: bloc.countryFlag!,
                categoryName: bloc.categoryName!,
                listOfMajors: bloc.listOfMajors,
                profileImageUrl: bloc.profileImageUrl!,
                workingHoursFriday: bloc.workingHoursFriday,
                workingHoursWednesday: bloc.workingHoursWednesday,
                workingHoursMonday: bloc.workingHoursMonday,
                workingHoursSaturday: bloc.workingHoursSaturday,
                workingHoursSunday: bloc.workingHoursSunday,
                workingHoursThursday: bloc.workingHoursThursday,
                workingHoursTuesday: bloc.workingHoursTuesday,
                listOfAppointments: bloc.listOfAppointments,
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
    );
  }
}
