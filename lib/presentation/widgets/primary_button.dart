import 'package:flutter/material.dart';
import 'package:militant_wrapper/core/styles/app_colors.dart';
import 'package:militant_wrapper/core/styles/margins.dart';
import 'package:militant_wrapper/core/styles/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.iconRight = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final bool iconRight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        foregroundColor: WidgetStateProperty.all(Colors.transparent),
        textStyle: WidgetStateProperty.all(TextStyles.mediumBold),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          return states.contains(WidgetState.disabled)
              ? AppColors.contentDisabled
              : backgroundColor ?? AppColors.contentColor(context);
        }),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        alignment: Alignment.center,
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(200))),
        ),
        overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Margins.spacingM, vertical: Margins.spacingBase),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: Margins.spacingS,
          children: [
            if (icon != null && !iconRight) Icon(icon, color: textColor ?? AppColors.invertedTextColor(context)),
            Text(text, style: TextStyles.mediumBold.copyWith(color: textColor ?? AppColors.invertedTextColor(context))),
            if (icon != null && iconRight) Icon(icon, color: textColor ?? AppColors.invertedTextColor(context)),
          ],
        ),
      ),
    );
  }
}
