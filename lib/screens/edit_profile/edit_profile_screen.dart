import 'package:client_app/screens/edit_profile/edit_profile_bloc.dart';
import 'package:client_app/screens/login/fourth_step/widgets/country_field.dart';
import 'package:client_app/screens/login/fourth_step/widgets/date_of_birth_field.dart';
import 'package:client_app/screens/login/fourth_step/widgets/gender_field.dart';
import 'package:client_app/screens/login/widget/image_holder.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final bloc = EditProfileBloc();

  @override
  void didChangeDependencies() {
    bloc.getAccountInformation(context);
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
      backgroundColor: const Color(0xffFAFAFA),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, loadingsnapshot, child) {
              if (loadingsnapshot != LoadingStatus.inprogress) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TopBarWidget(
                            actionButton: true,
                            actionButtonPressed: () {
                              final navigator = Navigator.of(context);
                              bloc.callRequest(context).then((value) async {
                                bloc.loadingStatus.value = LoadingStatus.finish;
                                if (value != null) {
                                  await bloc.box.put(
                                      DatabaseFieldConstant.userFirstName,
                                      bloc.firstNameController.text);

                                  if (bloc.selectedCountry != null) {
                                    await bloc.box.put(
                                        DatabaseFieldConstant.selectedCountryId,
                                        bloc.selectedCountry!.id.toString());
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
                                            .selectedCountryCode,
                                        bloc.selectedCountry!.countryCode);
                                    await bloc.box.put(
                                        DatabaseFieldConstant
                                            .selectedCurrencyCode,
                                        bloc.selectedCountry!.currencyCode);
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

                                  navigator.pop();
                                }
                              });
                            }),
                        const SizedBox(height: 8),
                        CustomText(
                          title: AppLocalizations.of(context)!.editprofile,
                          textAlign: TextAlign.start,
                          fontSize: 16,
                          textColor: const Color(0xff384048),
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            children: [
                              ImageHolderField(
                                  width: 120,
                                  hight: 150,
                                  isFromNetwork: bloc.profileImageUrl != "",
                                  urlImage: bloc.profileImageUrl == ""
                                      ? null
                                      : bloc.profileImageUrl,
                                  onAddImage: (file) {
                                    bloc.profileImage = file;
                                  },
                                  onDeleteImage: () {
                                    bloc.profileImage = null;
                                    bloc.profileImageUrl = "";
                                    setState(() {});
                                  }),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      controller: bloc.firstNameController,
                                      hintText: AppLocalizations.of(context)!
                                          .firstnameprofile,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(45),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      controller: bloc.lastNameController,
                                      hintText: AppLocalizations.of(context)!
                                          .lastnameprofile,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(45),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                CountryField(
                                  controller: bloc.countryController,
                                  listOfCountries: bloc.listOfCountries,
                                  selectedCountry: bloc.selectedCountry,
                                  selectedCountryCallBack: (country) {
                                    bloc.selectedCountry = country;
                                  },
                                ),
                                GenderField(controller: bloc.genderController),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: bloc.emailController,
                              hintText:
                                  AppLocalizations.of(context)!.emailprofile,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(35),
                              ],
                              onChange: (text) => {},
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      controller: bloc.mobileNumberController,
                                      enabled: false,
                                      hintText: AppLocalizations.of(context)!
                                          .mobilenumber,
                                      onChange: (text) => {},
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomTextField(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      controller: bloc.referalCodeController,
                                      hintText: AppLocalizations.of(context)!
                                          .referalcodeprofile,
                                      readOnly: true,
                                      enabled: false,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6)
                                      ],
                                      onChange: (text) => {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: CustomText(
                                title: AppLocalizations.of(context)!.dbprofile,
                                textAlign: TextAlign.start,
                                fontSize: 14,
                                textColor: const Color(0xff384048),
                              ),
                            ),
                            const SizedBox(height: 10),
                            DateOfBirthField(
                              savedLanguage:
                                  bloc.box.get(DatabaseFieldConstant.language),
                              selectedDate: bloc.selectedDate,
                              selectedDateCallBack: (date) {
                                bloc.selectedDate = date;
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
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
