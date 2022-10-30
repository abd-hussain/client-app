// import 'package:client_app/screens/setup_screen/setup_bloc.dart';
// import 'package:client_app/screens/setup_screen/widgets/list_of_countries_widget.dart';
// import 'package:client_app/shared_widgets/custom_appbar.dart';
// import 'package:client_app/shared_widgets/sub_page_app_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeCountryScreen extends StatefulWidget {
  const ChangeCountryScreen({Key? key}) : super(key: key);

  @override
  State<ChangeCountryScreen> createState() => _ChangeCountryScreenState();
}

class _ChangeCountryScreenState extends State<ChangeCountryScreen> {
//   final _bloc = SetupBloc();

//   @override
//   void initState() {
//     _bloc.getSystemLanguage(context).then((value) {
//       _bloc.listOfCountries();
//     });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       appBar: customAppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SubPageHeaderName(title: AppLocalizations.of(context)!.change_country),
//           const SizedBox(height: 20),
//           ListOfCountriesWidget(countriesListNotifier: _bloc.countriesListNotifier),
//         ],
//       ),
        );
  }
}
