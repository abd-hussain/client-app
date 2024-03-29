import 'package:client_app/screens/account_tab/account_bloc.dart';
import 'package:client_app/screens/account_tab/widgets/collection_list_option.dart';
import 'package:client_app/screens/account_tab/widgets/footer.dart';
import 'package:client_app/screens/account_tab/widgets/header.dart';
import 'package:client_app/screens/account_tab/widgets/sub_header.dart';
import 'package:client_app/screens/account_tab/widgets/title_view.dart';
import 'package:client_app/shared_widgets/admob_banner.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final bloc = AccountBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Account init Called ...');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeader(
          firstName: bloc.checkIfUserIsLoggedIn()
              ? bloc.box.get(DatabaseFieldConstant.userFirstName)
              : AppLocalizations.of(context)!.anonymous,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSubHeader(isUserLoggedIn: bloc.checkIfUserIsLoggedIn()),
                const AddMobBanner(),
                bloc.checkIfUserIsLoggedIn()
                    ? TitleView(
                        title: AppLocalizations.of(context)!.accountsettings)
                    : Container(),
                bloc.checkIfUserIsLoggedIn()
                    ? CollectionListOptionView(
                        listOfOptions: bloc.listOfAccountOptions(context),
                        containerHight: 200)
                    : Container(),
                TitleView(title: AppLocalizations.of(context)!.generalsettings),
                CollectionListOptionView(
                    listOfOptions: bloc.listOfSettingsOptions(context),
                    containerHight: 125),
                TitleView(title: AppLocalizations.of(context)!.reachouttous),
                CollectionListOptionView(
                    listOfOptions: bloc.listOfReachOutUsOptions(context),
                    containerHight: 200),
                TitleView(title: AppLocalizations.of(context)!.support),
                CollectionListOptionView(
                    listOfOptions: bloc.listOfSupportOptions(context),
                    containerHight: 125),
                const SizedBox(height: 8),
                const AddMobBanner(),
                FooterView(
                  language: bloc.box.get(DatabaseFieldConstant.language),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
