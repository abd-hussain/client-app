import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';

class HeaderHomePage extends StatefulWidget {
  const HeaderHomePage({Key? key}) : super(key: key);

  @override
  State<HeaderHomePage> createState() => _HeaderHomePageState();
}

class _HeaderHomePageState extends State<HeaderHomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 8),
          const CustomText(
            title: "HelpEra",
            fontSize: 30,
            textColor: Color(0xff444444),
            fontWeight: FontWeight.bold,
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.notificationsScreen),
            icon: const Icon(
              Icons.notifications,
              color: Color(0xff034061),
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
