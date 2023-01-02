import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TipsView extends StatelessWidget {
  final String language;
  final List<MainTips> listOfTips;
  final Function(MainTips) onTipSelected;

  const TipsView({required this.language, required this.listOfTips, required this.onTipSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
            color: Colors.grey[300],
            width: MediaQuery.of(context).size.width,
            child: CustomText(
              title: AppLocalizations.of(context)!.todaytips,
              fontSize: 16,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: listOfTips.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final MainTips tip = listOfTips[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => tip.steps! == 0 ? null : onTipSelected(tip),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xff444444), width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 2),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Image.network(
                                  AppConstant.imagesBaseURLForTips + tip.image!,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              CustomText(
                                title: tip.title!,
                                fontSize: 14,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                                textColor: const Color(0xff444444),
                                maxLins: 3,
                              ),
                              Expanded(child: Container()),
                              CustomText(
                                title: tip.steps! > 0 ? "${tip.steps} ${AppLocalizations.of(context)!.steps}" : "",
                                fontSize: 14,
                                textColor: const Color(0xff444444),
                              ),
                              const SizedBox(height: 3),
                              footerView(context, language, tip.steps!),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget footerView(BuildContext context, String language, int steps) {
    return Container(
      color: Colors.grey[300],
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: steps > 0
            ? Row(
                children: [
                  CustomText(
                    title: AppLocalizations.of(context)!.learnmore,
                    fontSize: 14,
                    textColor: const Color(0xff444444),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    language == "en" ? Icons.arrow_circle_right : Icons.arrow_circle_left,
                    color: const Color(0xff444444),
                  )
                ],
              )
            : Center(
                child: CustomText(
                  title: AppLocalizations.of(context)!.comingsoon,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  textColor: const Color.fromARGB(255, 221, 11, 11),
                ),
              ),
      ),
    );
  }
}
