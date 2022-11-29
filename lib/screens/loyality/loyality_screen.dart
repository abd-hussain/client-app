import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/screens/loyality/loyality_bloc.dart';
import 'package:client_app/screens/loyality/widgets/points_widget.dart';
import 'package:client_app/screens/loyality/widgets/rulles_widget.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoyalityScreen extends StatefulWidget {
  const LoyalityScreen({super.key});

  @override
  State<LoyalityScreen> createState() => _LoyalityScreenState();
}

class _LoyalityScreenState extends State<LoyalityScreen> {
  final bloc = LoyalityBloc();

  @override
  void initState() {
    bloc.updatePoints();
    bloc.getRulles();
    super.initState();
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
                //TODO : Handle Press on action
              },
            ),
          ],
        ),
      ),
    );
  }
}
