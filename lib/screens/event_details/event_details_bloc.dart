import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/sevices/event_services.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/errors/exceptions.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailsBloc extends Bloc<EventService> {
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  String? image = "";
  int? mentorId = 0;
  String? mentorProfileImage = "";
  String? mentorSuffixeName = "";
  String? mentorFirstName = "";
  String? mentorLastName = "";
  String? mentorCategoryName = "";
  double? eventPrice = 0;
  String? eventName = "";
  String? eventDate = "";
  String? eventDayName = "";
  String? eventHour = "";
  String? eventDuration = "";
  String? eventDescripton = "";
  int eventId = 0;
  int maxNumberOfAttendance = 0;
  int joiningClients = 0;
  bool alreadyRegister = false;

  bool isEventFree = false;

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void handleReadingArguments({required BuildContext context, required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      MainEvent event = newArguments["event_details"] as MainEvent;
      eventId = event.id!;
      eventName = event.title!;
      eventPrice = event.price!;
      if (eventPrice == 0) {
        isEventFree = true;
      }
      image = AppConstant.imagesBaseURLForEvents + event.image!;

      final fromDateTime = DateTime.parse(event.dateFrom!);
      final toDateTime = DateTime.parse(event.dateTo!);
      eventDayName = DateFormat('EEEE').format(fromDateTime);
      final difference = toDateTime.difference(fromDateTime).inMinutes;
      eventDate = "${fromDateTime.year}/${fromDateTime.month}/${fromDateTime.day}";
      eventDuration = "$difference ${AppLocalizations.of(context)!.min}";
      eventHour = DayTime().convertingTimingWithMinToRealTime(fromDateTime.hour, fromDateTime.minute);
    }
  }

  void getEventDetails(BuildContext context) {
    loadingStatus.value = LoadingStatus.inprogress;

    int userID = 0;

    if (box.get(DatabaseFieldConstant.userid) != null) {
      userID = int.parse(box.get(DatabaseFieldConstant.userid));
    }

    service.getEventDetails(eventId: eventId, userId: userID).then((value) {
      if (value.data != null) {
        eventName = value.data!.title!;
        eventPrice = value.data!.price!;
        // eventId = value.data!.id!;
        image = AppConstant.imagesBaseURLForEvents + value.data!.image!;
        final fromDateTime = DateTime.parse(value.data!.dateFrom!);
        final toDateTime = DateTime.parse(value.data!.dateTo!);
        eventDayName = DateFormat('EEEE').format(fromDateTime);
        final difference = toDateTime.difference(fromDateTime).inMinutes;
        eventDate = "${fromDateTime.year}/${fromDateTime.month}/${fromDateTime.day}";
        eventDuration = "$difference ${AppLocalizations.of(context)!.min}";
        eventHour = DayTime().convertingTimingWithMinToRealTime(fromDateTime.hour, fromDateTime.minute);
        eventDescripton = value.data!.description!;
        mentorCategoryName = value.data!.categoryName!;
        mentorProfileImage = value.data!.mentorProfileImg!;
        mentorSuffixeName = value.data!.mentorSuffixName!;
        mentorFirstName = value.data!.mentorFirstName!;
        mentorLastName = value.data!.mentorLastName!;
        mentorId = value.data!.mentorId!;
        joiningClients = value.data!.joiningClients!;
        alreadyRegister = value.data!.alreadyRegister!;
        maxNumberOfAttendance = value.data!.maxNumberOfAttendance!;

        loadingStatus.value = LoadingStatus.finish;
      }
    });
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  Future<dynamic> bookEventRequest(BuildContext context) async {
    try {
      final _ = await service.bookNewEvent(eventID: eventId);
    } on DioError catch (error) {
      final exception = error.error;
      if (exception is HttpException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(exception.message),
        ));
      }
    }
    return 5;
  }

  Future<dynamic> cancelEventRequest(BuildContext context) async {
    try {
      final _ = await service.cancelbookedEvent(eventID: eventId);
    } on DioError catch (error) {
      final exception = error.error;
      if (exception is HttpException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(exception.message),
        ));
      }
    }
    return 5;
  }

  @override
  onDispose() {}
}
