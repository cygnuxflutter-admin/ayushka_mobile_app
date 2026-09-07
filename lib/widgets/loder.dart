import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLoader {
  void hide() {
    Get.back();
  }

  void show() {
    Get.defaultDialog(
      title: 'Please wait...',
      content: const CircularProgressIndicator(color: Colors.blue),
      middleText: "Please wait....",
      barrierDismissible: false,
    );
  }
}
