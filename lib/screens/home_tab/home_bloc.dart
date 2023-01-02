import 'package:client_app/models/https/event.dart';
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
  final ValueNotifier<List<Event>?> eventListNotifier = ValueNotifier<List<Event>?>(null);

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void getHome() {
    service.getHome().then((value) {
      if (value.data != null) {
        bannerListNotifier.value = value.data!.mainBanner;
        storiesListNotifier.value = value.data!.mainStory;
        tipsListNotifier.value = value.data!.mainTips;
        eventListNotifier.value = [
          Event(
            image:
                "https://www1.chester.ac.uk/sites/default/files/styles/hero/public/Events%20Management%20festival%20image.jpg?itok=eJ3k-5R6",
            eventDate: "2023/05/22",
            eventDay: "Saturday",
            fromHour: "12:00 am",
            duration: "1 Hour",
            eventName: "1 Event name Event name Event name Event name Event name",
            intrestedcount: 5,
            intrestedTotalcount: 20,
            price: 0,
          ),
          Event(
            image:
                "https://www1.chester.ac.uk/sites/default/files/styles/hero/public/Events%20Management%20festival%20image.jpg?itok=eJ3k-5R6",
            eventDate: "2023/11/12",
            eventDay: "Monday",
            fromHour: "1:00 am",
            duration: "40 min",
            eventName: "2 Event name Event name Event name Event name Event name",
            intrestedcount: 2,
            intrestedTotalcount: 10,
            price: 5.1,
          ),
        ];
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
  }
}
