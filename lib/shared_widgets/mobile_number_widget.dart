import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:client_app/models/https/countries_model.dart';

class MobileNumberField extends StatefulWidget {
  final Country initialCountry;
  final List<Country> countryList;
  final Function(String) selectedCountryCode;
  final Function(String) enteredPhoneNumber;

  final ValueNotifier<bool> enableVerifyBtn;
  const MobileNumberField(
      {required this.selectedCountryCode,
      required this.initialCountry,
      super.key,
      required this.enableVerifyBtn,
      required this.countryList,
      required this.enteredPhoneNumber});

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  final ValueNotifier<Country> selectedPhoneCountryNotifier =
      ValueNotifier<Country>(Country());
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    selectedPhoneCountryNotifier.value = widget.initialCountry;
    widget.selectedCountryCode(widget.initialCountry.dialCode!);
    controllerLisiner();
    super.initState();
  }

  controllerLisiner() {
    controller.addListener(() {
      if (selectedPhoneCountryNotifier.value.minLength! <=
              controller.text.length &&
          controller.text.length <=
              selectedPhoneCountryNotifier.value.maxLength!) {
        widget.enableVerifyBtn.value = true;
        widget.enteredPhoneNumber(controller.text);
        widget
            .selectedCountryCode(selectedPhoneCountryNotifier.value.dialCode!);
      } else {
        widget.enableVerifyBtn.value = false;
        widget.enteredPhoneNumber("");
        widget.selectedCountryCode("");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ValueListenableBuilder<Country>(
            valueListenable: selectedPhoneCountryNotifier,
            builder: (context, selectedPhoneCountryData, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (text) async {
                      setState(() {});
                    },
                    controller: controller,
                    enableSuggestions: false,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          selectedPhoneCountryData.maxLength!),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.entermobilenumber,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _returnCorrectColor(selectedPhoneCountryData),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _returnCorrectColor(selectedPhoneCountryData),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _returnCorrectColor(selectedPhoneCountryData),
                        ),
                      ),
                      prefixIcon: SizedBox(
                        width: 100,
                        child: IconButton(
                          onPressed: () async {
                            await BottomSheetsUtil().countryBottomSheet(
                                context, widget.countryList, (value) async {
                              selectedPhoneCountryNotifier.value = value;
                              controller.clear();
                            });
                          },
                          icon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      "assets/images/flagPlaceHolderImg.png"),
                                  image: NetworkImage(
                                      selectedPhoneCountryData.flagImage!,
                                      scale: 1),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                title: selectedPhoneCountryData.dialCode!
                                    .replaceAll("00", "+"),
                                textColor: const Color(0xff191C1F),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/images/dropdown_icn.png',
                                color: const Color(0xff8F8F92),
                                width: 12,
                                height: 12,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  _returnErrorMessageForPhoneNumber(selectedPhoneCountryData),
                ],
              );
            }),
      ),
    );
  }

  Widget _returnErrorMessageForPhoneNumber(Country selectedCountry) {
    if ((controller.text.isEmpty) ||
        (selectedCountry.minLength! <= controller.text.length &&
            controller.text.length <= selectedCountry.maxLength!)) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 2, left: 16, right: 16),
        child: CustomText(
          title: AppLocalizations.of(context)!.mobilenumbernotvalid,
          textColor: const Color(0xffE74C4C),
          fontSize: 11,
        ),
      );
    }
  }

  Color _returnCorrectColor(Country selectedCountry) {
    if (controller.text.isEmpty) {
      return const Color(0xffE8E8E8);
    } else if (selectedCountry.minLength! <= controller.text.length &&
        controller.text.length <= selectedCountry.maxLength!) {
      return const Color(0xff4CB6EA);
    } else {
      return const Color(0xffE74C4C);
    }
  }
}
