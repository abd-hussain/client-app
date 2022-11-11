import 'dart:async';

import 'package:client_app/screens/login/third_step/login_third_step_bloc.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/logger.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    startTimer();

    bloc.controller.addListener(() {
      if (bloc.controller.text.length == 6) {
        bloc.callVerifyRequset().then((value) {
          if (value.data != null) {
            bloc.otpNotValid.value = false;
            print(value.data!.token);
            Navigator.of(context, rootNavigator: true).pushNamed(
              RoutesConstants.loginFourthStepRoute,
              arguments: {AppConstant.tokenToPass: value.data!.token},
            );
          } else {
            bloc.otpNotValid.value = true;
          }
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    bloc.timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.extractArguments(context);

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
                  fontSize: 12,
                  textColor: Colors.black,
                ),
                CustomText(
                  title: AppLocalizations.of(context)!.enteryourotpnumberexample,
                  fontSize: 8,
                  textColor: Colors.grey,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: bloc.controller,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 0),
                      border: InputBorder.none,
                      counterText: "",
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      hintStyle: TextStyle(color: Colors.black54),
                      hintText: "Your OTP Code",
                    ),
                  ),
                ),
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
                const SizedBox(height: 50),
                bloc.timerStartNumberMin == 0 && bloc.timerStartNumberSec == 0
                    ? CustomButton(
                        buttonTitle: "Resend Code",
                        enableButton: true,
                        onTap: () async {
                          await bloc.callRequest().then((value) {
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
