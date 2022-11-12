// import 'package:client_app/shared_widgets/custom_text.dart';
// import 'package:flutter/material.dart';

// class CategoriesHomePage extends StatelessWidget {
//   final List<String> listOfCategories;
//   const CategoriesHomePage({required this.listOfCategories, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             categoryIcon(listOfCategories[0]),
//             categoryIcon(listOfCategories[1]),
//             categoryIcon(listOfCategories[2]),
//             categoryIcon(listOfCategories[3]),
//           ],
//         ),
//         Row(
//           children: [
//             categoryIcon(listOfCategories[4]),
//             categoryIcon(listOfCategories[5]),
//             categoryIcon(listOfCategories[6]),
//             categoryIcon(listOfCategories[7]),
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
