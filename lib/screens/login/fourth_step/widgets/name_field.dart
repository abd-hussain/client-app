import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const NameField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
    );
  }
}
