import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget mainAppBar({required BuildContext context, required bool isUserLoggedIn}) {
  return AppBar(
    backgroundColor: const Color(0xff034061),
    title: Row(
      children: [
        const CustomText(
          title: "HelpEra",
          fontSize: 30,
          textColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        Expanded(child: Container()),
        isUserLoggedIn
            ? IconButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.notificationsScreen),
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 30,
                ),
              )
            : Container(),
      ],
    ),
  );
}
