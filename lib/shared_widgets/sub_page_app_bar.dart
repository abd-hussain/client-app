import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SubPageHeaderName extends StatelessWidget {
  final String title;
  const SubPageHeaderName({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: CustomText(
          title: title,
          fontSize: 16,
          textColor: const Color(0xff444444),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
