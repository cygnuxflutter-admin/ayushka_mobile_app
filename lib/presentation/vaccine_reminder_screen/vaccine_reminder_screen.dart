import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/vaccine_reminder_screen/vaccine_reminder_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/widgets/app_bar/appbar_image.dart';
import 'package:cattle_app/widgets/app_bar/appbar_title.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import 'package:cattle_app/widgets/dropdown/dropdown.dart';
import 'package:cattle_app/presentation/milk_screen/controller/milk_controller.dart';

class VaccineReminderScreen extends GetView<VaccineReminderController> {
  const VaccineReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MilkController milkController = Get.put(MilkController());

    return Scaffold(
      backgroundColor: ColorConstant.whiteA700,
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
        title: "Vaccine Reminders",
        styleType: Style.bgFillBluegray900,
      ),
      body: Column(
        children: [
          CustomDropdown(
            image: 'assets/images/cowType.png',
            height: 40,
            selectedItem: controller.cowIdText.value.isNotEmpty
                ? controller.cowIdText.value.obs
                : null,
            text: 'cowId'.obs,
            list: milkController.cowList
                .map((data) => data.tagId + ' : ' + data.calfName)
                .toList(),
            clearButton: true,
            clearOnPressed: () {
              controller.cowIdController.text = "";
              controller.cowIdText.value = "";
              controller.fetchPendingVaccines(tagId: "");
            },
            onChanged: (value) async {
              if (value != null) {
                String tagId = value.split(' : ')[0];
                controller.cowIdController.text = tagId;
                controller.cowIdText.value = value;
                controller.fetchPendingVaccines(tagId: tagId);
              }
            },
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: SizedBox()); // Loader handled by AppLoader
              }
              if (controller.cowReminders.isEmpty) {
                return const Center(
                  child: Text(
                    "No pending vaccines found.",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Outfit',
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.cowReminders.length,
                padding: getPadding(all: 10),
                itemBuilder: (context, index) {
                  var data = controller.cowReminders[index];
                  return Card(
                    margin: getMargin(bottom: 10),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: getPadding(all: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tag ID: ${data.tagId}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              Container(
                                padding: getPadding(left: 8, right: 8, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  data.type,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getVerticalSize(5)),
                          Text(
                            "Breed: ${data.breed} | Age: ${data.ageInMonths} months",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          SizedBox(height: getVerticalSize(10)),
                          const Text(
                            "Pending Vaccines:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          SizedBox(height: getVerticalSize(5)),
                          ...data.pendingVaccines.map((vaccine) {
                            return Padding(
                              padding: getPadding(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.vaccines, size: 16, color: Colors.redAccent),
                                      SizedBox(width: getHorizontalSize(5)),
                                      Text(
                                        vaccine.vaccineName.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Outfit',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Due: ${vaccine.dueDate.split('T')[0]}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }


}
