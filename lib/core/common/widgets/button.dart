import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? titleWidget;
  final String? title;
  final Color? color;
  final Gradient? gradient;
  final VoidCallback onTap;
  final bool isEnabled;
  final bool isLoading;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  const CustomButton({
    super.key,
    this.width,
    this.height,
    this.titleWidget,
    this.title,
    this.color,
    this.gradient,
    required this.onTap,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor,
    this.borderColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width ?? Dimensions.getWidth(context), height ?? (Platform.isIOS ? 50 : 48)),
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isEnabled ? (borderColor ?? color) ?? AppColors.primaryColor900 : AppColors.primaryColor50,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      onPressed: isEnabled ? onTap : null,
      child: Container(
        width: width ?? Dimensions.getWidth(context),
        height: height ?? (Platform.isIOS ? 50 : 48),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: isEnabled ? gradient : null,
          color: isEnabled ? (color ?? AppColors.primaryColor900) : AppColors.primaryColor50,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: titleWidget ??
              Text(
                '$title',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: fontSize,
                  color: isEnabled ? (textColor ?? Colors.white) : AppColors.primaryColor900,
                ),
              ),
        ),
      ),
    );
  }
}
