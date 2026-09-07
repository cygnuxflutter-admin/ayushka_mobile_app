import 'package:get/get.dart';
import 'addemployeescreencontroller.dart';

class AddEmployeeScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Register the AddEmployeeScreenController for this screen
    Get.lazyPut(() => AddEmployeeScreenController());
  }
}
