import 'package:flutter/material.dart';
import 'package:hms_app/core/theme/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onTap;
  const CustomTextButton({super.key, required this.text, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: textTheme.bodyMedium?.copyWith(
          color: color ?? AppColors.primaryColor500,
        ),
      ),
    );
  }
}
