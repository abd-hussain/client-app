import 'package:client_app/screens/login/widget/image_holder.dart';
import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:client_app/screens/mentor_profile/mentor_profile_bloc.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/custom_textfield.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MentorProfileScreen extends StatefulWidget {
  const MentorProfileScreen({super.key});

  @override
  State<MentorProfileScreen> createState() => _MentorProfileScreenState();
}

class _MentorProfileScreenState extends State<MentorProfileScreen> {
  final bloc = MentorProfileBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(arguments: ModalRoute.of(context)!.settings.arguments);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  //TODO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatus,
          builder: (context, loadingsnapshot, child) {
            if (loadingsnapshot != LoadingStatus.inprogress) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TopBarWidget(),
                      const SizedBox(height: 20),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff034061),
                          radius: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: bloc.profileImageUrl != ""
                                ? FadeInImage(
                                    placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                    image: NetworkImage(AppConstant.imagesBaseURLForMentors + bloc.profileImageUrl!,
                                        scale: 1),
                                  )
                                : Image.asset(
                                    'assets/images/avatar.jpeg',
                                    width: 110.0,
                                    height: 110.0,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        title: "${bloc.suffixeName!} ${bloc.firstName!} ${bloc.lastName!}",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textColor: const Color(0xff554d56),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: "${AppLocalizations.of(context)!.specialist} :",
                            fontSize: 12,
                            textColor: const Color(0xff554d56),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CustomText(
                            title: bloc.categoryName!.toString(),
                            fontSize: 12,
                            textColor: const Color(0xff554d56),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              );
            }
          }),
    );
  }
}
