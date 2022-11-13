import 'package:client_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/services.dart';

class MobileNumberField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) selectedCountry;
  const MobileNumberField({required this.controller, required this.selectedCountry, super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CountryPickerDropdown(
              iconSize: 16,
              initialValue: 'JO',
              itemFilter: (c) => countryCodeFiltered.contains(c.isoCode),
              itemBuilder: _buildDropdownItem,
              sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
              onValuePicked: (Country country) {
                selectedCountry(country.phoneCode);
              },
            ),
            VerticalDivider(color: Colors.grey[900]),
            Expanded(
              child: TextField(
                maxLength: 17,
                keyboardType: TextInputType.number,
                controller: controller,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 20),
                  border: InputBorder.none,
                  counterText: "",
                  hintStyle: const TextStyle(color: Colors.black54, fontSize: 20),
                  hintText: AppLocalizations.of(context)!.entermobilenumber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItem(Country country) => Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}"),
          ],
        ),
      );
}
