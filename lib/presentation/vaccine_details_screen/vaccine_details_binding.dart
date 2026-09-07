
import 'package:get/get.dart';
import 'package:cattle_app/presentation/vaccine_details_screen/vaccine_details_controller.dart';


class vaccineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VaccineDetailsController());
  }
}
