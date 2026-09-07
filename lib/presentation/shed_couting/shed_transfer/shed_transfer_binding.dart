import 'package:get/get.dart';
import 'package:cattle_app/presentation/shed_couting/shed_transfer/shed_transfer_controller.dart';

class ShedTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShedTransferController());
  }
}