import 'package:client_app/models/https/mentor_details_model.dart';
import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/gender_format.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class MentorProfileBloc extends Bloc<MentorService> {
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  String? profileImageUrl;
  String? firstName;
  String? lastName;
  String? suffixeName;
  String? bio;
  String? categoryName;
  double? hourRate;
  String? speakingLanguage;
  String? gender;
  int? genderIndex;
  String? countryName;
  String? countryFlag;
  String? dateOfBirth;
  List<MultiSelectCard<String>> majors = [];
  List<Reviews> reviews = [];
  double totalRate = 0;
  List<int>? workingHoursSaturday;
  List<int>? workingHoursSunday;
  List<int>? workingHoursMonday;
  List<int>? workingHoursTuesday;
  List<int>? workingHoursWednesday;
  List<int>? workingHoursThursday;
  List<int>? workingHoursFriday;

  void handleReadingArguments(BuildContext context, {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      int mentorId = newArguments["id"] as int;
      _getMentorInformation(context, mentorId);
    }
  }

  _getMentorInformation(BuildContext context, int id) {
    loadingStatus.value = LoadingStatus.inprogress;
    service.getmentorDetails(id).then((value) {
      if (value.data != null) {
        profileImageUrl = value.data!.profileImg;
        firstName = value.data!.firstName!;
        lastName = value.data!.lastName!;
        suffixeName = value.data!.suffixeName!;
        categoryName = value.data!.categoryName;
        totalRate = value.data!.totalRate!;
        hourRate = value.data!.hourRateByJD!;
        bio = value.data!.bio;
        speakingLanguage = value.data!.speakingLanguage.toString();
        genderIndex = value.data!.gender!;
        gender = GenderFormat().convertIndexToString(context, genderIndex!);
        countryName = value.data!.country!;
        countryFlag = value.data!.countryFlag!;
        dateOfBirth = value.data!.dateOfBirth!;
        for (String item in value.data!.major!) {
          majors.add(MultiSelectCard(value: item, label: item));
        }
        workingHoursSaturday = value.data!.workingHoursSaturday;
        workingHoursSunday = value.data!.workingHoursSunday;
        workingHoursMonday = value.data!.workingHoursMonday;
        workingHoursTuesday = value.data!.workingHoursTuesday;
        workingHoursWednesday = value.data!.workingHoursWednesday;
        workingHoursThursday = value.data!.workingHoursThursday;
        workingHoursFriday = value.data!.workingHoursFriday;
        reviews = value.data!.reviews!;
        loadingStatus.value = LoadingStatus.finish;
      }
    });
  }

  @override
  onDispose() {
    loadingStatus.dispose();
  }
}
