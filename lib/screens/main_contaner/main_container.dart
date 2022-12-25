import 'package:client_app/locator.dart';
import 'package:client_app/screens/main_contaner/main_container_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);
  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final _bloc = locator<MainContainerBloc>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F7),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: ValueListenableBuilder<SelectedTab>(
              valueListenable: _bloc.currentTabIndexNotifier,
              builder: (context, data, child) {
                return IndexedStack(
                  index: _bloc.getSelectedIndexDependOnTab(data),
                  children: _bloc.navTabs,
                );
              })),
      bottomNavigationBar: ConvexAppBar(
        key: _bloc.appBarKey,
        backgroundColor: Colors.white,
        activeColor: const Color(0xff4CB6EA),
        color: const Color(0xff444444),
        cornerRadius: 8,
        height: 50,
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.home, title: AppLocalizations.of(context)!.containerHomeIconTitle),
          TabItem(icon: Icons.category_rounded, title: AppLocalizations.of(context)!.containerCategoriesIconTitle),
          const TabItem(icon: Icons.call),
          TabItem(icon: Icons.calendar_month, title: AppLocalizations.of(context)!.containerCalenderIconTitle),
          TabItem(icon: Icons.person, title: AppLocalizations.of(context)!.containerAccountIconTitle),
        ],
        initialActiveIndex: 0,
        onTap: (int index) => _bloc.currentTabIndexNotifier.value = _bloc.returnSelectedtypeDependOnIndex(index),
      ),
    );
  }
}
