import 'package:client_app/screens/login/secound_step/login_secound_step_bloc.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/loading_view.dart';
import 'package:client_app/shared_widgets/mobile_number_widget.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginSecoundStepScreen extends StatefulWidget {
  const LoginSecoundStepScreen({super.key});

  @override
  State<LoginSecoundStepScreen> createState() => _LoginSecoundStepScreenState();
}

class _LoginSecoundStepScreenState extends State<LoginSecoundStepScreen> {
  final bloc = LoginSecoundStepBloc();

  @override
  void didChangeDependencies() {
    bloc.maincontext = context;
    bloc.listOfCountries();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: ValueListenableBuilder<LoadingStatus>(
                valueListenable: bloc.loadingStatus,
                builder: (context, snapshot, child) {
                  if (snapshot == LoadingStatus.inprogress) {
                    return const LoadingView();
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const TopBarWidget(),
                          const SizedBox(height: 20),
                          Image.asset("assets/images/login_2.png"),
                          const SizedBox(height: 20),
                          CustomText(
                            title: AppLocalizations.of(context)!
                                .enteryourphonenumber,
                            fontSize: 16,
                            textColor: const Color(0xff444444),
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            title: AppLocalizations.of(context)!
                                .enteryourphonenumberexample,
                            fontSize: 14,
                            textColor: const Color(0xffBFBFBF),
                          ),
                          const SizedBox(height: 10),
                          MobileNumberField(
                            initialCountry:
                                bloc.returnSelectedCountryFromDatabase(),
                            countryList: bloc.countriesList,
                            enableVerifyBtn: bloc.enableVerifyBtn,
                            selectedCountryCode: (selectedCode) {
                              bloc.countryId = selectedCode.id!;
                              bloc.countryCode = selectedCode.dialCode!;
                            },
                            enteredPhoneNumber: (mobileNumber) {
                              bloc.mobileNumber = mobileNumber;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: ValueListenableBuilder<String>(
                                  valueListenable: bloc.errorMessage,
                                  builder: (context, snapshot, child) {
                                    return CustomText(
                                      title: snapshot,
                                      fontSize: 14,
                                      maxLins: 2,
                                      textAlign: TextAlign.center,
                                      textColor: Colors.red,
                                    );
                                  }),
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                              valueListenable: bloc.enableVerifyBtn,
                              builder: (context, snapshot, child) {
                                return CustomButton(
                                    buttonTitle:
                                        AppLocalizations.of(context)!.verify,
                                    enableButton: snapshot,
                                    onTap: () {
                                      bloc.callRequest(context: context);
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
