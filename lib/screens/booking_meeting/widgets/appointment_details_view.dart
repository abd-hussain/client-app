import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsView extends StatelessWidget {
  final String title;
  final String desc;
  final bool forceView;

  const AppointmentDetailsView({required this.title, required this.desc, this.forceView = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                      fontWeight: FontWeight.bold,
                      maxLins: 10,
                      textColor: const Color(0xff554d56),
                    ),
                  )
                : CustomText(
                    title: desc,
                    fontSize: 14,
                    maxLins: 10,
                    fontWeight: FontWeight.bold,
                    textColor: const Color(0xff554d56),
                  ),
          ),
        ],
      ),
    );
  }
}
