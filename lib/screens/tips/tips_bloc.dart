import 'package:client_app/models/https/home_response.dart';

class TipsBloc {
  late MainTips tipInformations;
  void handleReadingArguments({required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      tipInformations = newArguments["tip"] as MainTips;
    }
  }
}
