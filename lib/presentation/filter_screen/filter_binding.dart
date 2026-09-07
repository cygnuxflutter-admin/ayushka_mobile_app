import 'package:get/get.dart';
import 'package:cattle_app/presentation/filter_screen/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController());
  }
}