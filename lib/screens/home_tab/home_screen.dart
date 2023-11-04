import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/screens/home_tab/home_bloc.dart';
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
          const AddMobBanner(),
          // ValueListenableBuilder<List<MainEvent>?>(
          //     valueListenable: _bloc.eventListNotifier,
          //     builder: (context, snapshot, child) {
          //       if (snapshot != null && snapshot.isNotEmpty) {
          //         return EventView(
          //           language: _bloc.box.get(DatabaseFieldConstant.language),
          //           listOfEvents: snapshot,
          //           onEventSelected: (event) {
          //             Navigator.of(context, rootNavigator: true)
          //                 .pushNamed(RoutesConstants.eventDetailsScreen, arguments: {"event_details": event});
          //           },
          //           onOptionSelected: (event) {
          //             EventOptionBookingBottomSheetsUtil(
          //                     context: context, language: _bloc.box.get(DatabaseFieldConstant.language))
          //                 .bookMeetingBottomSheet(report: () {
          //               if (_bloc.checkIfUserIsLoggedIn()) {
          //                 _bloc.reportEvent(eventId: event.id!);
          //               } else {
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     content: Text(AppLocalizations.of(context)!.youhavetobeloggedintodothat),
          //                   ),
          //                 );
          //               }
          //             });
          //           },
          //         );
          //       } else {
          //         return const SizedBox();
          //       }
          //     }),
          const SizedBox(height: 20),
          const AddMobBanner(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
