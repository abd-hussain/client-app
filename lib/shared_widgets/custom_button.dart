import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final bool enableButton;
  final Function() onTap;
  const CustomButton({this.buttonTitle = "Submit", required this.enableButton, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(enableButton ? const Color(0xff4CB6EA) : const Color(0xffB1B1B1))),
        onPressed: () => enableButton ? onTap() : null,
        child: SizedBox(
          height: 45,
          child: Center(
            child: Text(buttonTitle),
          ),
        ),
      ),
    );
  }
}
