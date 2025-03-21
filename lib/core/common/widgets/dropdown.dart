import 'package:flutter/material.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';

class CustomDropDownButton extends StatefulWidget {
  final Function(String?) onChanged;
  final List<String> items;
  final String? item;
  final bool showHeading;
  final String heading;
  const CustomDropDownButton(
      {super.key,
      required this.onChanged,
      required this.items,
      this.item,
      this.showHeading = false,
      this.heading = ""});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeading)
          Text(
            widget.heading,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        if (widget.showHeading) 5.height,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.greyScaleColor,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: widget.item,
              items: widget.items.map((e) => buildMenuItem(e)).toList(),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    var textTheme = Theme.of(context).textTheme;
    return DropdownMenuItem<String>(
      value: item,
      child: Text(
        item,
        style: textTheme.bodyMedium,
      ),
    );
  }
}
