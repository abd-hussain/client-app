import 'package:client_app/screens/web_view/web_view_bloc.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  WebViewScreen({Key? key}) : super(key: key);

  final _bloc = WebViewBloc();
  @override
  Widget build(BuildContext context) {
    _bloc.extractArguments(context);

    return Scaffold(
      appBar: customAppBar(title: _bloc.pageTitle),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: _bloc.loadingStatus,
          builder: (context, loadingsnapshot, child) {
            if (loadingsnapshot == LoadingStatus.finish) {
              return WebView(
                initialUrl: _bloc.webViewUrl,
                javascriptMode: JavascriptMode.unrestricted,
                debuggingEnabled: true,
                gestureNavigationEnabled: true,
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
                onWebViewCreated: (WebViewController webViewController) {
                  _bloc.webViewController = webViewController;
                  _bloc.webViewController!.loadUrl(_bloc.webViewUrl);
                },
              );
            } else {
              return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              );
            }
          }),
    );
  }
}
