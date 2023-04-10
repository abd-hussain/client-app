import 'package:client_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/services.dart';

class MobileNumberField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) selectedCountry;
  const MobileNumberField({required this.controller, required this.selectedCountry, super.key});

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey),
              ),
              child: CountryPickerDropdown(
                iconSize: 16,
                initialValue: 'JO',
                itemFilter: (c) => countryCodeFiltered.contains(c.isoCode),
                itemBuilder: _buildDropdownItem,
                sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                onValuePicked: (Country country) {
                  widget.selectedCountry(country.phoneCode);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                height: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  maxLength: 17,
                  keyboardType: TextInputType.number,
                  controller: widget.controller,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 0, bottom: 4),
                    border: InputBorder.none,
                    counterText: "",
                    hintStyle: const TextStyle(color: Colors.black54, fontSize: 20),
                    hintText: AppLocalizations.of(context)!.entermobilenumber,
                  ),
                ),
              ),
            ),
          ),
        ],
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
