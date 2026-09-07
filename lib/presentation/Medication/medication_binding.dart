import 'package:get/get.dart';
import 'package:cattle_app/presentation/Medication/medication_controller.dart';

class MedicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicationController());
  }
}
