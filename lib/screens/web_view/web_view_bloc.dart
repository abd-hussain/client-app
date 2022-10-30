import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewBloc {
  String webViewUrl = "";
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  WebViewController? webViewController;

  void extractArguments(BuildContext context) {
    loadingStatus.value = LoadingStatus.inprogress;
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      webViewUrl = arguments[AppConstant.webViewPageUrl];
      loadingStatus.value = LoadingStatus.finish;
    }
  }
}
