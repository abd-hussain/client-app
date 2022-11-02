import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.black,
          ),
        ),
        Expanded(child: Container()),
        const CustomText(
          title: "HelpEra",
          fontSize: 30,
          textColor: Color(0xff444444),
          fontWeight: FontWeight.bold,
        ),
        Expanded(child: Container()),
        const SizedBox(width: 50)
      ],
    );
  }
}
