import 'package:get/get.dart';
import 'milk_item_model.dart';

/// This class defines the variables used in the [milk_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MilkModel {
  Rx<List<MilkItemModel>> milkItemList =
      Rx(List.generate(4, (index) => MilkItemModel()));
}
