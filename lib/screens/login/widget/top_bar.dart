import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopBarWidget extends StatelessWidget {
  final String? subtitle;
  final bool actionButton;
  final Function()? actionButtonPressed;

  const TopBarWidget({this.subtitle, this.actionButton = false, this.actionButtonPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(child: Container()),
        Column(
          children: [
            const CustomText(
              title: "HelpEra",
              fontSize: 30,
              textColor: Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            subtitle != null
                ? CustomText(
                    title: subtitle!,
                    fontSize: 10,
                    textColor: const Color(0xff444444),
                    fontWeight: FontWeight.bold,
                  )
                : Container(),
          ],
        ),
        Expanded(child: Container()),
        actionButton
            ? TextButton(
                onPressed: () => actionButtonPressed!(),
                child: CustomText(
                  title: AppLocalizations.of(context)!.submit,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  textColor: const Color(0xff444444),
                ))
            : const SizedBox(width: 50)
      ],
    );
  }
}
