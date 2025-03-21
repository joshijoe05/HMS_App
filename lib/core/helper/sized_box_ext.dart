import 'package:flutter/material.dart';

extension CustomSizedBoxExtension on int {
  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get height => SizedBox(height: toDouble());
}
