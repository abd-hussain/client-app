import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinField extends StatelessWidget {
  final TextEditingController pinController;
  const PinField({super.key, required this.pinController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        maxLength: 6,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: pinController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 0),
          border: InputBorder.none,
          counterText: "",
          floatingLabelAlignment: FloatingLabelAlignment.center,
          hintStyle: TextStyle(color: Colors.black54),
          hintText: "Your OTP Code",
        ),
      ),
    );
  }
}
