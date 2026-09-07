import 'package:get/get.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/controller/dairy_usage_controller.dart';

class DairyUsageBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => DairyUsageController());
  }
}