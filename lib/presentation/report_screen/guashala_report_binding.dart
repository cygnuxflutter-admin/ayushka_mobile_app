import 'package:get/get.dart';

import 'guashala_report_controller.dart';

class GuashalaReportScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuashalaReportScreenController());
  }
}
