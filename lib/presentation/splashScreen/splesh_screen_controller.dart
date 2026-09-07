import 'package:get/get.dart';

import '../../core/utils/pref_utils.dart';
import '../../routes/app_routes.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offNamed(
        PrefUtils.getIsLogin == true
            ? AppRoutes.dashboardScreen
            : AppRoutes.loginScreen,
      );
    });
    super.onInit();
  }


}
