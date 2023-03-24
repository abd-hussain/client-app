import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TimingEventView extends StatelessWidget {
  final String text1;
  final String text2;
  const TimingEventView({required this.text1, required this.text2, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: text1,
            fontSize: 14,
            textAlign: TextAlign.center,
            textColor: const Color(0xff444444),
          ),
          CustomText(
            title: text2,
            fontSize: 14,
            textAlign: TextAlign.center,
            textColor: const Color(0xff444444),
          ),
        ],
      ),
    );
  }
}
