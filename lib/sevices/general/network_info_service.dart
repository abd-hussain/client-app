import 'dart:async';

import 'package:client_app/utils/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfoService {
  ValueNotifier<bool> networkStateConnection = ValueNotifier<bool>(false);

  Future<bool> isConnected() async {
    late ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      ConnectionException(message: 'Couldn\'t check connectivity status error: $e');
      return false;
    }

    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      networkStateConnection.value = true;
      return true;
    } else {
      networkStateConnection.value = false;
      return false;
    }
  }
}
