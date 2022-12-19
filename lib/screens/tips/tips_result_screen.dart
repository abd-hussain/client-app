import 'package:client_app/locator.dart';
import 'package:client_app/models/https/mentors_model.dart';
import 'package:client_app/screens/tips/tips_bloc.dart';
import 'package:client_app/screens/tips/widgets/mentors_view.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TipsResultScreen extends StatefulWidget {
  const TipsResultScreen({super.key});

  @override
  State<TipsResultScreen> createState() => _TipsResuiltScreenState();
}

class _TipsResuiltScreenState extends State<TipsResultScreen> {
  final bloc = locator<TipsBloc>();

  @override
  void didChangeDependencies() {
    bloc.listOfMentors(categoryID: bloc.tipInformations!.catId!);
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
      body: FutureBuilder(
          future: bloc.submitAnswers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data!.data;
              return Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomText(
                      title: result!.title!,
                      fontSize: 20,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: result.desc!,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textColor: Colors.white,
                      maxLins: 2,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Container(
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
                            const SizedBox(height: 30),
                            ValueListenableBuilder<List<MentorsModelData>?>(
                                valueListenable: bloc.mentorsListNotifier,
                                builder: (context, snapshot, child) {
                                  if (snapshot!.isNotEmpty) {
                                    return Expanded(
                                      child: ListView.builder(
                                          itemCount: snapshot.length,
                                          itemBuilder: (context, index) {
                                            return SuggestedMentorsForYouView(
                                              mentorInfo: snapshot[index],
                                              language: bloc.box.get(DatabaseFieldConstant.language),
                                            );
                                          }),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xff034061)),
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }
          }),
    );
  }
}
