import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EventInfoBox extends StatelessWidget {
  final String title;
  final String desc;
  const EventInfoBox({required this.title, required this.desc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 0.3,
              offset: const Offset(0, 0.1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: title,
              fontSize: 14,
              textColor: const Color(0xff554d56),
            ),
            CustomText(
              title: desc,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff554d56),
            ),
          ],
        ),
      ),
    );
  }
}
