import 'package:get/get.dart';
import 'package:cattle_app/presentation/shed_couting/shed_counting_controller.dart';

class ShedCountingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShedCountingController());
  }
}