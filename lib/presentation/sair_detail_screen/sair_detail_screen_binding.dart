import 'package:cattle_app/presentation/sair_detail_screen/sair_detail_screen_controller.dart';
import 'package:get/get.dart';


class SairDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SairDetailScreenController());
  }
}