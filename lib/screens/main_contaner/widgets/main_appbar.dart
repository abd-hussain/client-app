import 'package:client_app/locator.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';

import 'package:flutter/material.dart';

PreferredSizeWidget mainAppBar(
    {required BuildContext context, required bool isUserLoggedIn, required bool isItCalenderTab}) {
  return AppBar(
    backgroundColor: Colors.white,
    shape: const CircleBorder(),
    elevation: 2.0,
    title: Row(
      children: [
        Expanded(child: Container()),
        Image.asset(
          "assets/images/logo.png",
          width: 100,
        ),
        Expanded(child: Container()),
        isItCalenderTab && isUserLoggedIn
            ? IconButton(
                onPressed: () {
                  locator<MainContainerBloc>().getAppointments();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
              )
            : Container(),
      ],
    ),
  );
}
