import 'package:flutter/material.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final String heading;
  final TextEditingController textEditingController;
  final String hintText;
  final bool isObscure;
  final TextInputType keyboardType;
  final bool validate;
  final bool readOnly;
  final int? maxLength;
  final Widget? suffix;
  final Widget? prefix;
  final ValueChanged? onChanged;
  final bool showHeading;
  final bool isMultiline;
  final double? leftPadding;
  const CustomTextField({
    super.key,
    required this.heading,
    required this.textEditingController,
    required this.hintText,
    this.isObscure = false,
    this.keyboardType = TextInputType.name,
    this.validate = false,
    this.readOnly = false,
    this.maxLength,
    this.onChanged,
    this.suffix,
    this.showHeading = true,
    this.prefix,
    this.isMultiline = false,
    this.leftPadding,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeading)
          Text(
            heading,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        if (showHeading) 5.height,
        TextFormField(
          onChanged: onChanged,
          maxLength: maxLength,
          keyboardType: keyboardType,
          controller: textEditingController,
          readOnly: readOnly,
          obscureText: isObscure,
          obscuringCharacter: "*",
          validator: (value) {
            if (validate && (value == null || value.isEmpty)) {
              return "Comments cannot be empty";
            }
            return null;
          },
          cursorColor: AppColors.primaryColor900,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.grey600),
          minLines: (isObscure || !isMultiline) ? 1 : 1,
          maxLines: (isObscure || !isMultiline) ? 1 : 10,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: suffix,
            hintText: hintText,
            counter: 0.width,
            contentPadding: const EdgeInsets.symmetric(vertical: 18).copyWith(left: leftPadding ?? 20, right: 45),
            hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.grey500),
          ),
        ),
      ],
    );
  }
}
