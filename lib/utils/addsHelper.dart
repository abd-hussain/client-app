import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-0120000896649737/4143366708';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-0120000896649737/4488505118';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
