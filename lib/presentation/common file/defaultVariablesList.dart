import 'package:get/get.dart';

import '../../core/utils/pref_utils.dart';
import '../splashScreen/models/defaultVariables_response.dart';

RxList<Breed> cowType = <Breed>[].obs;
RxList<Breed> breed = <Breed>[].obs;
RxList<Breed> shed = <Breed>[].obs;
RxList<Breed> bull = <Breed>[].obs;
RxList<Breed> dairyItems = <Breed>[].obs;
RxList<Breed> distributionFreePerson = <Breed>[].obs;
RxList<SalesItem> salesItem = <SalesItem>[].obs;
RxList<Vendor> vendorID = <Vendor>[].obs;
RxList<ItemMaster> itemMaster = <ItemMaster>[].obs;
RxList<Breed> expenseType = <Breed>[].obs;
RxList<Department> departmentName = <Department>[].obs;
RxList<Vehicle> vehicle = <Vehicle>[].obs;
RxList<Breed> vaccines = <Breed>[].obs;
RxList<Breed> employeeCategory = <Breed>[].obs;

Future<void> retrieveCowData() async {
  // try {
  String? savedCowDataJson = PrefUtils.getDefaultVariables();

  if (savedCowDataJson != null && savedCowDataJson.isNotEmpty && savedCowDataJson != "null") {
    dynamic decodedData = savedCowDataJson;

    CowData cowData = cowDataFromJson(decodedData);

    cowType.value = cowData.cowTypes;
    cowType.sort((a, b) {
      final codeA = a.value;
      final codeB = b.value;

      final isNumericA = RegExp(r'^\d').hasMatch(codeA);
      final isNumericB = RegExp(r'^\d').hasMatch(codeB);

      if (isNumericA && !isNumericB) {
        return 1;
      } else if (!isNumericA && isNumericB) {
        return -1;
      } else {
        return codeA.compareTo(codeB);
      }
    });
    shed.value = cowData.sheds;
    shed.sort((a, b) {
      final idA = a.value;
      final idB = b.value;
      final intA = int.tryParse(idA) ?? double.infinity;
      final intB = int.tryParse(idB) ?? double.infinity;

      if (intA != double.infinity && intB != double.infinity) {
        return intA.compareTo(intB);
      } else if (intA == double.infinity && intB == double.infinity) {
        return idA.compareTo(idB);
      } else {
        return intA == double.infinity ? 1 : -1; // One is int and the other is string
      }
    });
    breed.value = cowData.breeds;
    breed.sort((a, b) {
      final codeA = a.value;
      final codeB = b.value;

      final isNumericA = RegExp(r'^\d').hasMatch(codeA);
      final isNumericB = RegExp(r'^\d').hasMatch(codeB);

      if (isNumericA && !isNumericB) {
        return 1;
      } else if (!isNumericA && isNumericB) {
        return -1;
      } else {
        return codeA.compareTo(codeB);
      }
    });
    bull.value = cowData.bulls;
    bull.sort((a, b) {
      final idA = a.id;
      final idB = b.id;
      final intA = int.tryParse(idA) ?? double.infinity;
      final intB = int.tryParse(idB) ?? double.infinity;

      if (intA != double.infinity && intB != double.infinity) {
        return intA.compareTo(intB);
      } else if (intA == double.infinity && intB == double.infinity) {
        return idA.compareTo(idB);
      } else {
        return intA == double.infinity ? 1 : -1; // One is int and the other is string
      }
    });
    dairyItems.value = cowData.items;
    dairyItems.sort((a, b) {
      final codeA = a.value;
      final codeB = b.value;

      final isNumericA = RegExp(r'^\d').hasMatch(codeA);
      final isNumericB = RegExp(r'^\d').hasMatch(codeB);

      if (isNumericA && !isNumericB) {
        return 1;
      } else if (!isNumericA && isNumericB) {
        return -1;
      } else {
        return codeA.compareTo(codeB);
      }
    });
    distributionFreePerson.value = cowData.distributionFreePerson;
    vendorID.value = cowData.vendors;
    vendorID.sort((a, b) {
      final codeA = a.code;
      final codeB = b.code;

      final numericPartA = int.tryParse(codeA.substring(1));
      final numericPartB = int.tryParse(codeB.substring(1));

      if (numericPartA != null && numericPartB != null) {
        if (numericPartA != numericPartB) {
          return numericPartA.compareTo(numericPartB);
        }
      } else if (numericPartA != null) {
        return -1;
      } else if (numericPartB != null) {
        return 1;
      }

      return codeA.compareTo(codeB);
    });
    salesItem.value = cowData.salesItems;
    salesItem.sort((a, b) {
      final codeA = a.itemName;
      final codeB = b.itemName;

      final isNumericA = RegExp(r'^\d').hasMatch(codeA);
      final isNumericB = RegExp(r'^\d').hasMatch(codeB);

      if (isNumericA && !isNumericB) {
        return 1;
      } else if (!isNumericA && isNumericB) {
        return -1;
      } else {
        return codeA.compareTo(codeB);
      }
    });
    departmentName.value = cowData.department;
    departmentName.sort((a, b) {
      final codeA = a.value;
      final codeB = b.value;

      final isNumericA = RegExp(r'^\d').hasMatch(codeA);
      final isNumericB = RegExp(r'^\d').hasMatch(codeB);

      if (isNumericA && !isNumericB) {
        return 1;
      } else if (!isNumericA && isNumericB) {
        return -1;
      } else {
        return codeA.compareTo(codeB);
      }
    });
    itemMaster.value = cowData.itemMaster;
    itemMaster.sort((a, b) {
      final codeA = a.itemName;
      final codeB = b.itemName;

      final isNumericA = RegExp(r'^\d').hasMatch(codeA);
      final isNumericB = RegExp(r'^\d').hasMatch(codeB);

      if (isNumericA && !isNumericB) {
        return 1;
      } else if (!isNumericA && isNumericB) {
        return -1;
      } else {
        return codeA.compareTo(codeB);
      }
    });
    expenseType.value = cowData.expenseTypes;
    expenseType.sort((a, b) {
      final codeA = a.value;
      final codeB = b.value;

      final isNumericA = RegExp(r'^\d').hasMatch(codeA);
      final isNumericB = RegExp(r'^\d').hasMatch(codeB);

      if (isNumericA && !isNumericB) {
        return 1;
      } else if (!isNumericA && isNumericB) {
        return -1;
      } else {
        return codeA.compareTo(codeB);
      }
    });
    vehicle.value = cowData.vehicles;
    vaccines.value = cowData.vaccines;
    employeeCategory.value = cowData.employeeCategory;
    employeeCategory.sort((a, b) {
      final codeA = a.value;
      final codeB = b.value;

      final isNumericA = RegExp(r'^\d').hasMatch(codeA);
      final isNumericB = RegExp(r'^\d').hasMatch(codeB);

      if (isNumericA && !isNumericB) {
        return 1;
      } else if (!isNumericA && isNumericB) {
        return -1;
      } else {
        return codeA.compareTo(codeB);
      }
    });
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${cowData.cowTypes}");
  }
  // } catch (e) {
  //   print('Error while retrieving or processing data: $e');
  // }
}
