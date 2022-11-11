import 'package:client_app/screens/login/secound_step/login_secound_step_bloc.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/routes.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginSecoundStepScreen extends StatelessWidget {
  const LoginSecoundStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = LoginSecoundStepBloc();
    bloc.controllerLisiner();
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const TopBarWidget(),
              const SizedBox(height: 20),
              Image.asset("assets/images/login_2.png"),
              const SizedBox(height: 20),
              CustomText(
                title: AppLocalizations.of(context)!.enteryourphonenumber,
                fontSize: 14,
                textColor: Colors.black,
              ),
              const SizedBox(height: 8),
              CustomText(
                title: AppLocalizations.of(context)!.enteryourphonenumberexample,
                fontSize: 10,
                textColor: Colors.grey,
              ),
              const SizedBox(height: 20),
              Directionality(
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
                        itemFilter: (c) => bloc.countryCodeFiltered.contains(c.isoCode),
                        itemBuilder: _buildDropdownItem,
                        sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                        onValuePicked: (Country country) {
                          bloc.countryCode = country.phoneCode;
                        },
                      ),
                      VerticalDivider(color: Colors.grey[900]),
                      Expanded(
                        child: TextField(
                          maxLength: 17,
                          keyboardType: TextInputType.number,
                          controller: bloc.controller,
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
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                  valueListenable: bloc.enableVerifyBtn,
                  builder: (context, snapshot, child) {
                    return CustomButton(
                        buttonTitle: AppLocalizations.of(context)!.verify,
                        enableButton: snapshot,
                        onTap: () {
                          bloc.callRequest().then((value) {
                            logger.wtf("value.data!.lastOtp");
                            logger.wtf(value.data!.lastOtp);
                            if (bloc.controller.text[0] == "0") {
                              bloc.controller.text = bloc.controller.text.substring(1);
                            }
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(RoutesConstants.loginThirdStepRoute, arguments: {
                              AppConstant.countryCode: bloc.countryCode,
                              AppConstant.mobileNumber: bloc.controller.text,
                              AppConstant.useridToPass: value.data!.id!,
                              AppConstant.apikeyToPass: value.data!.apiKey!
                            });
                          });
                        });
                  }),
            ],
          ),
        )),
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
