import 'package:flutter/material.dart';

PreferredSizeWidget accountAppBar({required BuildContext context}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(0),
    child: AppBar(
      backgroundColor: const Color(0xff034061),
      elevation: 0,
    ),
  );
}
