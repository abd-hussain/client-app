import 'package:client_app/models/https/archive.dart';
import 'package:client_app/sevices/archive_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArchiveBloc extends Bloc<ArchiveService> {
  final ValueNotifier<List<ArchiveData>> listOfArchiveNotifier =
      ValueNotifier<List<ArchiveData>>([]);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void listOfArchives() {
    service.getAllClientArchive().then((value) {
      if (value.data != null) {
        listOfArchiveNotifier.value = value.data!;
      }
    });
  }

  @override
  onDispose() {}
}
