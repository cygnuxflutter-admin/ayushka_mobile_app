import 'package:get/get.dart';
import 'package:cattle_app/presentation/cow_screen/Add_cow/add_cow_controller.dart';

class AddCowScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCowScreenController());
  }
}