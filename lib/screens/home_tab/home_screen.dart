import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/models/https/posts_response.dart';
import 'package:client_app/screens/home_tab/home_bloc.dart';
// import 'package:client_app/screens/home/widgets/categories.dart';
// import 'package:client_app/screens/home/widgets/favorite.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
// import 'package:client_app/screens/home/widgets/last_seen.dart';
import 'package:client_app/screens/home_tab/widgets/main_banner.dart';
import 'package:client_app/screens/home_tab/widgets/posts.dart';
import 'package:client_app/screens/home_tab/widgets/stories.dart';
import 'package:client_app/sevices/post_services.dart';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/utils/constants/database_constant.dart';
// import 'package:client_app/screens/home/widgets/top_rated.dart';
// import 'package:client_app/screens/home/widgets/tutorials_banner.dart';
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
    _bloc.getPosts();
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
                      ValueListenableBuilder<List<Banners>?>(
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
                      ValueListenableBuilder<List<Stories>?>(
                          valueListenable: _bloc.storiesListNotifier,
                          builder: (context, snapshot, child) {
                            if (snapshot != null && snapshot.isNotEmpty) {
                              return StoriesHomePage(listOfStories: snapshot);
                            } else {
                              return const SizedBox();
                            }
                          }),
                      const SizedBox(height: 8),
                      ValueListenableBuilder<List<PostsResponseData>?>(
                          valueListenable: _bloc.postsListNotifier,
                          builder: (context, snapshot, child) {
                            if (snapshot != null && snapshot.isNotEmpty) {
                              return PostsWidget(
                                listOfPosts: snapshot,
                                voteUp: (id) {
                                  _bloc.handleVote(postId: id, voteType: VoteType.up);
                                },
                                voteDown: (id) {
                                  _bloc.handleVote(postId: id, voteType: VoteType.down);
                                },
                                moreOption: (post) {
                                  _moreOptionView(context, post);
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
//                     const AddMobBanner(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: ElevatedButton(
            onPressed: () => _addPostView(context),
            child: const Icon(Icons.add),
          )),
    );
  }

  void _addPostView(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(RoutesConstants.addEditPostScreen)
        .then((value) => _bloc.getPosts());
  }

  void _moreOptionView(BuildContext context, PostsResponseData post) {
    BottomSheetsUtil().postMoreOptionButtomSheet(
      context: context,
      isItMine: post.ownerId! == (int.parse(_bloc.box.get(DatabaseFieldConstant.userid) ?? "0")),
      edit: () {
        Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.addEditPostScreen,
            arguments: {"content": post.content, "postId": post.id}).then((value) {
          _bloc.getPosts();
        });
      },
      delete: () {
        _bloc.deletePost(post.id!);
      },
      report: () {
        //TODO
      },
    );
  }
}
