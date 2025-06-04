import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:militant_wrapper/presentation/app/bloc/app_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _WebView(),
    );
  }
}

class _WebView extends StatefulWidget {
  const _WebView();

  @override
  State<_WebView> createState() => _WebViewState();
}

class _WebViewState extends State<_WebView> {
  final controller = WebViewController();

  late final String url;

  @override
  void initState() {
    super.initState();
    _getUrl();

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void _getUrl() {
    final remoteUrl = context.read<AppBloc>().state.appRemoteConfig?.remoteUrl;
    if (remoteUrl != null && remoteUrl.isNotEmpty) {
      url = remoteUrl;
    } else {
      url = dotenv.get("BASE_URL", fallback: "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
