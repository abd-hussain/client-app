// import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
// import 'package:client_app/shared_widgets/custom_button.dart';
// import 'package:client_app/shared_widgets/custom_text.dart';
// import 'package:client_app/shared_widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class DiscountView extends StatelessWidget {
//   final BookingBloc bloc;
//   const DiscountView({required this.bloc, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Column(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.6,
//               height: 50,
//               child: CustomTextField(
//                 controller: bloc.discountController,
//                 fontSize: 25,
//                 hintText: AppLocalizations.of(context)!.discountcode,
//                 inputFormatters: [
//                   LengthLimitingTextInputFormatter(6),
//                 ],
//                 suffixWidget: IconButton(
//                   icon: const Icon(
//                     Icons.close,
//                     size: 20,
//                   ),
//                   onPressed: () {
//                     bloc.discountController.text = "";
//                   },
//                 ),
//               ),
//             ),
//             ValueListenableBuilder<String?>(
//                 valueListenable: bloc.discountErrorMessage,
//                 builder: (context, snapshot, child) {
//                   return snapshot != null
//                       ? Padding(
//                           padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
//                           child: CustomText(
//                             title: snapshot == "error" ? AppLocalizations.of(context)!.notvaliddiscountcode : "",
//                             fontSize: 14,
//                             textColor: Colors.red,
//                           ),
//                         )
//                       : const SizedBox();
//                 }),
//           ],
//         ),
//         Expanded(child: Container()),
//         ValueListenableBuilder<bool>(
//             valueListenable: bloc.applyDiscountButton,
//             builder: (context, snapshot, child) {
//               return CustomButton(
//                 enableButton: snapshot,
//                 width: MediaQuery.of(context).size.width * 0.2,
//                 buttonTitle: AppLocalizations.of(context)!.apply,
//                 onTap: () async {
//                   FocusScope.of(context).unfocus();
//                   // bloc.verifyCode();
//                 },
//               );
//             }),
//       ],
//     );
//   }
// }
