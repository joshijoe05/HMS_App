import 'package:flutter/material.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/theme/colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.primaryColor50,
        padding: const EdgeInsets.all(8),
      ),
      onPressed: onTap ??
          () {
            router.pop();
          },
      icon: const Icon(
        Icons.arrow_back,
        size: 26,
        color: AppColors.primaryColor900,
      ),
    );
  }
}
