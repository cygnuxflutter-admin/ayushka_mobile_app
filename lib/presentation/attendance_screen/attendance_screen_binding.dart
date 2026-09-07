import 'package:get/get.dart';
import 'package:cattle_app/presentation/attendance_screen/attendance_screen_controller.dart';

class AttendanceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceScreenController());
  }
}
