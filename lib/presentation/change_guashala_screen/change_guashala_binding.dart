import 'package:cattle_app/presentation/change_guashala_screen/change_guashala_controller.dart';
import 'package:get/get.dart';

class ChangeGuashalaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeGuashalaScreenController());
  }
}
