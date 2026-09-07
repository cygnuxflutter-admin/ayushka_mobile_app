import 'package:get/get.dart';

import 'hr_screen_controller.dart';


class HrScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HrScreenController());
  }
}
