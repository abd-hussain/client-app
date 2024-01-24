import 'package:client_app/models/https/mentor_info_avaliable_model.dart';
import 'package:client_app/screens/booking_meeting/widgets/sub_widgets/serching_for_mentor.dart';
import 'package:flutter/material.dart';

class InstanceBookingView extends StatelessWidget {
  final String? categoryName;
  final ValueNotifier<List<MentorInfoAvaliableResponseData>?> avaliableMentors;
  const InstanceBookingView(
      {super.key, required this.avaliableMentors, required this.categoryName});
  //TODO: Handle this Two View
  @override
  Widget build(BuildContext context) {
    return const SearchForMentorView();
  }
}

// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: CustomText(
//     title: "-- ${AppLocalizations.of(context)!.selectmentor} --",
//     fontSize: 16,
//     textColor: const Color(0xff554d56),
//   ),
// ),
// ValueListenableBuilder<List<MentorInfoAvaliableResponseData>?>(
//     valueListenable: bloc.avaliableMentors,
//     builder: (context, snapshot, child) {
//       if (snapshot == null) {
//         return const SearchForMentorView();
//       } else {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             height: 190,
//             child: ListView.builder(
//                 itemCount: snapshot.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (ctx, index) {
//                   return SizedBox(
//                     width: MediaQuery.of(context).size.width - 100,
//                     child: FoundedMentorInfoView(
//                       data: snapshot[index],
//                       onPress: () {},
//                     ),
//                   );
//                 }),
//           ),
//         );
//       }
//     }),
