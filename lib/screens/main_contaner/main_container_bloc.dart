// import 'package:client_app/screens/main_contaner/widgets/tab_navigator.dart';
// import 'package:client_app/utils/routes.dart';
// import 'package:flutter/material.dart';

// enum SelectedTab { home, myPosts, add, messages, account }

// class MainContainerBloc {
//   final ValueNotifier<SelectedTab> currentTabIndexNotifier = ValueNotifier<SelectedTab>(SelectedTab.home);

//   List<TabNavigator> navTabs = const [
//     TabNavigator(initialRoute: RoutesConstants.homeScreen),
//     TabNavigator(initialRoute: RoutesConstants.categoriesScreen),
//     TabNavigator(initialRoute: RoutesConstants.calenderScreen),
//     TabNavigator(initialRoute: RoutesConstants.accountScreen)
//   ];

//   SelectedTab returnSelectedtypeDependOnIndex(int index) {
//     switch (index) {
//       case 0:
//         return SelectedTab.home;
//       case 1:
//         return SelectedTab.myPosts;
//       case 2:
//         return SelectedTab.add;
//       case 3:
//         return SelectedTab.messages;
//       default:
//         return SelectedTab.account;
//     }
//   }

//   int getSelectedIndexDependOnTab(SelectedTab tab) {
//     switch (tab) {
//       case SelectedTab.home:
//         return 0;
//       case SelectedTab.myPosts:
//         return 1;
//       case SelectedTab.add:
//         return 2;
//       case SelectedTab.messages:
//         return 3;
//       case SelectedTab.account:
//         return 4;
//       default:
//         return 0;
//     }
//   }
// }
