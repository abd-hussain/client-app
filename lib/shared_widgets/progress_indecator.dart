import 'package:flutter/material.dart';

class ProgressIndecator extends StatelessWidget {
  final Color? progressColor;

  const ProgressIndecator({super.key, this.progressColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: progressColor ?? Colors.red),
    );
  }
}
