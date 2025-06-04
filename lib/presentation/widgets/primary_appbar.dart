import 'package:flutter/material.dart';
import 'package:militant_wrapper/core/styles/app_colors.dart';
import 'package:militant_wrapper/core/texts/strings.dart';
import 'package:militant_wrapper/presentation/widgets/texts.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Texts.appTitle(Strings.appName),
      backgroundColor: AppColors.getBackgroundColor(context),
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
