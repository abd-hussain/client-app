import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class MentorProfileBloc extends Bloc<MentorService> {
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  String? profileImageUrl;
  String? firstName;
  String? lastName;
  String? suffixeName;
  int? categoryName;

  void handleReadingArguments({required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      int mentorId = newArguments["id"] as int;
      _getMentorInformation(mentorId);
    }
  }

  _getMentorInformation(int id) {
    loadingStatus.value = LoadingStatus.inprogress;
    service.getmentorDetails(id).then((value) {
      if (value.data != null) {
        profileImageUrl = value.data!.profileImg;
        firstName = value.data!.firstName!;
        lastName = value.data!.lastName!;
        suffixeName = value.data!.suffixeName!;
        categoryName = value.data!.categoryId!;

        loadingStatus.value = LoadingStatus.finish;
      }
    });
  }

  @override
  onDispose() {
    loadingStatus.dispose();
  }
}
