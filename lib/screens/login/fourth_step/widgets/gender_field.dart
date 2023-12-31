import 'package:client_app/models/gender_model.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderField extends StatefulWidget {
  final TextEditingController controller;
  const GenderField({super.key, required this.controller});

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  List<Gender> listOfGenders = [];

  @override
  void didChangeDependencies() {
    listOfGenders = [
      Gender(
          name: AppLocalizations.of(context)!.gendermale,
          icon: const Icon(
            Icons.male,
            color: Color(0xff444444),
          )),
      Gender(
          name: AppLocalizations.of(context)!.genderfemale,
          icon: const Icon(Icons.female)),
      Gender(
          name: AppLocalizations.of(context)!.genderother,
          icon: const Icon(Icons.align_horizontal_center))
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [
        CustomTextField(
          controller: widget.controller,
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
            await BottomSheetsUtil().genderBottomSheet(context, listOfGenders,
                (selectedGender) {
              widget.controller.text = selectedGender.name;
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
}
