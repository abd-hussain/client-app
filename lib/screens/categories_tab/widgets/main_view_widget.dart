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

class CategoryMainView extends StatelessWidget {
  final Category selectedCategory;
  final List<MentorsModelData>? mentorsListNotifier;

  const CategoryMainView({required this.selectedCategory, required this.mentorsListNotifier, super.key});

  //TODO : Compleate the Cards
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width - 126,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  title: selectedCategory.description!,
                  fontSize: 14,
                  textColor: const Color(0xff444444),
                  maxLins: 4,
                  textAlign: TextAlign.center,
                ),
              ),
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
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xff034061),
                radius: 25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: data.profileImg != ""
                      ? FadeInImage(
                          placeholder: const AssetImage("assets/images/avatar.jpeg"),
                          image: NetworkImage(AppConstant.imagesBaseURLForMentors + data.profileImg!, scale: 1),
                        )
                      : Image.asset(
                          'assets/images/avatar.jpeg',
                          width: 110.0,
                          height: 110.0,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                title: data.suffixeName!,
                fontSize: 12,
                textColor: const Color(0xff444444),
              ),
              CustomText(
                title: data.firstName!,
                fontSize: 14,
                textColor: const Color(0xff444444),
              ),
              CustomText(
                title: data.lastName!,
                fontSize: 14,
                textColor: const Color(0xff444444),
              ),
              const SizedBox(height: 4),
              RatingBarIndicator(
                rating: data.rate!,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: Currency().getCorrectAmountAndCurrency(data.hourRateByJD!),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textColor: const Color(0xff034061),
                  ),
                  CustomText(
                    title: "${data.classMin!} ${AppLocalizations.of(context)!.min}",
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
