import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BookingCell extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onPress;

  const BookingCell(
      {required this.title,
      required this.isSelected,
      required this.onPress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () => onPress(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isSelected
                    ? const Color(0xff034061)
                    : const Color(0xffE4E9EF),
                width: 5),
            color: const Color(0xffE4E9EF),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: CustomText(
                title: title,
                textColor: const Color(0xff444444),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                fontSize: 14,
                maxLins: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
