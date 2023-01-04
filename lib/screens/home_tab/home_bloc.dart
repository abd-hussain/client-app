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
  final ValueNotifier<List<MainEvent>?> eventListNotifier = ValueNotifier<List<MainEvent>?>(null);

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void getHome() {
    service.getHome().then((value) {
      if (value.data != null) {
        bannerListNotifier.value = value.data!.mainBanner;
        storiesListNotifier.value = value.data!.mainStory;
        tipsListNotifier.value = value.data!.mainTips;
        eventListNotifier.value = value.data!.mainEvent;
      }
    });
  }

  void reportStory({required int storyId}) {
    service.reportStory(storyId: storyId).then((value) {
      storiesListNotifier.value = value.data!;
    });
  }

  void reportEvent({required int eventId}) {
    service.reportEvent(eventId: eventId).then((value) {
      eventListNotifier.value = value.data!;
    });
  }

  @override
  onDispose() {
    bannerListNotifier.dispose();
    storiesListNotifier.dispose();
    tipsListNotifier.dispose();
  }
}
