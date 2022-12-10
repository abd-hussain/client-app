import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/screens/home_tab/home_bloc.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/screens/home_tab/widgets/main_banner.dart';
import 'package:client_app/screens/home_tab/widgets/stories.dart';
import 'package:client_app/screens/home_tab/widgets/tips_view.dart';
import 'package:client_app/shared_widgets/admob_banner.dart';
// import 'package:client_app/shared_widgets/admob_banner.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/routes.dart';
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
    _bloc.getHome();
    // _bloc.getPosts();
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
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ValueListenableBuilder<List<MainBanner>?>(
                        valueListenable: _bloc.bannerListNotifier,
                        builder: (context, snapshot, child) {
                          if (snapshot != null && snapshot.isNotEmpty) {
                            return MainBannerHomePage(
                              bannerList: snapshot,
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                    const SizedBox(height: 8),
                    ValueListenableBuilder<List<MainStory>?>(
                        valueListenable: _bloc.storiesListNotifier,
                        builder: (context, snapshot, child) {
                          if (snapshot != null && snapshot.isNotEmpty) {
                            return StoriesHomePage(
                              listOfStories: snapshot,
                              reportStory: (id) {
                                _bloc.reportStory(storyId: id);
                              },
                              openMentorProfile: (id) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(RoutesConstants.mentorProfileScreen, arguments: {"id": id});
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                    const SizedBox(height: 8),
                    const AddMobBanner(),
                    TipsView()
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
