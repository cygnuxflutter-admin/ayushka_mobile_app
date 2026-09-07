import '../controller/milk_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MilkScreen.
///
/// This class ensures that the MilkController is created when the
/// MilkScreen is first loaded.
class MilkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MilkController());
  }
}
