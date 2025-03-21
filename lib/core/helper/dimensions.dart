import 'package:flutter/material.dart';

class Dimensions {
  static double getHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
  static double getWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
}
