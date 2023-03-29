import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/models/https/mentors_model.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/shimmers/shimmer_cards_list.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';

class CategoryMainView extends StatelessWidget {
  final Category selectedCategory;
  final List<MentorsModelData>? mentorsListNotifier;

  const CategoryMainView({required this.selectedCategory, required this.mentorsListNotifier, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width - 126,
        child: Column(
          children: [
            Expanded(
              child: mentorsListNotifier == null
                  ? const ShimmerCardListView(count: 5)
                  : mentorsListNotifier!.isEmpty
                      ? noMentorToShow(context)
                      : ListView.builder(
                          itemCount: mentorsListNotifier!.length,
                          itemBuilder: (context, index) {
                            return _item(context, index, mentorsListNotifier!.length);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noMentorToShow(BuildContext context) {
    return Center(
      child: CustomText(
        title: AppLocalizations.of(context)!.noitem,
        fontSize: 14,
        textColor: const Color(0xff444444),
        maxLins: 4,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _item(BuildContext context, int index, int listLenght) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _card(context, mentorsListNotifier![index]),
          listLenght - 1 == index
              ? const SizedBox(
                  height: 16,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, MentorsModelData data) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.mentorProfileScreen, arguments: {"id": data.id});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 75,
                    height: 75,
                    child: Center(
                      child: data.profileImg != ""
                          ? FadeInImage(
                              placeholder: const AssetImage("assets/images/avatar.jpeg"),
                              image: NetworkImage(AppConstant.imagesBaseURLForMentors + data.profileImg!),
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              'assets/images/avatar.jpeg',
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: data.suffixeName!,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: const Color(0xff444444),
                      ),
                      CustomText(
                        title: data.firstName!,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textColor: const Color(0xff444444),
                      ),
                      CustomText(
                        title: data.lastName!,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textColor: const Color(0xff444444),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Ionicons.language,
                            size: 12,
                          ),
                          const CustomText(
                            title: " : ",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: Color(0xff444444),
                          ),
                          const SizedBox(width: 2),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: 20,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.languages!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                          child: CustomText(
                                            title: data.languages![index], //== "English" ? "E" : "ع",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            textColor: const Color(0xff444444),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                      const SizedBox(width: 6),
                      Row(
                        children: [
                          const Icon(
                            Ionicons.star_half_outline,
                            size: 12,
                          ),
                          const CustomText(
                            title: " : ",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: Color(0xff444444),
                          ),
                          RatingBarIndicator(
                            rating: data.rate!,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 14,
                          ),
                          const SizedBox(width: 2),
                          CustomText(
                            title: "${data.numberOfReviewr} ",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            textColor: const Color(0xff444444),
                          ),
                          CustomText(
                            title: AppLocalizations.of(context)!.vote,
                            fontSize: 12,
                            textColor: const Color(0xff444444),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: Currency().calculateHourRate(data.hourRate!, Timing.halfHour),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textColor: const Color(0xff034061),
                  ),
                  CustomText(
                    title: "30 ${AppLocalizations.of(context)!.min}",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textColor: const Color(0xff034061),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
