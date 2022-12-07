import 'package:client_app/locator.dart';
import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/models/https/posts_response.dart';
import 'package:client_app/sevices/home_services.dart';
import 'package:client_app/sevices/post_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeBloc extends Bloc<HomeService> {
  final ValueNotifier<List<Banners>?> bannerListNotifier = ValueNotifier<List<Banners>?>(null);
  final ValueNotifier<List<Stories>?> storiesListNotifier = ValueNotifier<List<Stories>?>(null);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  final ValueNotifier<List<PostsResponseData>?> postsListNotifier = ValueNotifier<List<PostsResponseData>?>(null);

  void getHome() {
    service.getHome().then((value) {
      if (value.data != null) {
        bannerListNotifier.value = value.data!.banners;
        storiesListNotifier.value = value.data!.stories;
      }
    });
  }

  void getPosts({String search = "", int limit = 10, int skip = 0}) {
    locator<PostService>().posts(search: search, limit: limit, skip: skip).then((value) {
      if (value.data != null) {
        postsListNotifier.value = [];
        var list = value.data!;
        postsListNotifier.value = list;
      }
    });
  }

  void deletePost(int postId) {
    locator<PostService>().deletePost(postId: postId).then((value) {
      if (value.data != null) {
        print("PostService Delete");
        postsListNotifier.value!.removeWhere((element) => element.id == postId);
      }
    });
  }

  void handleVote({required int postId, required VoteType voteType}) async {
    await locator<PostService>().handleVote(postId: postId, voteType: voteType).then((value) {
      var list = postsListNotifier.value ?? [];
      for (var item in list) {
        if (item.id == postId) {
          if (voteType == VoteType.up) {
            item.votes = item.votes! + 1;
          } else {
            item.votes = item.votes! - 1;
          }
        }
      }
      postsListNotifier.value = [];
      postsListNotifier.value = list;
    });
  }
}
