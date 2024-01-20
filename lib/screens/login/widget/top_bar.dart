import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopBarWidget extends StatelessWidget {
  final bool actionButton;
  final bool backButton;

  final Function()? actionButtonPressed;

  const TopBarWidget(
      {this.backButton = true,
      this.actionButton = false,
      this.actionButtonPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        backButton
            ? IconButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.black,
                ),
              )
            : const SizedBox(width: 50),
        const SizedBox(
          width: 14,
        ),
        Expanded(child: Container()),
        Image.asset(
          "assets/images/logo.png",
          width: 100,
        ),
        Expanded(child: Container()),
        actionButton
            ? TextButton(
                onPressed: () => actionButtonPressed!(),
                child: CustomText(
                  title: AppLocalizations.of(context)!.submit,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textColor: const Color(0xff444444),
                ),
              )
            : const SizedBox(width: 50)
      ],
    );
  }
}
