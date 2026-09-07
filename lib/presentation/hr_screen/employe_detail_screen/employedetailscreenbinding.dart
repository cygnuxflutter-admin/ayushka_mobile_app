import 'package:get/get.dart';
import 'package:cattle_app/presentation/hr_screen/employe_detail_screen/employedetailscreencontroller.dart';

class EmployeeDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeDetailScreenController());
  }
}
