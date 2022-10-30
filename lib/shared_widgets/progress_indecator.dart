import 'package:flutter/material.dart';

class ProgressIndecator extends StatelessWidget {
  final Color progressColor;

  // ignore: use_key_in_widget_constructors
  const ProgressIndecator({this.progressColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: progressColor),
    );
  }
}
