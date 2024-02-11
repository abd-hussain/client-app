import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfoService {
  StreamController<bool> networkStateStreamControler =
      StreamController.broadcast();
  StreamController<bool> firebaseInitNetworkStateStreamControler =
      StreamController.broadcast();
  Connectivity connectivity = Connectivity();

  Future<bool> isInternetConnected() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return true;
      default:
        return false;
    }
  }

  void initNetworkConnectionCheck() {
    connectivity.onConnectivityChanged.distinct((previous, next) {
      return previous == next;
    }).listen((event) {
      var isConnected = event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi;
      firebaseInitNetworkStateStreamControler.sink.add(isConnected);
      Future.delayed(const Duration(seconds: 1), () {
        networkStateStreamControler.sink.add(isConnected);
      });
    });
  }

  Future<bool> checkConnectivityonLunching() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return await _internetLookupCheck();
      default:
        return false;
    }
  }

  Future<bool> _internetLookupCheck() async {
    try {
      final value = await lookup('google.com');

      if (value.isNotEmpty && value[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<InternetAddress>> lookup(String host) async {
    return InternetAddress.lookup(host);
  }
}
