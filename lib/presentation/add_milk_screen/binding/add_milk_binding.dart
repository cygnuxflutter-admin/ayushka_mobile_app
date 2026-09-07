import '../controller/add_milk_controller.dart';
import 'package:get/get.dart';

/// A binding class for the AddMilkScreen.
///
/// This class ensures that the AddMilkController is created when the
/// AddMilkScreen is first loaded.
class AddMilkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMilkController());
  }
}
