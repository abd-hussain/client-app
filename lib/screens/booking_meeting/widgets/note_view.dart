// import 'package:client_app/screens/booking_meeting/booking_bloc.dart';
// import 'package:client_app/shared_widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class NoteView extends StatelessWidget {
//   final BookingBloc bloc;

//   const NoteView({required this.bloc, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: 100,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 8, bottom: 8),
//         child: CustomTextField(
//           controller: bloc.noteController,
//           fontSize: 16,
//           maxLine: 3,
//           hintText: AppLocalizations.of(context)!.note,
//           suffixWidget: IconButton(
//             icon: const Icon(
//               Icons.close,
//               size: 20,
//             ),
//             onPressed: () {
//               FocusScope.of(context).unfocus();

//               bloc.noteController.text = "";
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
