import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/screens/home_tab/home_bloc.dart';
import 'package:client_app/screens/home_tab/widgets/list_notification_widget.dart';
import 'package:client_app/screens/home_tab/widgets/main_banner.dart';
import 'package:client_app/shared_widgets/admob_banner.dart';

import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Home init Called ...');
    _bloc.getHome();
    if (_bloc.checkIfUserIsLoggedIn()) {
      _bloc.markNotificationReaded();
      _bloc.listOfNotifications();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          ValueListenableBuilder<List<MainBanner>?>(
              valueListenable: _bloc.bannerListNotifier,
              builder: (context, snapshot, child) {
                if (snapshot != null && snapshot.isNotEmpty) {
                  return MainBannerHomePage(
                    bannerList: snapshot,
                    onPress: (link) async {
                      if (link != null) {
                        await launchUrl(Uri.parse(link));
                      }
                    },
                  );
                } else {
                  return const SizedBox();
                }
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height - 400,
            child: NotificationsList(
              notificationsListNotifier: _bloc.notificationsListNotifier,
              isUserIsLoggedIn: _bloc.checkIfUserIsLoggedIn(),
              onDelete: (p0) {
                _bloc.notificationsListNotifier.value!.remove(p0);
                _bloc.deleteNotification(p0.id!);
              },
            ),
          ),
          const AddMobBanner(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
