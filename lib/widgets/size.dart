import 'package:flutter/material.dart';

class AppSize {
  static Size size(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}