import 'package:client_app/shared_widgets/mentor_info_view.dart';
import 'package:flutter/material.dart';

class ScheduleBookingView extends StatelessWidget {
  final String? profileImg;
  final String? flagImage;
  final String? suffixName;
  final String? firstName;
  final String? lastName;
  final String? categoryName;
  final String? gender;

  const ScheduleBookingView(
      {super.key,
      required this.profileImg,
      required this.flagImage,
      required this.suffixName,
      required this.firstName,
      required this.lastName,
      required this.categoryName,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MentorInfoView(
        profileImg: profileImg,
        flagImage: flagImage,
        gender: gender,
        firstName: firstName,
        lastName: lastName,
        suffixName: suffixName,
        category: categoryName,
      ),
    );
  }
}
