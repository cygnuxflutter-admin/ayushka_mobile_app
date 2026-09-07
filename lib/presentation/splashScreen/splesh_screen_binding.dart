import 'package:get/get.dart';
import 'package:cattle_app/presentation/splashScreen/splesh_screen_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
