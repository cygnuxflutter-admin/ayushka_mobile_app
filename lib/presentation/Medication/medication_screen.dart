import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/Medication/medication_controller.dart';
import 'package:cattle_app/presentation/Medication/models/getPending_Medicine_Response.dart';
import 'package:cattle_app/presentation/milk_screen/controller/milk_controller.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import 'package:cattle_app/widgets/custom_button.dart';

import '../../widgets/dropdown/dropdown.dart';
import '../common file/defaultVariablesList.dart';
import '../dashboard_screen/controller/dashboard_controller.dart' as dashboard;
import '../medical_report_screen/models/medicine_update_request.dart';

class MedicationScreen extends GetView<MedicationController> {
  const MedicationScreen({Key? key}) : super(key: key);

  void selectToDayAllCows() {
    bool allSelected = true;
    for (var cow in controller.todayData) {
      if (!cow.isSelectCow.value) {
        allSelected = false;
        break;
      }
    }
    for (var cow in controller.todayData) {
      cow.isSelectCow.value = !allSelected;
    }
  }

  void selectOlderAllCows() {
    bool allSelected = true;
    for (var cow in controller.olderData) {
      if (!cow.isSelectCow.value) {
        allSelected = false;
        break;
      }
    }

    for (var cow in controller.olderData) {
      cow.isSelectCow.value = !allSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MilkController milkController = Get.put(MilkController());
    final dashboard.DashboardController dashboardController = Get.put(dashboard.DashboardController());

    return WillPopScope(
      onWillPop: () async {
        dashboardController.getReminders();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            leadingIconOnTap: () {
              dashboardController.getReminders();
              Get.back();
            },
            leadingIcon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            centerTitle: true,
            height: 60,
            title: "Medication",
            styleType: Style.bgFillBluegray900,
            actions: [
              IconButton(
                onPressed: () {
                  controller.getUpcomingMedications();
                },
                icon: const Icon(Icons.watch_later_outlined),
                color: Colors.white,
              )
            ],
          ),
          body: Obx(() {
            switch (controller.dataStatus.value) {
              case MedicationDataStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case MedicationDataStatus.error:
                return DataNotFound();
              case MedicationDataStatus.done:
                if (controller.getPendingMedicineDatum.isEmpty) {
                  return DataNotFound();
                }
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Obx(
                        () => CupertinoSegmentedControl(
                          padding: const EdgeInsets.all(10),
                          children: {
                            0: const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 25),
                              child: Text("Vaccine"),
                            ),
                            1: const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 25),
                              child: Text("HEAT"),
                            ),
                            2: const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 25),
                              child: Text("Medical"),
                            ),
                          },
                          groupValue: controller.selectedSegment.value,
                          onValueChanged: (value) {
                            controller.selectedSegment.value = int.parse(value.toString());
                            controller.vaccineController.text = '';
                            controller.selectedVaccineType.value = '';
                            controller.medicationType.text = 'VACCINE';
                            controller.selectCustomTime.value = false;
                            controller.selectCow.value = false;
                          },
                          borderColor: const Color(0xffb232b832),
                          selectedColor: const Color(0xffb232b832),
                          unselectedColor: CupertinoColors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          controller.searchQuery.value = value;
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
                    Obx(
                      () => controller.selectedSegment.value == 0
                          ? CustomDropdown(
                              image: 'assets/images/vaccine 1.png',
                              height: 40,
                              selectedItem: controller.selectedVaccineType.value.isNotEmpty
                                  ? controller.selectedVaccineType.value.obs
                                  : 'Vaccine Type'.obs,
                              text: 'Vaccine Type'.obs,
                              list: vaccines.map((element) => element.value).toList(),
                              onChanged: (value) {
                                controller.selectedVaccineType.value = value.toString();
                                controller.vaccineController.text = value.toString();
                              },
                              clearOnPressed: () {
                                controller.selectedVaccineType.value = '';
                                controller.vaccineController.text = '';
                              },
                            )
                          : const SizedBox(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Obx(
                            () => controller.selectedVaccineType.value.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectToDayAllCows();
                                        controller.medicationType.text = 'VACCINE';
                                        controller.selectCow.value = true;
                                      },
                                      child: const Text(
                                        'Select all',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.green, fontSize: 18),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                    Obx(() {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return toDayListView(index: index, milkController: milkController);
                          },
                          childCount: controller.todayData.length,
                        ),
                      );
                    }),
                    SliverToBoxAdapter(
                      child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Older',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Obx(
                            () => controller.selectedVaccineType.value.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectOlderAllCows();
                                        controller.medicationType.text = 'VACCINE';
                                        controller.selectCow.value = true;
                                      },
                                      child: const Text(
                                        'Select all',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.green, fontSize: 18),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    Obx(
                      () {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return olderListView(index: index, milkController: milkController);
                            },
                            childCount: controller.olderData.length,
                          ),
                        );
                      },
                    ),
                  ],
                );
            }
          }),
          bottomNavigationBar: Obx(
            () => controller.selectedVaccineType.value.isEmpty
                ? const SizedBox()
                : BottomAppBar(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: CustomButton(
                        text: "Select",
                        width: 200,
                        height: 55,
                        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                        variant: ButtonVariant.FillGreen600b2,
                        onTap: () {
                          controller.medicationVaccineName.text = controller.vaccineController.text;
                          controller.medicationNextDoseDate.text =
                              "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
                          controller.AddMedication.clear();
                          Get.toNamed(AppRoutes.multipleMedicationUpdateScreen);
                        },
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget toDayListView({required int index, required MilkController milkController}) {
    return GestureDetector(
      onTap: () {
        controller.ToDayMedicationOnTap(data: controller.todayData[index]);
        controller.medicationCowId.text =
            '${controller.todayData[index].cowId} : ${todayCowName(index: index, milkController: milkController)}';

        controller.nextDoseController =
            DateTime.now().add(Duration(days: int.parse(controller.medicationGapInDay.text)));
        controller.toDateController = controller.nextDoseController.add(const Duration(days: 5));
        controller.medicationNextDoseDate.text =
            "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
        controller.medicationToDateController.text =
            "${DateFormat('dd-MM-yyyy').format(controller.toDateController)}";

        for (var Data in controller.getPendingMedicineDatum) {
          if (controller.todayData[index].medicalId == Data.medicalId) {
            for (int medicinesIndex = 0; medicinesIndex < Data.medicines.length; medicinesIndex++) {
              controller.AddMedication.add(
                StockList(
                  rfoNo: '',
                  vendorId: '01',
                  billNo: '',
                  itemId: Data.medicines[medicinesIndex].itemId,
                  expenceType: 'Medical',
                  qty: '1',
                  kgPerUnit: 0,
                  ratePerUnit: 0,
                  totalWtOrQty: Data.medicines[medicinesIndex].count,
                  totalAmount: 0,
                  isStock: controller.isStock(),
                  itemName: Data.medicines[medicinesIndex].itemName,
                ),
              );
            }
          }
        }
        Get.toNamed(AppRoutes.medicationUpdateScreen);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${controller.todayData[index].cowId} : ${todayCowName(index: index, milkController: milkController) ?? ""}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${convertDateFormat(date: controller.todayData[index].nextDoseTime)}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      toDayType(index: index),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.selectedVaccineType.value.isEmpty
                        ? const SizedBox()
                        : Checkbox(
                            activeColor: const Color(0xff232f34),
                            value: controller.todayData[index].isSelectCow.value,
                            onChanged: (bool? newValue) {
                              controller.ToDayMedicationOnTap(data: controller.todayData[index]);
                              controller.selectCow.value = true;
                              controller.todayData[index].isSelectCow.value = newValue!;
                            },
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Shed ID : ${controller.todayData[index].shedId}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Cow Type : ${controller.todayData[index].cowType}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
              if (controller.todayData[index].remark.toString().isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  '${controller.todayData[index].remark}',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
          ],
        ),
      ),
    );
  }

  Widget olderListView({required int index, required MilkController milkController}) {
    return GestureDetector(
      onTap: () {
        controller.OlderMedicationOnTap(data: controller.olderData[index]);
        controller.medicationCowId.text =
            '${controller.olderData[index].cowId} : ${olderCowName(index: index, milkController: milkController)}';
        controller.nextDoseController =
            DateTime.now().add(Duration(days: int.parse(controller.medicationGapInDay.text)));
        controller.medicationNextDoseDate.text =
            "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
        controller.toDateController = controller.nextDoseController.add(const Duration(days: 5));

        controller.medicationToDateController.text =
            "${DateFormat('dd-MM-yyyy').format(controller.toDateController)}";
        for (var Data in controller.getPendingMedicineDatum) {
          if (controller.olderData[index].medicalId == Data.medicalId) {
            for (var medicinesIndex in Data.medicines) {
              controller.AddMedication.add(
                StockList(
                  rfoNo: '',
                  vendorId: '01',
                  billNo: '',
                  itemId: medicinesIndex.itemId,
                  expenceType: 'Medical',
                  qty: '1',
                  kgPerUnit: 0,
                  ratePerUnit: 0,
                  totalWtOrQty: medicinesIndex.count,
                  totalAmount: 0,
                  isStock: controller.isStock(),
                  itemName: medicinesIndex.itemName,
                ),
              );
            }
          }
        }
        Get.toNamed(AppRoutes.medicationUpdateScreen);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${controller.olderData[index].cowId} : ${olderCowName(index: index, milkController: milkController) ?? ""}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 16,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${convertDateFormat(date: controller.olderData[index].nextDoseTime)}',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        olderType(index: index),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.selectedVaccineType.value.isEmpty
                          ? const SizedBox()
                          : Checkbox(
                              activeColor: const Color(0xff232f34),
                              value: controller.olderData[index].isSelectCow.value,
                              onChanged: (bool? newValue) {
                                controller.OlderMedicationOnTap(data: controller.olderData[index]);
                                controller.selectCow.value = true;
                                controller.olderData[index].isSelectCow.value = newValue!;
                              },
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Shed ID : ${controller.olderData[index].shedId}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Cow Type : ${controller.olderData[index].cowType}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                if (controller.olderData[index].remark.toString().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${controller.olderData[index].remark}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String toDayType({required int index}) {
    if (controller.todayData[index].type == 'HEAT') {
      return '${controller.todayData[index].type} : ${controller.todayData[index].heatAttempt}';
    } else {
      return '${controller.todayData[index].type} : ${controller.todayData[index].vacName} : (${controller.todayData[index].heatAttempt}/${controller.todayData[index].dose})';
    }
  }

  String olderType({required int index}) {
    if (controller.olderData[index].type == 'HEAT') {
      return '${controller.olderData[index].type} : ${controller.olderData[index].heatAttempt}';
    } else {
      return '${controller.olderData[index].type} : ${controller.olderData[index].vacName} : (${controller.olderData[index].heatAttempt}/${controller.olderData[index].dose})';
    }
  }

  Widget DataNotFound() {
    return const Center(
      child: Text(
        "Data Not Found",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  String? todayCowName({required int index, required MilkController milkController}) {
    for (var item in milkController.cowList) {
      if (item.tagId == controller.todayData[index].cowId) {
        return item.calfName;
      }
    }
    return null;
  }

  String? olderCowName({required int index, required MilkController milkController}) {
    for (var item in milkController.cowList) {
      if (item.tagId == controller.olderData[index].cowId) {
        return item.calfName;
      }
    }
    return null;
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);
    String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);
    return formattedDate;
  }
}
