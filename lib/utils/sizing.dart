import 'package:flutter/material.dart';

class Sizing {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;
  static Widget k10Spacer(context) => SizedBox(height: height(context) * 0.01);
  static Widget kHSpacer(double space) => SizedBox(height: space);
  static Widget kWSpacer(double space) => SizedBox(width: space);
}
