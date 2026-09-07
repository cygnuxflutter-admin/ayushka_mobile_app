import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/medical_report_screen/medical_report_controller.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/pending_Vaccine_response.dart';
import 'package:cattle_app/theme/app_style.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_button.dart';

class PendingCowScreen extends GetView<MedicalReportController> {
  PendingCowScreen({Key? key}) : super(key: key);

  final RxString searchQuery = ''.obs;

  void toggleAllPresentAbsent() {
    bool allSelected = true;
    for (var employee in controller.pendingVaccineCowList) {
      if (!employee.isSelectCow.value) {
        allSelected = false;
        break;
      }
    }

    for (var employee in controller.pendingVaccineCowList) {
      employee.isSelectCow.value = !allSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIconOnTap: () {
          Get.back();
        },
        leadingIcon: const Icon(Icons.arrow_back, color: Colors.white),
        centerTitle: true,
        height: 60,
        title: "Pending Cows",
        styleType: Style.bgFillBluegray900,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  onChanged: (value) {
                    searchQuery.value = value;
                    controller.updateFilteredItemList(value);
                  },
                  controller: controller.searchController,
                  decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Color(0xff232f34),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    toggleAllPresentAbsent();
                  },
                  child: const Text(
                    'Select all',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                ),
              ),
              const Divider(
                color: Color(0xff232f34),
              ),
              Obx(
                () {
                  final query = searchQuery.value;
                  List<PendingVaccineCowDatum> filteredList = controller.updateFilteredItemList(query);
                  filteredList.sort((a, b) {
                    final idA = a.tagId;
                    final idB = b.tagId;
                    final intA = int.tryParse(idA) ?? double.infinity;
                    final intB = int.tryParse(idB) ?? double.infinity;

                    if (intA != double.infinity && intB != double.infinity) {
                      return intA.compareTo(intB);
                    } else if (intA == double.infinity && intB == double.infinity) {
                      return idA.compareTo(idB);
                    } else {
                      return intA == double.infinity ? 1 : -1;
                    }
                  });
                  if (filteredList.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "Data Not Found",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtOutfitLight15,
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    activeColor: const Color(0xff232f34),
                                    value: item.isSelectCow.value,
                                    onChanged: (bool? newValue) {
                                      if (newValue != null) {
                                        item.isSelectCow.value = newValue;
                                      }
                                    },
                                  ),
                                ),
                                Text('${item.tagId} : ${item.calfName}'),
                              ],
                            ),
                            const Divider(
                              color: Color(0xff232f34),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                    text: "Select",
                    width: 200,
                    height: 55,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                    variant: ButtonVariant.FillGreen600b2,
                    onTap: () {
                      Get.back();
                      print(controller.pendingVaccineCowList.length);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
