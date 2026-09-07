import 'package:get/get.dart';
import 'package:cattle_app/presentation/cow_screen/cow_controller.dart';

class CowsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CowsScreenController());
  }
}