import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/screens/loyality/loyality_bloc.dart';
import 'package:client_app/screens/loyality/widgets/points_widget.dart';
import 'package:client_app/screens/loyality/widgets/rulles_widget.dart';
import 'package:client_app/screens/report/report_screen.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rate_my_app/rate_my_app.dart';

class LoyalityScreen extends StatefulWidget {
  const LoyalityScreen({super.key});

  @override
  State<LoyalityScreen> createState() => _LoyalityScreenState();
}

class _LoyalityScreenState extends State<LoyalityScreen> {
  final bloc = LoyalityBloc();

  @override
  void didChangeDependencies() {
    bloc.updatePoints();
    bloc.getRulles();
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
      backgroundColor: const Color(0xffECF5F3),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TopBarWidget(),
            const SizedBox(height: 20),
            PointsWidget(pointNotifier: bloc.pointNotifier),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                title: AppLocalizations.of(context)!.numberofpoints,
                fontSize: 14,
                textColor: const Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
            ),
            RullesWidget(
              loyalityRulles: bloc.loyalityRulles,
              onTap: (action) {
                handleWhereToGo(action);
              },
            ),
          ],
        ),
      ),
    );
  }

  void handleWhereToGo(String action) {
    //TODO : Handle add point after get back

    switch (action) {
      case "EDITPROFILE":
        Navigator.of(context, rootNavigator: true).pushNamed(
          RoutesConstants.editProfileScreen,
        );
        break;
      case "INVITEFRIEND":
        Navigator.of(context, rootNavigator: true).pushNamed(
          RoutesConstants.inviteFriendScreen,
        );
        break;
      case "REPORTSUGESTION":
        Navigator.of(context, rootNavigator: true).pushNamed(
          RoutesConstants.reportScreen,
          arguments: {AppConstant.argument1: ReportPageType.suggestion},
        );
        break;
      case "REPORTISSUE":
        Navigator.of(context, rootNavigator: true).pushNamed(
          RoutesConstants.reportScreen,
          arguments: {AppConstant.argument1: ReportPageType.issue},
        );
        break;
      case "REVIEW":
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          RateMyApp().showRateDialog(context, noButton: "test");
        });
        break;
      case "LIKEFACEBOOK":
        Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
          AppConstant.webViewPageUrl: AppConstant.facebookLink,
          AppConstant.pageTitle: AppLocalizations.of(context)!.facebook
        });
        break;
      case "LIKELINKEDIN":
        Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
          AppConstant.webViewPageUrl: AppConstant.linkedinLink,
          AppConstant.pageTitle: AppLocalizations.of(context)!.linkedin
        });
        break;
      case "REVIEWMENTOR":
        //TODO
        break;
      default:
    }
  }
}
