import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/routes.dart';
import 'package:flutter/material.dart';

class EventMentorView extends StatelessWidget {
  final int mentorId;
  final String mentorProfileImage;
  final String mentorSuffixeName;
  final String mentorFirstName;
  final String mentorLastName;
  final String mentorCategoryName;

  const EventMentorView(
      {required this.mentorId,
      required this.mentorProfileImage,
      required this.mentorSuffixeName,
      required this.mentorFirstName,
      required this.mentorLastName,
      required this.mentorCategoryName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(RoutesConstants.mentorProfileScreen, arguments: {"id": mentorId});
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xff034061),
                  radius: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: mentorProfileImage != ""
                        ? FadeInImage(
                            placeholder: const AssetImage("assets/images/avatar.jpeg"),
                            image: NetworkImage(AppConstant.imagesBaseURLForMentors + mentorProfileImage, scale: 1),
                          )
                        : Image.asset(
                            'assets/images/avatar.jpeg',
                            width: 40,
                            height: 40,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: CustomText(
                        title: "$mentorSuffixeName $mentorFirstName $mentorLastName",
                        fontSize: 14,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        maxLins: 3,
                        textColor: const Color(0xff554d56),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomText(
                      title: mentorCategoryName,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: const Color(0xff554d56),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
