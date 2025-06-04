import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:militant_wrapper/core/styles/app_colors.dart';
import 'package:militant_wrapper/core/styles/margins.dart';
import 'package:militant_wrapper/core/texts/app_links.dart';
import 'package:militant_wrapper/core/texts/strings.dart';
import 'package:militant_wrapper/presentation/widgets/primary_appbar.dart';
import 'package:militant_wrapper/presentation/widgets/primary_button.dart';
import 'package:militant_wrapper/presentation/widgets/texts.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdatePage extends StatelessWidget {
  const ForceUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Margins.spacingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.error,
                    size: 32,
                    color: AppColors.redWarning,
                  ),
                  const SizedBox(width: Margins.spacingBase),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.primaryMedium(Strings.forceUpdateTitle, textAlign: TextAlign.center),
                        const SizedBox(height: Margins.spacingS),
                        Texts.primaryRegular(Strings.forceUpdateSubtitle, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Margins.spacingM),
              PrimaryButton(
                text: Strings.forceUpdateButton,
                onPressed: () async => await _openStore(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openStore() async {
    final url = switch (defaultTargetPlatform) {
      TargetPlatform.iOS => AppLinks.iosAppStoreUrl,
      TargetPlatform.android => AppLinks.androidAppStoreUrl,
      _ => throw UnsupportedError('Unsupported platform'),
    };
    await launchUrl(Uri.parse(url));
  }
}
