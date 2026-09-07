import 'package:get/get.dart';
import 'package:cattle_app/presentation/Expense/Expense_screen_controller.dart';

class ExpenseScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpenseScreenController());
  }
}