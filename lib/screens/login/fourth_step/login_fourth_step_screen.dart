import 'package:client_app/screens/login/fourth_step/login_fourth_step_bloc.dart';
import 'package:client_app/screens/login/widget/gender_view.dart';
import 'package:client_app/screens/login/widget/image_holder.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginFourthStepScreen extends StatelessWidget {
  const LoginFourthStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = LoginFourthStepBloc();
    bloc.extractArguments(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: SingleChildScrollView(
          child: FutureBuilder(
              future: Hive.openBox(DatabaseBoxConstant.userInfo),
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  final String savedLanguage = snapshot.data!.get(DatabaseFieldConstant.language);
                  return Column(
                    children: [
                      const TopBarWidget(),
                      const SizedBox(height: 20),
                      Image.asset("assets/images/login_4.png"),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                          children: [
                            ImageHolder(addImageCallBack: (file) {
                              bloc.profileImage = file;
                            }, deleteImageCallBack: () {
                              bloc.profileImage = null;
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
                                    onChange: (text) => {},
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    controller: bloc.lastNameController,
                                    hintText: AppLocalizations.of(context)!.lastnameprofile,
                                    keyboardType: TextInputType.name,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(45),
                                    ],
                                    onChange: (text) => {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: bloc.countryController,
                              hintText: AppLocalizations.of(context)!.countryprofile,
                              padding: const EdgeInsets.only(left: 8, right: 16),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(45),
                              ],
                              onChange: (text) => {},
                            ),
                          ),
                          Expanded(
                            child: ValueListenableBuilder<String>(
                                valueListenable: bloc.genderValue,
                                builder: (context, snapshot, child) {
                                  return CustomTextField(
                                    sufixWidget: GenderView(
                                        selectedGenderValue: snapshot,
                                        selectedGender: (type) {
                                          bloc.genderController.text = " ";
                                          bloc.genderValue.value = type;
                                        }),
                                    controller: bloc.genderController,
                                    readOnly: true,
                                    hintText: bloc.genderController.text.isNotEmpty
                                        ? AppLocalizations.of(context)!.gender
                                        : "",
                                    padding: const EdgeInsets.only(left: 16, right: 8),
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(45),
                                    ],
                                    onChange: (text) => {},
                                  );
                                }),
                          ),
                        ],
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
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: DatePickerWidget(
                          looping: true,
                          firstDate: DateTime(1945, 01, 01),
                          lastDate: DateTime(DateTime.now().year - 10, 1, 1),
                          initialDate: DateTime(1992, 05, 22),
                          dateFormat: "dd-MMM-yyyy",
                          locale: DatePicker.localeFromString(savedLanguage),
                          onChange: (DateTime newDate, _) {
                            bloc.dateOfbirth = newDate;
                          },
                          pickerTheme: const DateTimePickerTheme(
                            itemTextStyle: TextStyle(color: Color(0xff384048), fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: bloc.emailController,
                        hintText: AppLocalizations.of(context)!.emailprofile,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(45),
                        ],
                        onChange: (text) => {},
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: bloc.referalCodeController,
                        hintText: AppLocalizations.of(context)!.referalcodeprofile,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(45),
                        ],
                        onChange: (text) => {},
                      ),
                      const SizedBox(height: 40),
                      ValueListenableBuilder<bool>(
                          valueListenable: bloc.enableNextBtn,
                          builder: (context, snapshot, child) {
                            return CustomButton(
                                buttonTitle: AppLocalizations.of(context)!.submit,
                                enableButton: snapshot,
                                onTap: () {
                                  bloc.callRequest().then((value) {
                                    //   logger.wtf("value.data!.lastOtp");
                                    //   logger.wtf(value.data!.lastOtp);
                                    //   if (bloc.controller.text[0] == "0") {
                                    //     bloc.controller.text = bloc.controller.text.substring(1);
                                    //   }
                                    //   Navigator.of(context, rootNavigator: true)
                                    //       .pushNamed(RoutesConstants.loginThirdStepRoute, arguments: {
                                    //     AppConstant.countryCode: bloc.countryCode,
                                    //     AppConstant.mobileNumber: bloc.controller.text,
                                    //     AppConstant.userid: value.data!.id!,
                                    //     AppConstant.apikey: value.data!.apiKey!
                                    //   });
                                  });
                                });
                          }),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator(color: Colors.red);
                }
              }),
        )),
      ),
    );
  }
}
