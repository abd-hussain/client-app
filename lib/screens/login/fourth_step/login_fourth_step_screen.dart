import 'package:client_app/screens/login/fourth_step/login_fourth_step_bloc.dart';
import 'package:client_app/screens/login/widget/image_holder.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

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
              if (loadingsnapshot != LoadingStatus.inprogress) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const TopBarWidget(),
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
                                  urlImage: bloc.profileImageUrl == "" ? null : bloc.profileImageUrl,
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
                                    CustomTextField(
                                      controller: bloc.firstNameController,
                                      hintText: AppLocalizations.of(context)!.firstnameprofile,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(45),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextField(
                                      controller: bloc.lastNameController,
                                      hintText: AppLocalizations.of(context)!.lastnameprofile,
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: [
                              countryField(context),
                              genderField(),
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
                        dateBirthField(),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: bloc.emailController,
                          hintText: AppLocalizations.of(context)!.emailprofile,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(35),
                          ],
                          onChange: (text) => {},
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<bool>(
                            valueListenable: bloc.enableReferalCode,
                            builder: (context, snapshot, child) {
                              return CustomTextField(
                                controller: bloc.referalCodeController,
                                readOnly: !snapshot,
                                enabled: snapshot,
                                hintText: AppLocalizations.of(context)!.referalcodeprofile,
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
                                  buttonTitle: AppLocalizations.of(context)!.submit,
                                  enableButton: snapshot,
                                  onTap: () {
                                    final navigator = Navigator.of(context);

                                    bloc.callRequest(context).then((value) async {
                                      await bloc.box.put(DatabaseFieldConstant.isUserLoggedIn, true);
                                      await bloc.box
                                          .put(DatabaseFieldConstant.userFirstName, bloc.firstNameController.text);
                                      await bloc.box.put(DatabaseFieldConstant.userid, bloc.userId.toString());
                                      if (bloc.selectedCountry != null) {
                                        await bloc.box
                                            .put(DatabaseFieldConstant.countryId, bloc.selectedCountry!.id.toString());
                                        await bloc.box
                                            .put(DatabaseFieldConstant.countryFlag, bloc.selectedCountry!.flagImage);
                                      }
                                      bloc.loadingStatus.value = LoadingStatus.finish;

                                      await navigator.pushNamedAndRemoveUntil(
                                          RoutesConstants.mainContainer, (route) => false);
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

  Widget genderField() {
    return Expanded(
        child: Stack(
      children: [
        CustomTextField(
          controller: bloc.genderController,
          readOnly: true,
          hintText: AppLocalizations.of(context)!.gender,
          padding: const EdgeInsets.only(left: 16, right: 8),
          keyboardType: TextInputType.text,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
          onChange: (text) => {},
        ),
        InkWell(
          onTap: () async {
            await BottomSheetsUtil().genderBottomSheet(context, bloc.listOfGenders, (selectedGender) {
              bloc.genderController.text = selectedGender.name;
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
    ));
  }

  Widget countryField(context) {
    return Expanded(
      child: Stack(
        children: [
          CustomTextField(
            readOnly: true,
            controller: bloc.countryController,
            hintText: AppLocalizations.of(context)!.countryprofile,
            padding: const EdgeInsets.only(left: 8, right: 16),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(45),
            ],
          ),
          InkWell(
            onTap: () async {
              await BottomSheetsUtil().countryBottomSheet(context, bloc.listOfCountries, (selectedCountry) {
                bloc.countryController.text = selectedCountry.name!;
                bloc.selectedCountry = selectedCountry;
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

  Widget dateBirthField() {
    final String savedLanguage = bloc.box.get(DatabaseFieldConstant.language);

    late DateTime date;
    if (bloc.selectedDate != null) {
      date = DateFormat('dd-MMM-yyyy').parse(bloc.selectedDate!);
    } else {
      date = DateTime(1992, 05, 22);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: DatePickerWidget(
        firstDate: DateTime(1945, 01, 01),
        lastDate: DateTime(DateTime.now().year - 10, 1, 1),
        initialDate: date,
        dateFormat: "dd-MMM-yyyy",
        locale: DatePicker.localeFromString(savedLanguage),
        onChange: (DateTime newDate, _) {
          bloc.selectedDate = DateFormat("dd-MMM-yyyy").format(newDate);
        },
        pickerTheme: const DateTimePickerTheme(
          itemTextStyle: TextStyle(color: Color(0xff384048), fontSize: 15),
        ),
      ),
    );
  }
}
