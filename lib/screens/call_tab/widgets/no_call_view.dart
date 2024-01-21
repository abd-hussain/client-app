import 'package:client_app/locator.dart';
import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/models/https/majors_model.dart';
import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';
import 'package:client_app/shared_widgets/booking/instant_booking_bottom_sheet.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoCallView extends StatelessWidget {
  final bool isUserLoggedIn;
  final String language;
  final List<Category> listOfCategories;
  final List<MajorsData> listOfMajors;

  const NoCallView(
      {required this.isUserLoggedIn,
      required this.language,
      required this.listOfCategories,
      super.key,
      required this.listOfMajors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/86231-confused.zip', height: 250),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            title: AppLocalizations.of(context)!.nocalltoday,
            fontSize: 20,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            title: AppLocalizations.of(context)!.checkcallfromcalender,
            fontSize: 14,
            maxLins: 2,
            textAlign: TextAlign.center,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        bookMeeting(context),
      ],
    );
  }

  Widget bookMeeting(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffE8E8E8),
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              rowItem(
                context: context,
                containerColor: const Color(0xffE74C4C),
                title: AppLocalizations.of(context)!.meetingnow,
                desc: AppLocalizations.of(context)!.meetingnowdesc,
                icon: Icons.timer,
                onPress: () async {
                  if (isUserLoggedIn) {
                    await InstantBookingBottomSheetsUtil()
                        .bookMeetingBottomSheet(
                      context: context,
                      listOfCategories: listOfCategories,
                      listOfMajors: listOfMajors,
                      onEndSelection: (category, major, time) {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          RoutesConstants.bookingScreen,
                          arguments: {
                            "bookingType": BookingType.instant,
                            "categoryID": category.id,
                            "categoryName": category.name,
                            "majorID": major.id,
                            "majorName": major.name,
                            "meetingduration": time,
                          },
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!
                            .youhavetobeloggedintodothat),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              Container(height: 1, color: const Color(0xffE8E8E8)),
              const SizedBox(height: 8),
              rowItem(
                context: context,
                containerColor: const Color(0xff81D8D0),
                title: AppLocalizations.of(context)!.meetingshudule,
                desc: AppLocalizations.of(context)!.meetingshuduledesc,
                icon: Icons.calendar_month_outlined,
                onPress: () {
                  locator<MainContainerBloc>()
                      .appBarKey
                      .currentState!
                      .animateTo(1);
                  locator<MainContainerBloc>().currentTabIndexNotifier.value =
                      SelectedTab.categories;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowItem(
      {required BuildContext context,
      required Color containerColor,
      required IconData icon,
      required String title,
      required String desc,
      required Function onPress}) {
    return InkWell(
      onTap: () => onPress(),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: containerColor,
            ),
            child: Center(
              child: Icon(icon, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 16,
                textColor: const Color(0xff554d56),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                title: desc,
                fontSize: 12,
                textColor: const Color(0xffA2A3A4),
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          language == "en"
              ? const Icon(Icons.arrow_left_outlined)
              : const Icon(Icons.arrow_right_outlined)
        ],
      ),
    );
  }
}
