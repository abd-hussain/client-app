import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({required String title}) {
  return AppBar(
    backgroundColor: const Color(0xff034061),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          title: "HelpEra",
          fontSize: 30,
          textColor: Colors.white,
        ),
        CustomText(
          title: title,
          fontSize: 12,
          textColor: Colors.white,
        )
      ],
    ),
  );
}
