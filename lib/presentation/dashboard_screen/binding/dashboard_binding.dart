import '../controller/dashboard_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DashboardScreen.
///
/// This class ensures that the DashboardController is created when the
/// DashboardScreen is first loaded.
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
