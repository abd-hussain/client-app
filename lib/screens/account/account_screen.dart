import 'package:client_app/screens/account/account_bloc.dart';
import 'package:client_app/screens/account/widgets/header.dart';
import 'package:client_app/screens/account/widgets/list_of_options.dart';
import 'package:client_app/screens/account/widgets/sub_header.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final bloc = AccountBloc();

  @override
  void initState() {
    logDebugMessage(message: 'Account init Called ...');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.mainContext = context;
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      body: Column(
        children: [
          const ProfileHeader(//TODO: handle passing name if user loged in
              // firstName: "abedalrahman",
              ),
          const ProfileSubHeader(),
          const SizedBox(height: 8),
          ListOfOptions(
            listOfSettingsOptions: bloc.listOfSettingsOptions,
            listOfReachOutUsOptions: bloc.listOfReachOutUsOptions,
            listOfSupportOptions: bloc.listOfSupportOptions,
            isItLoggedIn: false, //TODO: handle passing name if user loged in
          ),
        ],
      ),
    );
  }
}
