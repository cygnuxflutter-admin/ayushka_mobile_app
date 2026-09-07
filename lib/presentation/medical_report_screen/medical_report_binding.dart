
import 'package:get/get.dart';
import 'package:cattle_app/presentation/medical_report_screen/medical_report_controller.dart';


class MedicalReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicalReportController());
  }
}
