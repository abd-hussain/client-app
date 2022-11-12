import 'package:client_app/screens/home_tab/home_bloc.dart';
// import 'package:client_app/screens/home/widgets/categories.dart';
// import 'package:client_app/screens/home/widgets/favorite.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
// import 'package:client_app/screens/home/widgets/last_seen.dart';
// import 'package:client_app/screens/home/widgets/main_banner.dart';
import 'package:client_app/screens/home_tab/widgets/search_section.dart';
// import 'package:client_app/screens/home/widgets/top_rated.dart';
// import 'package:client_app/screens/home/widgets/tutorials_banner.dart';
// import 'package:client_app/shared_widgets/admob_banner.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeBloc();

  @override
  void initState() {
    logDebugMessage(message: 'Home init Called ...');

    super.initState();
  }

  //TODO: Handle Home Page
  //TODO: Handle Search Page

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            const HeaderHomePage(),
            const SearchHomePage(),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
//                     const MainBannerHomePage(),
//                     const SizedBox(height: 8),
//                     CategoriesHomePage(listOfCategories: _bloc.listOfCategories),
//                     const TutorialsBannerHomePage(),
//                     FavoriteHomePage(listOfFavorite: _bloc.listFavoriteItems),
//                     const SizedBox(height: 8),
//                     const AddMobBanner(),
//                     LastSeenItemsHomePage(listOfSeenItems: _bloc.listFavoriteItems),
//                     const AddMobBanner(),
//                     TopRatedItemsHomePage(listOftopRatedItems: _bloc.listFavoriteItems),
//                     const AddMobBanner(),
//                     const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
