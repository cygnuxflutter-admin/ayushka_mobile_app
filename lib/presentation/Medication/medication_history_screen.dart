import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/Medication/medication_controller.dart';

import '../../widgets/app_bar/custom_app_bar.dart';

class MedicationHistoryScreen extends GetView<MedicationController> {
  const MedicationHistoryScreen({Key? key}) : super(key: key);

  String titleText() {
    if (controller.medicationType.text == 'VACCINE') {
      return 'Vaccine';
    } else if (controller.medicationType.text == 'HEAT') {
      return 'Heat';
    } else {
      return 'Medication';
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
        title: "${titleText()} History",
        styleType: Style.bgFillBluegray900,
      ),
      body: SafeArea(
        child: Obx(
          () => ListView(
            children: [
              controller.medicationType.text == 'VACCINE'
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Vaccine ${controller.medicationVaccineName.text}',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : controller.medicationType.text == 'HEAT'
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Heat',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Left leg fracture',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
              controller.medicineHistoryData.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          "No record found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.medicineHistoryData.length,
                      itemBuilder: (context, index) {
                        final historyItem = controller.medicineHistoryData[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      controller.medicationType.text == 'VACCINE'
                                          ? Text(
                                              'Vaccine-${controller.medicationVaccineName.text}(${controller.medicationAttemptDose.text}/${controller.medicationDose.text})',
                                              style: TextStyle(
                                                  color: Colors.black.withOpacity(0.6),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : controller.medicationType.text == 'HEAT'
                                              ? Text('Heat ${controller.medicationDose.text}',
                                                  style: TextStyle(
                                                      color: Colors.black.withOpacity(0.6),
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
                                                )
                                              : Text(
                                                  'Medication ${controller.medicationDose.text}',
                                                  style: TextStyle(
                                                      color: Colors.black.withOpacity(0.6),
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
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
                                                Icons.calendar_month,
                                              ),
                                              Text(
                                                '${historyItem.date}',
                                                style: const TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                      '${titleText()} added for for his cow is done by ${controller.retrievedData!['user_id']}',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image(
                                      image: AssetImage('assets/images/capsule-icon.webp'),
                                      height: 25,
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: historyItem.items.length,
                                    itemBuilder: (context, ind) {
                                      final subItem = historyItem.items[ind];
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${subItem.itemName}',
                                            style: TextStyle(
                                                color: Colors.black.withOpacity(0.6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${subItem.totalWtOrQty} Qty',
                                            style: TextStyle(
                                                color: Colors.black.withOpacity(0.6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
