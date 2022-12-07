import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/screens/home_tab/home_bloc.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/screens/home_tab/widgets/main_banner.dart';
import 'package:client_app/screens/home_tab/widgets/stories.dart';
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
                    // ValueListenableBuilder<List<PostsResponseData>?>(
                    //     valueListenable: _bloc.postsListNotifier,
                    //     builder: (context, snapshot, child) {
                    //       if (snapshot != null && snapshot.isNotEmpty) {
                    //         return PostsWidget(
                    //           listOfPosts: snapshot,
                    //           voteUp: (id) {
                    //             _bloc.handleVote(postId: id, voteType: VoteType.up);
                    //           },
                    //           voteDown: (id) {
                    //             _bloc.handleVote(postId: id, voteType: VoteType.down);
                    //           },
                    //           moreOption: (post) {
                    //             _moreOptionView(context, post);
                    //           },
                    //         );
                    //       } else {
                    //         return const SizedBox();
                    //       }
                    //     }),
//                     const AddMobBanner(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _moreOptionView(BuildContext context, PostsResponseData post) {
  //   BottomSheetsUtil().postMoreOptionButtomSheet(
  //     context: context,
  //     isItMine: post.ownerId! == (int.parse(_bloc.box.get(DatabaseFieldConstant.userid) ?? "0")),
  //     edit: () {
  //       Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.addEditPostScreen,
  //           arguments: {"content": post.content, "postId": post.id}).then((value) {
  //         _bloc.getPosts();
  //       });
  //     },
  //     delete: () {
  //       _bloc.deletePost(post.id!);
  //     },
  //     report: () {
  //       //TODO
  //     },
  //   );
  // }
}
