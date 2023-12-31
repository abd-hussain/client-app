import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PointsInLastViewBooking extends StatelessWidget {
  final String number;
  final String text;

  const PointsInLastViewBooking(
      {required this.number, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffE4E9EF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomText(
            title: number,
            textColor: const Color(0xff444444),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomText(
            title: text,
            textColor: const Color(0xff444444),
            fontSize: 14,
            maxLins: 3,
          ),
        ),
      ],
    );
  }
}
