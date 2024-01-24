import 'package:client_app/shared_widgets/grid_view/item_in_gred.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BillDetailsView extends StatelessWidget {
  final String? currency;
  final double? meetingCostAmount;
  final double? totalAmount;
  final double? discountPercent;

  const BillDetailsView(
      {super.key,
      required this.currency,
      required this.meetingCostAmount,
      required this.totalAmount,
      required this.discountPercent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 8,
          childAspectRatio: 3.2,
        ),
        children: [
          ItemInGrid(
            title: AppLocalizations.of(context)!.meetingcost,
            value: currency != null ? "$meetingCostAmount $currency" : null,
          ),
          ItemInGrid(
            title: AppLocalizations.of(context)!.discount,
            value: "$discountPercent %",
          ),
          ItemInGrid(
            title: AppLocalizations.of(context)!.servicefee,
            value: currency != null ? "0.0 $currency" : null,
          ),
          ItemInGrid(
            title: AppLocalizations.of(context)!.totalamount,
            value: currency != null ? "$totalAmount $currency" : null,
          ),
        ],
      ),
    );
  }
}
