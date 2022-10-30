import 'package:client_app/locator.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String firstName;

  const ProfileHeader({this.firstName = "Anonymous", Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: const Color(0xff034061),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(locator<DayTime>().gettheCorrentImageDependOnCurrentTime(), width: 32, height: 32),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: "Hello $firstName",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    title: firstName == "Anonymous" ? "Start Now and Login" : "Welcome Back",
                    fontSize: 12,
                    textOverflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.notificationsScreen),
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
