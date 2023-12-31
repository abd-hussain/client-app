import 'package:client_app/models/https/countries_model.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryField extends StatelessWidget {
  final TextEditingController controller;
  final List<Country> listOfCountries;
  final Country? selectedCountry;
  const CountryField(
      {super.key,
      required this.controller,
      required this.listOfCountries,
      required this.selectedCountry});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          CustomTextField(
            readOnly: true,
            controller: controller,
            hintText: AppLocalizations.of(context)!.countryprofile,
            padding: const EdgeInsets.only(left: 8, right: 16),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(45),
            ],
          ),
          InkWell(
            onTap: () async {
              await BottomSheetsUtil().countryBottomSheet(
                  context, listOfCountries, (selectedCountry) {
                controller.text = selectedCountry.name!;
                selectedCountry = selectedCountry;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
