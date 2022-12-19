import 'package:client_app/locator.dart';
import 'package:client_app/models/https/answers_obj.dart';
import 'package:client_app/models/https/tips_questions.dart';
import 'package:client_app/screens/tips/tips_bloc.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';

class TipsQuestionsScreen extends StatefulWidget {
  const TipsQuestionsScreen({super.key});

  @override
  State<TipsQuestionsScreen> createState() => _TipsQuestionsScreenState();
}

class _TipsQuestionsScreenState extends State<TipsQuestionsScreen> {
  final bloc = locator<TipsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff034061),
      appBar: customAppBar(title: "", actions: [
        IconButton(
            onPressed: () async {
              await Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(RoutesConstants.mainContainer, (Route<dynamic> route) => true);
            },
            icon: const Icon(Icons.close)),
      ]),
      body: FutureBuilder<TipsQuestionsModel>(
          future: bloc.getQuestions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final item = snapshot.data!.data!;
              return Column(
                children: [
                  Expanded(child: Container()),
                  ValueListenableBuilder<int>(
                      valueListenable: bloc.selectedIndexNotifier,
                      builder: (context, snapshot, child) {
                        return CustomText(
                          title: "${snapshot + 1} / ${bloc.tipInformations!.steps}",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textColor: Colors.white,
                        );
                      }),
                  const SizedBox(height: 25),
                  ValueListenableBuilder<int>(
                      valueListenable: bloc.selectedIndexNotifier,
                      builder: (context, snapshot, child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: CustomText(
                            title: item[snapshot].question!,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            textColor: Colors.white,
                            maxLins: 2,
                          ),
                        );
                      }),
                  const SizedBox(height: 15),
                  const CustomText(
                    title: "?",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textColor: Colors.white,
                    maxLins: 2,
                  ),
                  Expanded(child: Container()),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 16, left: 8, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ValueListenableBuilder<int>(
                              valueListenable: bloc.selectedIndexNotifier,
                              builder: (context, snapshot, child) {
                                return CustomButton(
                                    buttonTitle: item[snapshot].answer1!,
                                    buttonColor: const Color(0xff554d56),
                                    enableButton: true,
                                    onTap: () {
                                      bloc.answerslist.add(
                                        AnswersList(
                                            question: item[snapshot].question!,
                                            answer: item[snapshot].answer1!,
                                            questionId: item[snapshot].id!,
                                            point: item[snapshot].answer1Points!),
                                      );
                                      if (bloc.selectedIndexNotifier.value + 1 < bloc.tipInformations!.steps!) {
                                        bloc.selectedIndexNotifier.value = bloc.selectedIndexNotifier.value + 1;
                                      } else {
                                        Navigator.of(context, rootNavigator: true)
                                            .pushNamed(RoutesConstants.tipsShareResultScreen);
                                      }
                                    });
                              }),
                          ValueListenableBuilder<int>(
                              valueListenable: bloc.selectedIndexNotifier,
                              builder: (context, snapshot, child) {
                                return CustomButton(
                                    buttonTitle: item[snapshot].answer2!,
                                    buttonColor: const Color(0xff554d56),
                                    enableButton: true,
                                    onTap: () {
                                      bloc.answerslist.add(
                                        AnswersList(
                                            question: item[snapshot].question!,
                                            answer: item[snapshot].answer2!,
                                            questionId: item[snapshot].id!,
                                            point: item[snapshot].answer2Points!),
                                      );
                                      if (bloc.selectedIndexNotifier.value + 1 < bloc.tipInformations!.steps!) {
                                        bloc.selectedIndexNotifier.value = bloc.selectedIndexNotifier.value + 1;
                                      } else {
                                        Navigator.of(context, rootNavigator: true)
                                            .pushNamed(RoutesConstants.tipsShareResultScreen);
                                      }
                                    });
                              }),
                          ValueListenableBuilder<int>(
                              valueListenable: bloc.selectedIndexNotifier,
                              builder: (context, snapshot, child) {
                                return CustomButton(
                                    buttonTitle: item[snapshot].answer3!,
                                    buttonColor: const Color(0xff554d56),
                                    enableButton: true,
                                    onTap: () {
                                      bloc.answerslist.add(
                                        AnswersList(
                                            question: item[snapshot].question!,
                                            answer: item[snapshot].answer3!,
                                            questionId: item[snapshot].id!,
                                            point: item[snapshot].answer3Points!),
                                      );
                                      if (bloc.selectedIndexNotifier.value + 1 < bloc.tipInformations!.steps!) {
                                        bloc.selectedIndexNotifier.value = bloc.selectedIndexNotifier.value + 1;
                                      } else {
                                        Navigator.of(context, rootNavigator: true)
                                            .pushNamed(RoutesConstants.tipsShareResultScreen);
                                      }
                                    });
                              }),
                          ValueListenableBuilder<int>(
                              valueListenable: bloc.selectedIndexNotifier,
                              builder: (context, snapshot, child) {
                                return CustomButton(
                                    buttonTitle: item[snapshot].answer4!,
                                    buttonColor: const Color(0xff554d56),
                                    enableButton: true,
                                    onTap: () {
                                      bloc.answerslist.add(
                                        AnswersList(
                                            question: item[snapshot].question!,
                                            answer: item[snapshot].answer4!,
                                            questionId: item[snapshot].id!,
                                            point: item[snapshot].answer4Points!),
                                      );
                                      if (bloc.selectedIndexNotifier.value + 1 < bloc.tipInformations!.steps!) {
                                        bloc.selectedIndexNotifier.value = bloc.selectedIndexNotifier.value + 1;
                                      } else {
                                        Navigator.of(context, rootNavigator: true)
                                            .pushNamed(RoutesConstants.tipsShareResultScreen);
                                      }
                                    });
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4CB6EA)),
                ),
              );
            }
          }),
    );
  }
}
