import 'package:cattle_app/presentation/milk_screen/controller/milk_controller.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart' hide Response;

import '../common file/defaultVariablesList.dart';
import '../milk_screen/models/cowList_res.dart';

class ShedCountingController extends GetxController {
  MilkController milkController = MilkController();
  RxInt totalCowCount = 0.obs;

  Map<String, Map<String, int>> shedData = {};
  Map<String, Map<String, int>> cowTypeData = {};
  RxList NA = [].obs;
  @override
  void onInit() {
    milkController = Get.put(MilkController());
    retrieveCowData();
    shedCount();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> shedCount() {
    final groupedData = groupBy(milkController.cowList, (Datum datum) => datum.shedId);
    final sortedShedIds = groupedData.keys.toList();

    int customComparator(String a, String b) {
      if (a.startsWith(RegExp(r'[0-9]')) && b.startsWith(RegExp(r'[0-9]'))) {
        int aNum = int.parse(a.replaceAll(RegExp(r'[A-Za-z]'), ''));
        int bNum = int.parse(b.replaceAll(RegExp(r'[A-Za-z]'), ''));
        return aNum.compareTo(bNum);
      } else if (a.startsWith(RegExp(r'[A-Za-z]')) && b.startsWith(RegExp(r'[A-Za-z]'))) {
        return a.compareTo(b);
      } else if (a.startsWith(RegExp(r'[0-9]'))) {
        return -1;
      } else {
        return 1;
      }
    }

    sortedShedIds.sort(customComparator);
    for (var shedId in sortedShedIds) {
      final shedGroup = groupedData[shedId]!;
      final groupedByType = groupBy(shedGroup, (Datum datum) => datum.type);

      Map<String, int> cattleCounts = {};

      for (var typeGroup in groupedByType.entries) {
        cattleCounts[typeGroup.key] = typeGroup.value.length;
      }

      shedData[shedId] = cattleCounts;
    }

    return sortedShedIds;
  }

  List<String> cowCount() {
    final groupedCowData = groupBy(milkController.cowList, (Datum datum) => datum.type);

    final List<String> customOrder = [
      'Milking',
      'Milking-Calf-Female',
      'Milking-Calf-Male',
      'Milking-Pregnant',
      'Pregnant',
      'Hipper',
      'FirstTime-Pregnant',
      'BreedingBull',
      'Bull',
      'Non-Pregnant',
      'SevaCow',
      'DryCow',
      'Died',
      'Donate',
    ];

    int totalCount = 0;
    cowTypeData.clear(); // make sure old data is cleared

    for (var cowType in customOrder) {
      final shedGroup = groupedCowData[cowType];
      if (shedGroup != null) {
        final groupedByType = groupBy(shedGroup, (Datum datum) => datum.type);

        Map<String, int> cattleTypeCounts = {};

        for (var typeGroup in groupedByType.entries) {
          cattleTypeCounts[typeGroup.key] = typeGroup.value.length;
          if (typeGroup.key != 'Donate' && typeGroup.key != 'Died') {
            totalCount += typeGroup.value.length;
          }
        }
        cowTypeData[cowType] = cattleTypeCounts;
      }
    }

    totalCowCount.value = totalCount;

    // ✅ Return only cow types that exist in data, in your custom order
    return customOrder.where((type) => groupedCowData.keys.contains(type)).toList();
  }

  /// Filter cow  List
  List<Datum> getCowListForShed(String shedId) {
    return milkController.cowList.where((cow) => cow.shedId == shedId).toList();
  }
}
