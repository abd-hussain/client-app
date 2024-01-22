import 'package:flutter/material.dart';

class InstanceBookingView extends StatelessWidget {
  const InstanceBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
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
