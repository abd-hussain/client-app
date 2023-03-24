import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/screens/home_tab/home_bloc.dart';
import 'package:client_app/screens/home_tab/widgets/event_header_view.dart';
import 'package:client_app/screens/home_tab/widgets/event_view.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/screens/home_tab/widgets/main_banner.dart';
import 'package:client_app/shared_widgets/admob_banner.dart';
import 'package:client_app/shared_widgets/booking/event_bottom_sheet.dart';
import 'package:client_app/utils/constants/database_constant.dart';
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
                    const AddMobBanner(),
                    const EventHeaderView(),
                    ValueListenableBuilder<List<MainEvent>?>(
                        valueListenable: _bloc.eventListNotifier,
                        builder: (context, snapshot, child) {
                          if (snapshot != null && snapshot.isNotEmpty) {
                            return EventView(
                              language: _bloc.box.get(DatabaseFieldConstant.language),
                              listOfEvents: snapshot,
                              onEventSelected: (event) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(RoutesConstants.eventDetailsScreen, arguments: {"event_details": event});
                              },
                              onOptionSelected: (event) {
                                EventOptionBookingBottomSheetsUtil(
                                        context: context, language: _bloc.box.get(DatabaseFieldConstant.language))
                                    .bookMeetingBottomSheet(report: () {
                                  _bloc.reportEvent(eventId: event.id!);
                                });
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                    const SizedBox(height: 20),
                    const AddMobBanner(),
                    const SizedBox(height: 20),
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
