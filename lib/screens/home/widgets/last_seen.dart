// import 'package:client_app/shared_widgets/custom_text.dart';
// import 'package:flutter/material.dart';

// class LastSeenItemsHomePage extends StatelessWidget {
//   final List<String> listOfSeenItems;
//   const LastSeenItemsHomePage({required this.listOfSeenItems, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(16),
//           child: CustomText(
//             title: "last Seen Items",
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             textColor: Color(0xff444444),
//           ),
//         ),
//         Row(
//           children: [
//             categoryIcon(listOfSeenItems[0]),
//             categoryIcon(listOfSeenItems[1]),
//             categoryIcon(listOfSeenItems[2]),
//           ],
//         ),
//         Row(
//           children: [
//             categoryIcon(listOfSeenItems[3]),
//             categoryIcon(listOfSeenItems[4]),
//             categoryIcon(listOfSeenItems[5]),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget categoryIcon(String title) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
//         child: Column(
//           children: [
//             Container(
//               height: 50,
//               width: 50,
//               padding: const EdgeInsets.all(1),
//               decoration: BoxDecoration(color: const Color(0xff444444), borderRadius: BorderRadius.circular(25)),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(25),
//                 child: SizedBox.fromSize(
//                   child: Image.network(
//                       'https://github.com/hampusborgos/country-flags/blob/main/png1000px/jo.png?raw=true',
//                       fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//             CustomText(
//               title: title,
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               textColor: const Color(0xff444444),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
