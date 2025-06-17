import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:militant_wrapper/core/styles/app_colors.dart';
import 'package:militant_wrapper/core/styles/dimens.dart';
import 'package:militant_wrapper/core/styles/margins.dart';
import 'package:militant_wrapper/presentation/app/bloc/app_bloc.dart';
import 'package:militant_wrapper/presentation/splash/splas_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.secondary,
      body: _WebView(),
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
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  void initState() {
    super.initState();
    _getUrl();

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            final uri = Uri.parse(request.url);
            // Définir le domaine de base à partir de l'URL initiale
            final baseDomain = Uri.parse(url).host;
            if (uri.host != baseDomain && uri.scheme.startsWith('http')) {
              // Lien externe, ouvrir dans le navigateur natif
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
            _updateNavigationState();
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<void> _updateNavigationState() async {
    final canBack = await controller.canGoBack();
    final canForward = await controller.canGoForward();
    if (mounted) {
      setState(() {
        canGoBack = canBack;
        canGoForward = canForward;
      });
    }
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
        SafeArea(
          bottom: false,
          child: WebViewWidget(controller: controller),
        ),
        if (!isLoading)
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: Margins.spacingBase,
            child: Row(
              children: [
                if (canGoBack)
                  FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(360),
                    ),
                    backgroundColor: AppColors.secondary,
                    onPressed: () async {
                      await controller.goBack();
                      _updateNavigationState();
                    },
                    child: const Icon(Icons.arrow_back, color: AppColors.content),
                  ),
              ],
            ),
          ),
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
