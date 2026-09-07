import 'package:get/get.dart';
import 'package:cattle_app/presentation/sales_entry/sales_entry_controller.dart';


class SalesEntryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalesEntryController());
  }
}