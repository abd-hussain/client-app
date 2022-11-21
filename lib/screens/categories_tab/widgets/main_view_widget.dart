import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/models/https/mentors_model.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/shimmers/shimmer_cards_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                              return _item(index, mentorsListNotifier!.length);
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

  Widget _item(int index, int listLenght) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _card(mentorsListNotifier![index]),
          listLenght - 1 == index
              ? const SizedBox(
                  height: 16,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _card(MentorsModelData data) {
    return Container(
      height: 150,
      width: double.infinity,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: data.profileImg != null
                  ? SizedBox(
                      width: 50,
                      height: 50,
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/images/avatar.jpeg"),
                        image: NetworkImage(data.profileImg!, scale: 1),
                      ),
                    )
                  : Image.asset(
                      "assets/images/avatar.jpeg",
                      width: 50,
                      height: 50,
                    ),
            ),
            const SizedBox(height: 4),
            CustomText(
              title: data.firstName!,
              fontSize: 12,
              textColor: const Color(0xff444444),
            ),
            CustomText(
              title: data.lastName!,
              fontSize: 12,
              textColor: const Color(0xff444444),
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: const [
                Icon(Icons.flag),
                Text("Review"),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star_border),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// String? lastName;
// int? id;
// String? email;
// bool? blocked;
// String? invitationCode;
// String? appVersion;
// String? lastUsage;
// String? apiKey;
// String? createdAt;
// String? mobileNumber;
// int? categoryId;
// String? firstName;
// int? gender;
// String? referalCode;
// String? profileImg;
// String? dateOfBirth;
// String? lastOtp;
// int? countryId;
