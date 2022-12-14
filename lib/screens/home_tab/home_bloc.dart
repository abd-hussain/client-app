import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/sevices/home_services.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeBloc extends Bloc<HomeService> {
  final ValueNotifier<List<MainBanner>?> bannerListNotifier = ValueNotifier<List<MainBanner>?>(null);
  final ValueNotifier<List<MainStory>?> storiesListNotifier = ValueNotifier<List<MainStory>?>(null);
  final ValueNotifier<List<MainTips>?> tipsListNotifier = ValueNotifier<List<MainTips>?>(null);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void getHome() {
    service.getHome().then((value) {
      if (value.data != null) {
        bannerListNotifier.value = value.data!.mainBanner;
        storiesListNotifier.value = value.data!.mainStory;
        tipsListNotifier.value = value.data!.mainTips;
      }
    });
  }

  void reportStory({required int storyId}) async {
    await service.reportStory(storyId: storyId);
  }

  @override
  onDispose() {
    bannerListNotifier.dispose();
    storiesListNotifier.dispose();
    tipsListNotifier.dispose();

    throw UnimplementedError();
  }
}
