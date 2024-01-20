import 'package:client_app/screens/login/fourth_step/login_fourth_step_bloc.dart';
import 'package:client_app/screens/login/fourth_step/widgets/country_field.dart';
import 'package:client_app/screens/login/fourth_step/widgets/date_of_birth_field.dart';
import 'package:client_app/screens/login/fourth_step/widgets/gender_field.dart';
import 'package:client_app/screens/login/fourth_step/widgets/name_field.dart';
import 'package:client_app/screens/login/widget/image_holder.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginFourthStepScreen extends StatefulWidget {
  const LoginFourthStepScreen({super.key});

  @override
  State<LoginFourthStepScreen> createState() => _LoginFourthStepScreenState();
}

class _LoginFourthStepScreenState extends State<LoginFourthStepScreen> {
  final bloc = LoginFourthStepBloc();

  @override
  void didChangeDependencies() {
    bloc.extractArguments(context);

    bloc.controllersHandler();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String savedLanguage = bloc.box.get(DatabaseFieldConstant.language);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFields();
        },
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, loadingsnapshot, child) {
              if (loadingsnapshot == LoadingStatus.finish) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const TopBarWidget(backButton: false),
                        const SizedBox(height: 20),
                        Image.asset("assets/images/login_4.png"),
                        const SizedBox(height: 20),
                        Padding(
                          padding: savedLanguage == "ar"
                              ? const EdgeInsets.only(right: 16)
                              : const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              ImageHolder(
                                  isFromNetwork: bloc.profileImageUrl != null,
                                  urlImage: bloc.profileImageUrl == ""
                                      ? null
                                      : bloc.profileImageUrl,
                                  addImageCallBack: (file) {
                                    bloc.profileImage = file;
                                    bloc.validateFields();
                                  },
                                  deleteImageCallBack: () {
                                    bloc.profileImage = null;
                                    bloc.profileImageUrl = null;
                                    bloc.validateFields();
                                  }),
                              Expanded(
                                child: Column(
                                  children: [
                                    NameField(
                                      controller: bloc.firstNameController,
                                      hintText: AppLocalizations.of(context)!
                                          .firstnameprofile,
                                    ),
                                    const SizedBox(height: 10),
                                    NameField(
                                      controller: bloc.lastNameController,
                                      hintText: AppLocalizations.of(context)!
                                          .lastnameprofile,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: [
                              CountryField(
                                controller: bloc.countryController,
                                listOfCountries: bloc.listOfCountries,
                                selectedCountry: bloc.selectedCountry,
                              ),
                              GenderField(controller: bloc.genderController),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: CustomText(
                            title: AppLocalizations.of(context)!.dbprofile,
                            textAlign: TextAlign.start,
                            fontSize: 14,
                            textColor: const Color(0xff384048),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DateOfBirthField(
                          savedLanguage: savedLanguage,
                          selectedDate: bloc.selectedDate,
                          selectedDateCallBack: (date) {
                            bloc.selectedDate = date;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: bloc.emailController,
                          hintText: AppLocalizations.of(context)!.emailprofile,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(35),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<bool>(
                            valueListenable: bloc.enableReferalCode,
                            builder: (context, snapshot, child) {
                              return CustomTextField(
                                controller: bloc.referalCodeController,
                                readOnly: !snapshot,
                                enabled: snapshot,
                                hintText: AppLocalizations.of(context)!
                                    .referalcodeprofile,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                onChange: (text) => {},
                              );
                            }),
                        const SizedBox(height: 20),
                        ValueListenableBuilder<bool>(
                            valueListenable: bloc.enableNextBtn,
                            builder: (context, snapshot, child) {
                              return CustomButton(
                                  buttonTitle:
                                      AppLocalizations.of(context)!.submit,
                                  enableButton: snapshot,
                                  onTap: () {
                                    final navigator = Navigator.of(context);

                                    bloc
                                        .callRequest(context)
                                        .then((value) async {
                                      await bloc.box.put(
                                          DatabaseFieldConstant.isUserLoggedIn,
                                          true);
                                      await bloc.box.put(
                                          DatabaseFieldConstant.userFirstName,
                                          bloc.firstNameController.text);
                                      await bloc.box.put(
                                          DatabaseFieldConstant.userid,
                                          bloc.userId.toString());
                                      if (bloc.selectedCountry != null) {
                                        await bloc.box.put(
                                            DatabaseFieldConstant
                                                .selectedCountryId,
                                            bloc.selectedCountry!.id
                                                .toString());
                                        await bloc.box.put(
                                            DatabaseFieldConstant
                                                .selectedCountryFlag,
                                            bloc.selectedCountry!.flagImage);
                                        await bloc.box.put(
                                            DatabaseFieldConstant
                                                .selectedCountryName,
                                            bloc.selectedCountry!.name);
                                        await bloc.box.put(
                                            DatabaseFieldConstant
                                                .selectedCountryDialCode,
                                            bloc.selectedCountry!.dialCode);
                                        await bloc.box.put(
                                            DatabaseFieldConstant
                                                .selectedCountryCurrency,
                                            bloc.selectedCountry!.currency);
                                        await bloc.box.put(
                                            DatabaseFieldConstant
                                                .selectedCountryMinLenght,
                                            bloc.selectedCountry!.minLength
                                                .toString());
                                        await bloc.box.put(
                                            DatabaseFieldConstant
                                                .selectedCountryMaxLenght,
                                            bloc.selectedCountry!.maxLength
                                                .toString());
                                      }
                                      bloc.loadingStatus.value =
                                          LoadingStatus.finish;

                                      await navigator.pushNamedAndRemoveUntil(
                                          RoutesConstants.mainContainer,
                                          (route) => false);
                                    });
                                  });
                            }),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
