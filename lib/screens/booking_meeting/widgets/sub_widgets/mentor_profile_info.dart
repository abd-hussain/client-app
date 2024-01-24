import 'package:client_app/models/https/mentor_info_avaliable_model.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';

class FoundedMentorInfoView extends StatelessWidget {
  final MentorInfoAvaliableResponseData data;
  final bool selected;
  final Function() onPress;

  const FoundedMentorInfoView({
    super.key,
    required this.data,
    required this.selected,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => onPress(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected
                    ? const Color(0xff034061)
                    : const Color(0xffE8E8E8),
                width: 3,
              ),
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
                        height: 100,
                        child: Center(
                          child: data.profileImg != ""
                              ? FadeInImage(
                                  placeholder: const AssetImage(
                                      "assets/images/avatar.jpeg"),
                                  image: NetworkImage(
                                      AppConstant.imagesBaseURLForMentors +
                                          data.profileImg!),
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
                              ClipOval(
                                child: FadeInImage(
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                    placeholder: const AssetImage(
                                        "assets/images/flagPlaceHolderImg.png"),
                                    image: NetworkImage(
                                        AppConstant.imagesBaseURLForCountries +
                                            data.countryFlag!,
                                        scale: 1)),
                              ),
                              const SizedBox(width: 8),
                              CustomText(
                                title: data.countryName!,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                textColor: const Color(0xff444444),
                              ),
                            ],
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Center(
                                              child: CustomText(
                                                title: data.languages![
                                                    index], //== "English" ? "E" : "ع",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                textColor:
                                                    const Color(0xff444444),
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
                                title: "${data.numberOfReviewers} ",
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
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: Currency().calculateHourRate(
                                      data.hourRate!,
                                      Timing.halfHour,
                                      data.currency!,
                                      false),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  textColor: const Color(0xff034061),
                                ),
                                CustomText(
                                  title:
                                      "30 ${AppLocalizations.of(context)!.min}",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  textColor: const Color(0xff034061),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
