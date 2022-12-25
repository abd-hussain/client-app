import 'package:client_app/utils/constants/database_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CallBloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  @override
  onDispose() {}
}
