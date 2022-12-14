import 'package:client_app/screens/edit_profile/edit_profile_bloc.dart';
import 'package:client_app/screens/login/widget/image_holder.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

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
                            subtitle: AppLocalizations.of(context)!.editprofile,
                            actionButton: true,
                            actionButtonPressed: () {
                              final navigator = Navigator.of(context);
                              bloc.callRequest(context).then((value) async {
                                bloc.loadingStatus.value = LoadingStatus.finish;
                                if (value) {
                                  navigator.pop();
                                }
                              });
                            }),
                        const SizedBox(height: 20),
                        Center(
                          child: ImageHolder(
                              width: 120,
                              hight: 120,
                              isFromNetwork: bloc.profileImageUrl != null,
                              urlImage: bloc.profileImageUrl == "" ? null : bloc.profileImageUrl,
                              addImageCallBack: (file) {
                                bloc.profileImage = file;
                              },
                              deleteImageCallBack: () {
                                bloc.profileImage = null;
                                bloc.profileImageUrl = null;
                              }),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
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
                              const SizedBox(height: 10),
                              _genderField(),
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
                              _dateBirthField(),
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
                            ],
                          ),
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

  Widget _genderField() {
    return Stack(
      children: [
        CustomTextField(
          controller: bloc.genderController,
          readOnly: true,
          hintText: AppLocalizations.of(context)!.gender,
          padding: const EdgeInsets.only(left: 16, right: 16),
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
          child: const Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Center(
              child: SizedBox(
                height: 55,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateBirthField() {
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
