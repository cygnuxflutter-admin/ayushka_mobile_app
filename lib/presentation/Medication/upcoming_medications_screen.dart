import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/presentation/Medication/medication_controller.dart';
import 'package:cattle_app/presentation/milk_screen/controller/milk_controller.dart';

import '../../routes/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../medical_report_screen/models/medicine_update_request.dart';

class UpcomingMedicationScreen extends GetView<MedicationController> {
  const UpcomingMedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MilkController milkController = Get.put(MilkController());

    return Scaffold(
      appBar: CustomAppBar(
        leadingIconOnTap: () {
          Get.back();
        },
        leadingIcon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        centerTitle: true,
        height: 60,
        title: "Upcoming Medication",
        styleType: Style.bgFillBluegray900,
      ),
      body: SafeArea(
        child: Obx(
          () {
            controller.getUpcomingMedication.sort((a, b) => a.nextDoseTime.compareTo(b.nextDoseTime));
            return ListView.builder(
              itemCount: controller.getUpcomingMedication.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      controller.UpComingMedicationCow.value = true;
                      controller.upComingCows.value = true;
                      controller.UpComingMedicationOnTap(data: controller.getUpcomingMedication[index]);
                      controller.medicationCowId.text =
                          '${controller.getUpcomingMedication[index].cowId} : ${CowName(index: index, milkController: milkController)}';
                      controller.nextDoseController =
                          DateTime.now().add(Duration(days: int.parse(controller.medicationGapInDay.text)));
                      controller.toDateController = controller.nextDoseController.add(const Duration(days: 5));
                      controller.medicationNextDoseDate.text =
                          "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
                      controller.medicationNextDoseDateText.value = controller.medicationNextDoseDate.text;
                      controller.medicationToDateController.text =
                          "${DateFormat('dd-MM-yyyy').format(controller.toDateController)}";
                      controller.medicationToDateDateText.value = controller.medicationToDateController.text;
                      for (var Data in controller.getUpcomingMedication) {
                        if (controller.getUpcomingMedication[index].medicalId == Data.medicalId) {
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.getUpcomingMedication[index].cowId} : ${CowName(index: index, milkController: milkController)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.watch_later_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Text(
                                            convertDateFormat(date: controller.getUpcomingMedication[index].nextDoseTime),
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Type(index: index),
                                    ),
                                    Text(
                                      controller.getUpcomingMedication[index].remark,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20, top: 5),
                                  child: Image(
                                    image: AssetImage(controller.getUpcomingMedication[index].type == 'VACCINE'
                                        ? 'assets/images/vaccine.png'
                                        : controller.getUpcomingMedication[index].type == 'HEAT'
                                            ? 'assets/images/heatCow.png'
                                            : 'assets/images/medicine.png'),
                                    height: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String? CowName({required int index, required MilkController milkController}) {
    for (var item in milkController.cowList) {
      if (item.tagId == controller.getUpcomingMedication[index].cowId) {
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

  String Type({required int index}) {
    if (controller.getUpcomingMedication[index].type == 'HEAT') {
      return '${controller.getUpcomingMedication[index].type} : ${controller.getUpcomingMedication[index].heatAttempt}';
    } else {
      return '${controller.getUpcomingMedication[index].type} : ${controller.getUpcomingMedication[index].vacName} : (${controller.getUpcomingMedication[index].heatAttempt}/${controller.getUpcomingMedication[index].dose})';
    }
  }
}
