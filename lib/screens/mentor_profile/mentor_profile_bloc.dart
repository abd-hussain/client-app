import 'package:client_app/locator.dart';
import 'package:client_app/models/https/mentor_appoitments.dart';
import 'package:client_app/models/https/mentor_details_model.dart';
import 'package:client_app/models/working_hours.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/gender_format.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MentorProfileBloc extends Bloc<MentorService> {
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  String? profileImageUrl;

  String? firstName;
  String? lastName;
  String? suffixeName;
  String? bio;
  int? mentorId;
  String? categoryName;
  int? categoryID;

  double? hourRate;
  String? speakingLanguage;
  String? gender;
  int? genderIndex;
  String? countryName;
  String? countryFlag;
  String? dateOfBirth;
  String? experienceSince;
  String? currency;
  String? countryCode;
  String? currencyCode;
  bool freeCall = false;

  List<MultiSelectCard<String>> majors = [];
  List<Major> listOfMajors = [];
  List<Reviews> reviews = [];
  double totalRate = 0;
  List<int>? workingHoursSaturday;
  List<int>? workingHoursSunday;
  List<int>? workingHoursMonday;
  List<int>? workingHoursTuesday;
  List<int>? workingHoursWednesday;
  List<int>? workingHoursThursday;
  List<int>? workingHoursFriday;

  List<MentorAppointmentsResponseData> listOfAppointments = [];
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void handleReadingArguments(BuildContext context,
      {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      int mentorId = newArguments["id"] as int;

      _getMentorInformation(context, mentorId);
      _getMentorAppointments(mentorId);
    }
  }

  void _getMentorAppointments(int id) {
    locator<AppointmentsService>().getMentorAppointments(id).then((value) {
      if (value.data != null) {
        listOfAppointments = _prepareMentorAppoitnmentsFromUTC(value.data!);
      }
    });
  }

  List<MentorAppointmentsResponseData> _prepareMentorAppoitnmentsFromUTC(
      List<MentorAppointmentsResponseData> list) {
    int offset = DateTime.now().timeZoneOffset.inHours;
    for (MentorAppointmentsResponseData appoint in list) {
      appoint.dateFrom = _adjustDate(appoint.dateFrom, offset);
      appoint.dateTo = _adjustDate(appoint.dateTo, offset);
    }

    return list;
  }

  String _adjustDate(String? dateString, int offset) {
    if (dateString == null) return '';

    final DateTime date = DateTime.parse(dateString);
    final DateTime adjustedDate = date.add(Duration(hours: offset));

    return adjustedDate.toString();
  }

  void _getMentorInformation(BuildContext context, int id) {
    loadingStatus.value = LoadingStatus.inprogress;
    service.getmentorDetails(id).then((value) {
      if (value.data != null) {
        profileImageUrl = value.data!.profileImg;
        firstName = value.data!.firstName!;
        lastName = value.data!.lastName!;
        suffixeName = value.data!.suffixeName!;
        categoryName = value.data!.categoryName;
        categoryID = value.data!.categoryID;
        totalRate = value.data!.totalRate!;
        hourRate = value.data!.hourRate!;
        bio = value.data!.bio;
        mentorId = id;
        countryCode = value.data!.countryCode;
        currencyCode = value.data!.currencyCode;
        freeCall = handleFreeCallType(value.data!.freeCall);
        currency = value.data!.currency!;
        speakingLanguage = value.data!.speakingLanguage.toString();
        genderIndex = value.data!.gender!;
        gender = GenderFormat().convertIndexToString(context, genderIndex!);
        countryName = value.data!.country!;
        countryFlag = value.data!.countryFlag!;
        dateOfBirth = value.data!.dateOfBirth!;
        experienceSince = value.data!.experienceSince!;
        listOfMajors = value.data!.majors!;
        for (var item in value.data!.majors!) {
          majors.add(MultiSelectCard(value: item.name!, label: item.name!));
        }

        var workingHours = DayTime().prepareTimingFromUTC(
            workingHoursSaturday: value.data!.workingHoursSaturday ?? [],
            workingHoursSunday: value.data!.workingHoursSunday ?? [],
            workingHoursMonday: value.data!.workingHoursMonday ?? [],
            workingHoursTuesday: value.data!.workingHoursTuesday ?? [],
            workingHoursWednesday: value.data!.workingHoursWednesday ?? [],
            workingHoursThursday: value.data!.workingHoursThursday ?? [],
            workingHoursFriday: value.data!.workingHoursFriday ?? []);

        workingHoursSaturday = workingHours
            .where((element) => element.dayName == DayNameEnum.saturday)
            .first
            .list;
        workingHoursSunday = workingHours
            .where((element) => element.dayName == DayNameEnum.sunday)
            .first
            .list;
        workingHoursMonday = workingHours
            .where((element) => element.dayName == DayNameEnum.monday)
            .first
            .list;
        workingHoursTuesday = workingHours
            .where((element) => element.dayName == DayNameEnum.tuesday)
            .first
            .list;
        workingHoursWednesday = workingHours
            .where((element) => element.dayName == DayNameEnum.wednesday)
            .first
            .list;
        workingHoursThursday = workingHours
            .where((element) => element.dayName == DayNameEnum.thursday)
            .first
            .list;
        workingHoursFriday = workingHours
            .where((element) => element.dayName == DayNameEnum.friday)
            .first
            .list;

        reviews = value.data!.reviews!;
        loadingStatus.value = LoadingStatus.finish;
      }
    });
  }

  bool handleFreeCallType(int? freeCallFlag) {
    if (freeCallFlag == null) {
      return false;
    }

    if (freeCallFlag == 2) {
      return true;
    } else {
      return false;
    }
  }

  String calculateExperience(String? experienceSince) {
    if (experienceSince != null) {
      int intExperienceSince = int.tryParse(experienceSince) ?? 0;
      final now = DateTime.now();
      int intCurrentYear = now.year;
      return "${intCurrentYear - intExperienceSince}";
    } else {
      return "0";
    }
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  @override
  onDispose() {
    loadingStatus.dispose();
  }
}
