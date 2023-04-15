import 'dart:async';

import 'package:client_app/screens/login/third_step/login_third_step_bloc.dart';
import 'package:client_app/screens/login/third_step/widgets/pin_field.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginThirdStepScreen extends StatefulWidget {
  const LoginThirdStepScreen({super.key});

  @override
  State<LoginThirdStepScreen> createState() => _LoginThirdStepScreenState();
}

class _LoginThirdStepScreenState extends State<LoginThirdStepScreen> {
  final bloc = LoginThirdStepBloc();

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    bloc.timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (bloc.timerStartNumberMin == 0 && bloc.timerStartNumberSec == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            if (bloc.timerStartNumberSec > 0) {
              bloc.timerStartNumberSec = bloc.timerStartNumberSec - 1;
            } else {
              bloc.timerStartNumberMin = bloc.timerStartNumberMin - 1;
              bloc.timerStartNumberSec = 59;
            }
          });
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    startTimer();
    bloc.pinController.addListener(() {
      if (bloc.pinController.text.length == 6) {
        bloc.callVerifyRequset().then((value) async {
          if (value.data != null) {
            bloc.otpNotValid.value = false;
            await Navigator.of(context, rootNavigator: true).pushNamed(
              RoutesConstants.loginFourthStepRoute,
              arguments: {
                AppConstant.tokenToPass: value.data!.token,
                AppConstant.useridToPass: bloc.userId,
              },
            );
          } else {
            bloc.otpNotValid.value = true;
          }
        });
      }
    });
    bloc.extractArguments(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopBarWidget(),
                const SizedBox(height: 20),
                Image.asset("assets/images/login_3.png"),
                const SizedBox(height: 20),
                CustomText(
                  title: AppLocalizations.of(context)!.enteryourotpnumber,
                  fontSize: 16,
                  textColor: Colors.black,
                ),
                CustomText(
                  title: AppLocalizations.of(context)!.enteryourotpnumberexample,
                  fontSize: 11,
                  textColor: Colors.grey,
                ),
                const SizedBox(height: 20),
                PinField(pinController: bloc.pinController),
                const SizedBox(height: 10),
                ValueListenableBuilder<bool>(
                    valueListenable: bloc.otpNotValid,
                    builder: (context, snapshot, child) {
                      return snapshot
                          ? const CustomText(
                              title: "OTP Is Not Valid",
                              fontSize: 20,
                              textColor: Colors.red,
                            )
                          : Container();
                    }),
                const SizedBox(height: 20),
                bloc.timerStartNumberMin == 0 && bloc.timerStartNumberSec == 0
                    ? CustomButton(
                        buttonTitle: "Resend Code",
                        enableButton: true,
                        onTap: () async {
                          await bloc.callRequestOfAuthAgain().then((value) {
                            bloc.resetTimer();
                            startTimer();
                            logger.wtf("value.data!.lastOtp");
                            logger.wtf(value.data!.lastOtp);
                            setState(() {});
                          });
                        })
                    : CustomText(
                        title: bloc.timerStartNumberSec > 9
                            ? "0${bloc.timerStartNumberMin}:${bloc.timerStartNumberSec}"
                            : "0${bloc.timerStartNumberMin}:0${bloc.timerStartNumberSec}",
                        fontSize: 18,
                        textColor: bloc.timerStartNumberMin == 0 && bloc.timerStartNumberSec <= 10
                            ? Colors.red
                            : const Color(0xff4CB6EA),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
