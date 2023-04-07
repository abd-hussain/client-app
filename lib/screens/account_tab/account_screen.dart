import 'package:client_app/screens/account_tab/account_bloc.dart';
import 'package:client_app/screens/account_tab/widgets/header.dart';
import 'package:client_app/screens/account_tab/widgets/list_of_options.dart';
import 'package:client_app/screens/account_tab/widgets/sub_header.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
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
        ProfileSubHeader(isUserLoggedIn: bloc.checkIfUserIsLoggedIn()),
        const SizedBox(height: 8),
        ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, snapshot, child) {
              return ListOfOptions(
                listOfSettingsOptions: bloc.listOfSettingsOptions(context),
                listOfReachOutUsOptions: bloc.listOfReachOutUsOptions(context),
                listOfSupportOptions: bloc.listOfSupportOptions(context),
                listOfAccountOptions: bloc.listOfAccountOptions(context),
                isItLoggedIn: bloc.checkIfUserIsLoggedIn(),
              );
            }),
      ],
    );
  }
}
