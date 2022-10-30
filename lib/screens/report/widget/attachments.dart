import 'package:flutter/material.dart';

class ReportAttatchment extends StatelessWidget {
  const ReportAttatchment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Image.asset("assets/images/attach_placeholder.png")),
        Expanded(child: Image.asset("assets/images/attach_placeholder.png")),
        Expanded(child: Image.asset("assets/images/attach_placeholder.png")),
        Expanded(child: Container())
      ],
    );
  }
}
