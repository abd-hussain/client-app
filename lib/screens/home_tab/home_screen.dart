import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/models/https/notifications_response.dart';
import 'package:client_app/screens/home_tab/home_bloc.dart';
import 'package:client_app/screens/home_tab/widgets/announcements_view.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/screens/home_tab/widgets/main_banner.dart';
import 'package:client_app/shared_widgets/admob_banner.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/loading_view.dart';
import 'package:client_app/shared_widgets/shimmers/shimmer_notifications.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  void didChangeDependencies() {
    logDebugMessage(message: 'Home init Called ...');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderHomePage(
            refreshCallBack: () {
              if (_bloc.checkIfUserIsLoggedIn()) {
                _bloc.listOfNotifications();
              }
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<MainBannerData>?>(
                    initialData: const [],
                    future: _bloc.getHome(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null && snapshot.hasData) {
                        return const SizedBox(
                            height: 250, child: LoadingView());
                      } else {
                        return MainBannerHomePage(
                            bannerList: snapshot.data ?? []);
                      }
                    }),
                const AddMobBanner(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: CustomText(
                    title: AppLocalizations.of(context)!.notifications,
                    fontSize: 18,
                    textColor: const Color(0xff444444),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _bloc.checkIfUserIsLoggedIn()
                    ? FutureBuilder<List<NotificationsResponseData>?>(
                        initialData: null,
                        future: _bloc.listOfNotifications(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const SizedBox(
                              height: 300,
                              child: ShimmerNotificationsView(),
                            );
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 600,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: snapshot.data!.isEmpty
                                      ? Center(
                                          child: CustomText(
                                            title: AppLocalizations.of(context)!
                                                .noitem,
                                            fontSize: 18,
                                            textColor: const Color(0xff444444),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : AnnouncementsView(
                                          notificationsList:
                                              snapshot.data ?? [],
                                        ),
                                ),
                              ),
                            );
                          }
                        })
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 600,
                        child: Center(
                          child: CustomText(
                            title: AppLocalizations.of(context)!.noitem,
                            fontSize: 16,
                            textColor: const Color(0xff444444),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
