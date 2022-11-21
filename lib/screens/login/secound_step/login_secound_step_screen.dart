import 'package:client_app/screens/login/secound_step/login_secound_step_bloc.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/mobile_number_widget.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';

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
            child: ValueListenableBuilder<LoadingStatus>(
                valueListenable: bloc.loadingStatus,
                builder: (context, snapshot, child) {
                  if (snapshot == LoadingStatus.inprogress) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SingleChildScrollView(
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
                          MobileNumberField(
                            controller: bloc.controller,
                            selectedCountry: (selectedCode) {
                              bloc.countryCode = selectedCode;
                            },
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
                    );
                  }
                })),
      ),
    );
  }
}
