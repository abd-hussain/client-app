import 'package:client_app/locator.dart';
import 'package:client_app/main_context.dart';
import 'package:client_app/screens/no_internet_screen/widgets/no_internet_bottom_text.dart';
import 'package:client_app/screens/no_internet_screen/widgets/no_internet_main_logo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:client_app/sevices/general/network_info_service.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    locator<MainContext>().screenName = RoutesConstants.noInternetScreen;
    super.initState();
  }

  @override
  void dispose() {
    locator<MainContext>().screenName = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: null,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const MainLogo(),
              Expanded(child: Container()),
              const BottomText(),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50),
                child: CustomButton(
                    enableButton: true,
                    buttonTitle: AppLocalizations.of(context)!.retry,
                    onTap: () {
                      locator<NetworkInfoService>()
                          .checkConnectivityonLunching()
                          .then((value) {
                        if (value) {
                          Navigator.pushNamed(
                            context,
                            RoutesConstants.initialRoute,
                          );
                        }
                      });
                    }),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
