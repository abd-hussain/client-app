import 'package:client_app/locator.dart';
import 'package:client_app/screens/tips/tips_bloc.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TipsResultScreen extends StatefulWidget {
  const TipsResultScreen({super.key});

  @override
  State<TipsResultScreen> createState() => _TipsResuiltScreenState();
}

class _TipsResuiltScreenState extends State<TipsResultScreen> {
  final bloc = locator<TipsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff034061),
      appBar: AppBar(
        backgroundColor: const Color(0xff034061),
        elevation: 0,
        title: CustomText(
          title: AppLocalizations.of(context)!.result,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          textColor: Colors.white,
        ),
        leading: IconButton(
          onPressed: () async {
            await Navigator.of(context, rootNavigator: true)
                .pushNamedAndRemoveUntil(RoutesConstants.mainContainer, (Route<dynamic> route) => true);
          },
          icon: CustomText(
            title: AppLocalizations.of(context)!.exit,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            textColor: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //TODO
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CustomText(
            title: "Value",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            textColor: Colors.white,
            maxLins: 2,
          ),
          const SizedBox(height: 8),
          CustomText(
            title: "desc",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            textColor: Colors.white,
            maxLins: 2,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: CustomText(
                                title: "${index + 1}",
                                fontSize: 16,
                                textColor: const Color(0xff554d56),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomText(
                            title: "software like Aldus PageMaker including versions of Lorem Ipsum.",
                            fontSize: 16,
                            maxLins: 2,
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 16, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    title: AppLocalizations.of(context)!.specialistcanhelp,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textColor: const Color(0xff554d56),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return mentorView();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mentorView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff034061), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xff034061),
                    radius: 25,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "Abed alrahman al haj hussain",
                          fontSize: 10,
                          maxLins: 2,
                          textColor: const Color(0xff554d56),
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          title: "Dr. Dentil",
                          fontSize: 10,
                          textColor: const Color(0xff554d56),
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
              RatingBarIndicator(
                rating: 2.75, // TODO
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 16.0,
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
                    title: "10 JD / 30 Min",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    textColor: const Color(0xff554d56),
                  ),
                  const Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
