import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/permission.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

class CallReadyView extends StatelessWidget {
  final String channelId;
  final int appointmentId;
  final int meetingDurationInMin;
  final Function callEnd;

  const CallReadyView(
      {super.key,
      required this.channelId,
      required this.appointmentId,
      required this.callEnd,
      required this.meetingDurationInMin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Lottie.network(
            "https://assets8.lottiefiles.com/packages/lf20_WZQ5gTEaXA.json",
            height: 200),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            title: AppLocalizations.of(context)!.waitingyoutojoin,
            fontSize: 20,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            title: AppLocalizations.of(context)!.waitingyoutojoindesc,
            fontSize: 14,
            maxLins: 2,
            textAlign: TextAlign.center,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 0.1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      padding: const EdgeInsets.all(8),
                      buttonTitle: AppLocalizations.of(context)!.joinnow,
                      enableButton: true,
                      onTap: () async {
                        PermissionHandler()
                            .handlePermission(Permission.camera)
                            .whenComplete(() {
                          PermissionHandler()
                              .handlePermission(Permission.microphone)
                              .whenComplete(() {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(RoutesConstants.insideCallScreen,
                                    arguments: {
                                  "channelName": channelId,
                                  "callID": appointmentId,
                                  "durations": meetingDurationInMin,
                                }).then((value) {
                              callEnd();
                            });
                          });
                        });
                      }),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
