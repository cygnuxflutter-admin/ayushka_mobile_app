import 'package:get/get.dart';
import '../vaccine_reminder_controller.dart';

class VaccineReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VaccineReminderController());
  }
}
