import 'package:client_app/locator.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget mainAppBar(
    {required BuildContext context, required bool isUserLoggedIn, required bool isItCalenderTab}) {
  return AppBar(
    backgroundColor: const Color(0xff034061),
    title: Row(
      children: [
        const CustomText(
          title: AppConstant.appName,
          fontSize: 30,
          textColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        Expanded(child: Container()),
        isItCalenderTab && isUserLoggedIn
            ? IconButton(
                onPressed: () {
                  locator<MainContainerBloc>().getAppointmentsAndEvents();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
              )
            : Container(),
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
