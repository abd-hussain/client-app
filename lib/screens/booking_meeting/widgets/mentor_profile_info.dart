import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';

class MentorProfileInfoView extends StatelessWidget {
  final String profileImg;
  final String suffixeName;
  final String firstName;
  final String lastName;

  const MentorProfileInfoView({
    required this.profileImg,
    required this.suffixeName,
    required this.firstName,
    required this.lastName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: const Color(0xff034061),
              radius: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: profileImg != ""
                    ? FadeInImage(
                        placeholder:
                            const AssetImage("assets/images/avatar.jpeg"),
                        image: NetworkImage(
                            AppConstant.imagesBaseURLForMentors + profileImg,
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
            title: "$suffixeName $firstName $lastName",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textColor: const Color(0xff554d56),
          ),
        ],
      ),
    );
  }
}
