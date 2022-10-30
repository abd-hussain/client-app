// import 'package:client_app/screens/report/report_bloc.dart';
// import 'package:client_app/screens/report/widget/attachments.dart';
// import 'package:client_app/screens/report/widget/footer.dart';
// import 'package:client_app/shared_widgets/custom_appbar.dart';
// import 'package:client_app/shared_widgets/custom_button.dart';
// import 'package:client_app/shared_widgets/sub_page_app_bar.dart';
// import 'package:flutter/material.dart';

// enum ReportPageType { issue, suggestion }

// class ReportScreen extends StatelessWidget {
//   final ReportPageType pageType;
//   ReportScreen({required this.pageType, Key? key}) : super(key: key);

//   final _bloc = ReportBloc();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: customAppBar(),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SubPageHeaderName(title: pageType == ReportPageType.issue ? "Report an Problem" : "Report an Suggestion"),
//             Expanded(
//                 child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: _bloc.textController,
//                     decoration: const InputDecoration(
//                       hintText: "Your feedback is important to us, Please describe your bug issue here",
//                       hintMaxLines: 2,
//                       hintStyle: TextStyle(fontSize: 15),
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                     ),
//                     maxLines: 20,
//                     maxLength: 500,
//                   ),
//                 ),
//               ),
//             )),
//             const ReportAttatchment(),
//             CustomButton(
//               enableButton: _bloc.validationFields(),
//               onTap: () {},
//             ),
//             const ReportFooterView(),
//             const SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );
//   }
// }
