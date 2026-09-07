import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/splashScreen/splesh_screen_controller.dart';

import '../../core/utils/image_constant.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            ImageConstant.imgSplashone,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
