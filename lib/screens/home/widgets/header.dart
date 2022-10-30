// import 'package:client_app/shared_widgets/custom_text.dart';
// import 'package:client_app/utils/constants/database_constant.dart';
// import 'package:client_app/utils/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class HeaderHomePage extends StatefulWidget {
//   const HeaderHomePage({Key? key}) : super(key: key);

//   @override
//   State<HeaderHomePage> createState() => _HeaderHomePageState();
// }

// class _HeaderHomePageState extends State<HeaderHomePage> {
//   String countryFlag = "";
//   @override
//   void initState() {
//     Hive.openBox(DatabaseBoxConstant.userInfo).then((value) {
//       countryFlag = value.get(DatabaseFieldConstant.countryFlag);
//       setState(() {});
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           const CustomText(
//             title: "Logo",
//             fontSize: 30,
//             textColor: Color(0xff444444),
//             fontWeight: FontWeight.bold,
//           ),
//           Expanded(child: Container()),
//           InkWell(
//               onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.changeCountryScreen),
//               child: Container(
//                 width: 40,
//                 height: 20,
//                 padding: const EdgeInsets.all(1),
//                 decoration: BoxDecoration(color: const Color(0xff444444), borderRadius: BorderRadius.circular(10)),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: SizedBox.fromSize(
//                     size: const Size.fromRadius(50),
//                     child: countryFlag != "" ? Image.network(countryFlag, fit: BoxFit.cover) : Container(),
//                   ),
//                 ),
//               )),
//           const SizedBox(width: 8),
//           IconButton(
//             onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.notificationsScreen),
//             icon: const Icon(
//               Icons.notification_add_outlined,
//               color: Color(0xff034061),
//               size: 30,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
