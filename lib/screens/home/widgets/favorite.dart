// import 'package:client_app/shared_widgets/custom_text.dart';
// import 'package:flutter/material.dart';

// class FavoriteHomePage extends StatelessWidget {
//   final List<String> listOfFavorite;
//   const FavoriteHomePage({required this.listOfFavorite, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(16),
//           child: CustomText(
//             title: "List Of Favorite Items",
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             textColor: Color(0xff444444),
//           ),
//         ),
//         Row(
//           children: [
//             categoryIcon(listOfFavorite[0]),
//             categoryIcon(listOfFavorite[1]),
//             categoryIcon(listOfFavorite[2]),
//           ],
//         ),
//         Row(
//           children: [
//             categoryIcon(listOfFavorite[3]),
//             categoryIcon(listOfFavorite[4]),
//             categoryIcon(listOfFavorite[5]),
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
