import 'package:get/get.dart';
import 'package:cattle_app/presentation/milk_screen/widgets/milk_item_widget.dart';

/// This class is used in the [milk_item_widget] screen.
class MilkItemModel {
  List<MilkItemWidget> milkItemList = [];

  Rx<String> k25saraTxt = Rx("25 - Sara");

  Rx<String> typeTxt = Rx("Dry");

  Rx<String> cowisexitTxt = Rx("Cow is exit");

  Rx<String>? id = Rx("");
}
