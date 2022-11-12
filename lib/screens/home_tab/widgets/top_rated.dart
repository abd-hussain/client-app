// import 'package:client_app/shared_widgets/custom_text.dart';
// import 'package:flutter/material.dart';

// class TopRatedItemsHomePage extends StatelessWidget {
//   final List<String> listOftopRatedItems;
//   const TopRatedItemsHomePage({required this.listOftopRatedItems, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(16),
//           child: CustomText(
//             title: "Top Rated Items",
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             textColor: Color(0xff444444),
//           ),
//         ),
//         Row(
//           children: [
//             categoryIcon(listOftopRatedItems[0]),
//             categoryIcon(listOftopRatedItems[1]),
//             categoryIcon(listOftopRatedItems[2]),
//           ],
//         ),
//         Row(
//           children: [
//             categoryIcon(listOftopRatedItems[3]),
//             categoryIcon(listOftopRatedItems[4]),
//             categoryIcon(listOftopRatedItems[5]),
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
