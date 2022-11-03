import 'package:client_app/shared_widgets/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? readOnly;
  final EdgeInsetsGeometry padding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? sufixWidget;
  final Function(String text)? onChange;

  const CustomTextField(
      {required this.controller,
      required this.hintText,
      this.readOnly = false,
      this.keyboardType,
      this.inputFormatters,
      this.onChange,
      this.sufixWidget,
      this.padding = const EdgeInsets.only(left: 16, right: 16),
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Stack(
        children: [
          TextField(
            readOnly: readOnly!,
            inputFormatters: inputFormatters,
            enableSuggestions: false,
            keyboardType: keyboardType,
            autocorrect: false,
            controller: controller,
            style: CustomTextStyle().regular(color: const Color(0xff191C1F), size: 14),
            cursorColor: const Color(0xff100C31),
            decoration: InputDecoration(
              labelText: hintText,
              labelStyle: CustomTextStyle().regular(color: const Color(0xff384048), size: 14),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE8E8E8)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE8E8E8)),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE8E8E8)),
              ),
              filled: true,
              fillColor: const Color(0xffFFFFFF),
            ),
            onChanged: (text) {
              if (onChange != null) {
                onChange!(text);
              }
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: sufixWidget ?? Container(),
            ),
          )
        ],
      ),
    );
  }
}
