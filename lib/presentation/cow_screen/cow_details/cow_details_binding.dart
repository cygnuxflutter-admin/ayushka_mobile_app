import 'package:get/get.dart';
import 'package:cattle_app/presentation/cow_screen/cow_details/cow_details_controller.dart';

class CowsDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CowsDetailScreenController());
  }
}