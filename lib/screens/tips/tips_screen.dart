import 'package:client_app/locator.dart';
import 'package:client_app/screens/tips/tips_bloc.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  late TipsBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = locator<TipsBloc>();
    bloc.handleReadingArguments(arguments: ModalRoute.of(context)!.settings.arguments);
    bloc.getQuestions();
    bloc.selectedIndexNotifier.value = 0;
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
      backgroundColor: const Color(0xff034061),
      appBar: customAppBar(title: ""),
      body: Column(
        children: [
          Expanded(child: Container()),
          Center(
            child: Image.network(
              AppConstant.imagesBaseURLForTips + bloc.tipInformations!.image!,
              width: 200,
              height: 200,
            ),
          ),
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomText(
                    title: bloc.tipInformations!.title!,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textColor: const Color(0xff444444),
                    maxLins: 2,
                  ),
                  const SizedBox(height: 50),
                  CustomText(
                    title: bloc.tipInformations!.desc!,
                    fontSize: 14,
                    textColor: const Color(0xff444444),
                    maxLins: 10,
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    title: "${AppLocalizations.of(context)!.note} ${bloc.tipInformations!.note!}",
                    fontSize: 12,
                    textColor: const Color.fromARGB(255, 122, 120, 120),
                    maxLins: 3,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    color: const Color(0xfff7f7f7),
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: "${AppLocalizations.of(context)!.referance} ${bloc.tipInformations!.referance!}",
                      fontSize: 12,
                      textColor: const Color.fromARGB(255, 122, 120, 120),
                      maxLins: 3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      buttonTitle: AppLocalizations.of(context)!.start,
                      buttonColor: const Color(0xff034061),
                      enableButton: true,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.tipsQuestionsScreen);
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
