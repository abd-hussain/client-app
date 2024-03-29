import 'package:client_app/locator.dart';
import 'package:client_app/main_context.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:client_app/utils/constants/database_constant.dart';

BuildContext? buildContext;

class MyApp extends StatefulWidget {
  final bool isConnected;

  const MyApp({
    super.key,
    required this.isConnected,
  });

  static MyAppState? of(BuildContext context) {
    buildContext = context;
    return context.findAncestorStateOfType<MyAppState>();
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Box myBox = Hive.box(DatabaseBoxConstant.userInfo);
  bool firstInitialization = true;

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    locator<MainContext>().setMainContext(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) {
        return AppConstant.appName;
      },
      locale: myBox.get(DatabaseFieldConstant.language) != null
          ? Locale(myBox.get(DatabaseFieldConstant.language))
          : const Locale("en"),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            settings: RouteSettings(arguments: settings.arguments),
            transitionDuration: const Duration(milliseconds: 100),
            pageBuilder: (_, __, ___) => routes[settings.name]!);
      },
      initialRoute: widget.isConnected
          ? myBox.get(DatabaseFieldConstant.selectedCountryId) != null
              ? RoutesConstants.mainContainer
              : RoutesConstants.initialRoute
          : RoutesConstants.noInternetScreen,
    );
  }
}
