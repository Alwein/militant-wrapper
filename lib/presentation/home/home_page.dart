import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:militant_wrapper/core/styles/app_colors.dart';
import 'package:militant_wrapper/core/styles/dimens.dart';
import 'package:militant_wrapper/presentation/app/bloc/app_bloc.dart';
import 'package:militant_wrapper/presentation/splash/splas_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/appbar.png",
          width: 120,
          height: 120,
        ),
        centerTitle: false,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const _WebView(),
    );
  }
}

class _WebView extends StatefulWidget {
  const _WebView();

  @override
  State<_WebView> createState() => _WebViewState();
}

class _WebViewState extends State<_WebView> with SingleTickerProviderStateMixin {
  final controller = WebViewController();

  late final String url;
  bool isLoading = true;

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
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
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
    return Stack(
      children: [
        WebViewWidget(controller: controller),
        IgnorePointer(
          child: AnimatedOpacity(
            opacity: isLoading ? 1.0 : 0.0,
            curve: Curves.easeInOut,
            duration: AnimationDurations.long,
            child: const SplashPage(),
          ),
        ),
      ],
    );
  }
}
