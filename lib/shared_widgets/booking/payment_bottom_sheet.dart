import 'dart:io';

import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PaymentType { apple, google, paypal }

class PaymentBottomSheetsUtil {
  Future paymentBottomSheet({
    required BuildContext context,
    required Function(PaymentType) onSelectionDone,
  }) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        enableDrag: true,
        useRootNavigator: true,
        backgroundColor: Colors.white,
        context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Wrap(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Expanded(child: SizedBox()),
                    CustomText(
                      title: AppLocalizations.of(context)!.pay,
                      textColor: const Color(0xff444444),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                mainiew(
                  context: context,
                  openNext: (type) {
                    Navigator.pop(context);
                    onSelectionDone(type);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget mainiew(
      {required BuildContext context,
      required Function(PaymentType) openNext}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffE8E8E8),
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Platform.isAndroid
                      ? rowItem(
                          context: context,
                          containerColor: const Color(0xffE74C4C),
                          title: AppLocalizations.of(context)!.googlepay,
                          desc:
                              "${AppLocalizations.of(context)!.paymentuse} ${AppLocalizations.of(context)!.googlepay}",
                          icon: Icons.payment,
                          onPress: () => openNext(PaymentType.google),
                        )
                      : rowItem(
                          context: context,
                          containerColor: const Color(0xffE8E8E8),
                          title: AppLocalizations.of(context)!.applypay,
                          desc:
                              "${AppLocalizations.of(context)!.paymentuse} ${AppLocalizations.of(context)!.applypay}",
                          icon: Icons.apple,
                          onPress: () => openNext(PaymentType.apple),
                        ),
                  const SizedBox(height: 8),
                  Container(height: 1, color: const Color(0xffE8E8E8)),
                  const SizedBox(height: 8),
                  rowItem(
                    context: context,
                    containerColor: const Color(0xffE8E8E8),
                    title: AppLocalizations.of(context)!.paypal,
                    desc:
                        "${AppLocalizations.of(context)!.paymentuse} ${AppLocalizations.of(context)!.paypal}",
                    icon: Icons.paypal,
                    onPress: () => openNext(PaymentType.paypal),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget rowItem(
      {required BuildContext context,
      required Color containerColor,
      required IconData icon,
      required String title,
      required String desc,
      required Function onPress}) {
    return InkWell(
      onTap: () => onPress(),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: containerColor,
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 16,
                textColor: const Color(0xff554d56),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                title: desc,
                fontSize: 12,
                textColor: const Color(0xffA2A3A4),
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          const Icon(Icons.arrow_right_outlined)
        ],
      ),
    );
  }
}
