import 'package:client_app/screens/setup_screen/setup_bloc.dart';
import 'package:client_app/screens/setup_screen/widgets/change_language_widget.dart';
import 'package:client_app/screens/setup_screen/widgets/list_of_countries_widget.dart';
import 'package:client_app/screens/setup_screen/widgets/title_table_widget.dart';
import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _bloc = SetupBloc();

  @override
  void didChangeDependencies() {
    _bloc.getSystemLanguage(context).then((value) {
      _bloc.listOfCountries();
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChangeLanguageWidget(
              selectedLanguageNotifier: _bloc.selectedLanguageNotifier,
              segmentChange: (index) async => await _bloc.setLanguageInStorage(context, index),
            ),
            const TitleTableWidget(),
            ListOfCountriesWidget(countriesListNotifier: _bloc.countriesListNotifier),
          ],
        ),
      ),
    );
  }
}
