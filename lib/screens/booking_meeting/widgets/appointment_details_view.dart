import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsView extends StatelessWidget {
  final String title;
  final String desc;
  final Color descColor;
  final bool forceView;
  final EdgeInsetsGeometry padding;

  const AppointmentDetailsView({
    required this.title,
    required this.desc,
    this.forceView = false,
    super.key,
    this.descColor = const Color(0xff554d56),
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: "$title :",
            fontSize: 14,
            textColor: const Color(0xff554d56),
          ),
          SizedBox(
            width: 200,
            child: forceView
                ? Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomText(
                      title: desc,
                      fontSize: 14,
                      maxLins: 4,
                      textAlign: TextAlign.end,
                      fontWeight: FontWeight.bold,
                      textColor: descColor,
                    ),
                  )
                : CustomText(
                    title: desc,
                    fontSize: 14,
                    textAlign: TextAlign.end,
                    fontWeight: FontWeight.bold,
                    maxLins: 4,
                    textColor: descColor,
                  ),
          ),
        ],
      ),
    );
  }
}
