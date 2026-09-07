
import 'package:get/get.dart';
import 'package:cattle_app/presentation/heat_pregnancy_screen/heat_pregnancy_controller.dart';


class HeatPregnancyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HeatPregnancyController());
  }
}
