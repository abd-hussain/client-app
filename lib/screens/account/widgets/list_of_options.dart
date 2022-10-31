import 'package:client_app/shared_widgets/admob_banner.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/models/profile_options.dart';
import 'package:client_app/utils/routes.dart';
import 'package:client_app/utils/version.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListOfOptions extends StatelessWidget {
  final List<ProfileOptions> listOfSettingsOptions;
  final List<ProfileOptions> listOfReachOutUsOptions;
  final List<ProfileOptions> listOfSupportOptions;
  final List<ProfileOptions> listOfAccountOptions;
  bool isItLoggedIn;

  ListOfOptions(
      {required this.listOfSettingsOptions,
      required this.listOfReachOutUsOptions,
      required this.listOfSupportOptions,
      required this.listOfAccountOptions,
      required this.isItLoggedIn,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    isItLoggedIn = false;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddMobBanner(),
            titleOptionCollection(title: "Account"),
            optionCollectionItem(listOfAccountOptions, containerHight: 123, onTap: (value) {}),
            isItLoggedIn ? const SizedBox(height: 16) : Container(),
            isItLoggedIn ? logoutView() : Container(),
            titleOptionCollection(title: "Settings"),
            optionCollectionItem(listOfSettingsOptions, containerHight: 330, onTap: (value) {}),
            titleOptionCollection(title: "Reach out to us"),
            optionCollectionItem(listOfReachOutUsOptions, containerHight: 123, onTap: (value) {}),
            titleOptionCollection(title: "Support APP."),
            optionCollectionItem(listOfSupportOptions,
                containerHight: 123,
                onTap: (value) =>
                    value == AccountButtonType.aboutUs ? openAboutUs(context) : openInviteFriends(context)),
            const SizedBox(height: 8),
            const AddMobBanner(),
            footerView(context),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget logoutView() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
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
      child: InkWell(
        onTap: () {
          //TODO
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.logout,
                size: 20,
                color: Color(0xff034061),
              ),
              const SizedBox(width: 8),
              const CustomText(
                  title: "Logout", fontSize: 16, textColor: Color(0xff034061), fontWeight: FontWeight.w500),
              Expanded(child: Container()),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 12,
                color: Color(0xffBFBFBF),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget titleOptionCollection({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
      child: CustomText(
        title: title,
        fontSize: 14,
        textColor: const Color(0xff444444),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void openAboutUs(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
      AppConstant.webViewPageUrl: AppConstant.aboutusLink,
      AppConstant.pageTitle: AppLocalizations.of(context)!.aboutus
    });
  }

  void openInviteFriends(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.inviteFriendScreen);
  }

  Widget optionCollectionItem(List<ProfileOptions> listOfOptions,
      {required Function(AccountButtonType) onTap, required double containerHight}) {
    final ValueNotifier<bool> switchStatusNotifier = ValueNotifier<bool>(false);

    return Container(
      height: containerHight,
      decoration: BoxDecoration(
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
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listOfOptions.length,
          separatorBuilder: (BuildContext context, int index) => const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Divider(),
              ),
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () => onTap(listOfOptions[index].buttonType),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      listOfOptions[index].icon,
                      size: 20,
                      color: const Color(0xff034061),
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                        title: listOfOptions[index].name,
                        fontSize: 16,
                        textColor: const Color(0xff034061),
                        fontWeight: FontWeight.w500),
                    Expanded(child: Container()),
                    CustomText(
                      title: listOfOptions[index].selectedItem,
                      fontSize: 14,
                      textColor: const Color(0xffFFA200),
                    ),
                    const SizedBox(width: 8),
                    listOfOptions[index].switchIcn
                        ? SizedBox(
                            height: 20,
                            child: ValueListenableBuilder<bool>(
                                valueListenable: switchStatusNotifier,
                                builder: (context, data, child) {
                                  return CupertinoSwitch(
                                    activeColor: const Color(0xff4CB6EA),
                                    value: switchStatusNotifier.value,
                                    //TODO
                                    onChanged: (value) => switchStatusNotifier.value = value,
                                  );
                                }),
                          )
                        : const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 12,
                            color: Color(0xffBFBFBF),
                          )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget footerView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                //TODO: Fix facebook URL
                onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen,
                    arguments: {
                      AppConstant.webViewPageUrl: "https://www.facebook.com/",
                      AppConstant.pageTitle: "Facebook"
                    }),
                child: const Icon(
                  Icons.facebook,
                  color: Color(0xff444444),
                ),
              ),
              const CustomText(
                title: "|",
                fontSize: 16,
                textColor: Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
              TextButton(
                onPressed: () => _launchWhatsapp(context),
                child: const Icon(
                  Icons.whatsapp,
                  color: Color(0xff444444),
                ),
              ),
              const CustomText(
                title: "|",
                fontSize: 16,
                textColor: Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
              TextButton(
                //TODO: Fix Linkedin URL
                onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen,
                    arguments: {
                      AppConstant.webViewPageUrl: "https://www.linkedin.com/",
                      AppConstant.pageTitle: "LinkedIn"
                    }),
                child: Image.asset(
                  "assets/images/linkedinLogo.png",
                ),
              ),
            ],
          ),
          TextButton(
            //TODO: Fix Privacy Policy URL
            onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen,
                arguments: {
                  AppConstant.webViewPageUrl: "https://www.talabat.com/jordan/privacy",
                  AppConstant.pageTitle: "Policy"
                }),
            child: _footerTextWidget("Privacy Policy"),
          ),
          TextButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                RateMyApp().showRateDialog(context);
              });
            },
            child: _footerTextWidget("Rate Application"),
          ),
          TextButton(
            //TODO: Fix Terms Conditions URL
            onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen,
                arguments: {
                  AppConstant.webViewPageUrl: "https://www.talabat.com/jordan/privacy",
                  AppConstant.pageTitle: "Terms And Conditions"
                }),
            child: _footerTextWidget("Terms And Conditions"),
          ),
          const SizedBox(height: 16),
          FutureBuilder<String>(
              initialData: "",
              future: Version().getApplicationVersion(),
              builder: (context, snapshot) {
                return CustomText(
                  title: "Version ${snapshot.data}",
                  fontSize: 12,
                  textColor: const Color(0xffBFBFBF),
                );
              }),
          const SizedBox(height: 20),
          const CustomText(
            title: "@ 2022 HelpEra.app. All rights reserved.",
            fontSize: 10,
            textColor: Color(0xff707070),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _footerTextWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: title,
          fontSize: 10,
          textColor: const Color(0xff444444),
        ),
        const Icon(
          Icons.arrow_forward_rounded,
          size: 10,
          color: Color(0xff444444),
        )
      ],
    );
  }

  void _launchWhatsapp(BuildContext context) async {
    //TODO: Fix Whatsapp Number Policy URL
    var whatsapp = "+962795190663";
    var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }
}
