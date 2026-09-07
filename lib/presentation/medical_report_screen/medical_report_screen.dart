import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/dashboard_screen/controller/dashboard_controller.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/medical_report_request.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/dropdown/dropdown.dart';
import '../common file/defaultVariablesList.dart';
import '../milk_screen/controller/milk_controller.dart';
import 'medical_report_controller.dart';

class MedicalReportScreen extends GetView<MedicalReportController> {
  const MedicalReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MilkController milkController = Get.put(MilkController());
    final DashboardController dashboardController = Get.put(DashboardController());

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
            title: "Medical",
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.medicalHistory);
                },
                icon: const Icon(Icons.history, color: Colors.white, size: 25),
              ),
            ],
            styleType: Style.bgFillBluegray900,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
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
                      controller.cowIdController.text = 'cowId';
                      controller.vaccineTypeController.text = 'Vaccine Type';
                      controller.shedIDController.text = 'Shed Id';
                      controller.cowTypeController.text = 'Cow Type';
                      controller.cowIdController.clear();
                      controller.vaccineTypeController.clear();
                      controller.gapInDayController.clear();
                      controller.doseController.clear();
                      controller.selectFirstDateController.clear();
                      controller.nextDateController.clear();
                      controller.nextToDateController.clear();
                      controller.typeController.clear();
                      controller.pendingVaccineCowList.clear();
                      controller.AddMedication.clear();
                      controller.isSelectedCows.value = false;

                      controller.cowIdText.value = '';
                      controller.vaccineTypeText.value = '';
                      controller.shedIDText.value = '';
                      controller.cowTypeText.value = '';
                      controller.selectFirstDateText.value = '';

                      controller.selectedSegment.value == 1
                          ? controller.gapInDayController.text = '18'
                          : controller.gapInDayController.text = "1";
                      controller.nextDoseController = DateTime.now()
                          .add(Duration(days: int.parse(controller.gapInDayController.text)));
                      controller.nextDateController.text =
                          "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
                      controller.nextDateText.value = controller.nextDateController.text;
                      controller.toDateController =
                          controller.nextDoseController.add(const Duration(days: 5));
                      controller.nextToDateController.text =
                          "${DateFormat('dd-MM-yyyy').format(controller.toDateController)}";
                      controller.nextToDateText.value = controller.nextToDateController.text;
                    },
                    borderColor: const Color(0xffb232b832),
                    selectedColor: const Color(0xffb232b832),
                    unselectedColor: CupertinoColors.white,
                  ),
                ),
                Obx(
                  () => controller.selectedSegment.value == 0
                      ? vaccineModule(context, milkController)
                      : controller.selectedSegment.value == 1
                          ? hitModule(context, milkController)
                          : checkUpModule(context, milkController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int totalSelectCount() {
    int count = controller.pendingVaccineCowList.where((data) => data.isSelectCow.value).length;
    return count;
  }

  Widget vaccineModule(BuildContext context, MilkController milkController) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomMultiSelectDropdown(
            text: 'cowId',
            image: 'assets/images/cowType.png',
            height: 40,
            list: milkController.cowList.map((data) => data.tagId + ' : ' + data.calfName).toList(),
            onChanged: (List<String> selectedItems) {
              controller.selectedCowIds.value = selectedItems.map((e) => e.split(' : ')[0]).toList();
              controller.selectedCowFullDetails.value = selectedItems;
              controller.isSelectedCows.value = selectedItems.isNotEmpty;
              if (selectedItems.isNotEmpty) {
                  controller.cowIdController.text = selectedItems.first.split(' : ')[0];
                  controller.cowIdText.value = selectedItems.first;
              } else {
                  controller.cowIdController.text = "";
                  controller.cowIdText.value = "";
              }
            },
          ),
          Obx(() {
            if (controller.selectedCowIds.length > 3) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Selected Cows'),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.selectedCowFullDetails.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(controller.selectedCowFullDetails[index]),
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Show selected cow', style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
          CustomMultiSelectDropdown(
            text: 'Vaccine Type',
            image: 'assets/images/vaccine 1.png',
            height: 40,
            list: vaccines.map((element) => element.value).toList(),
            onChanged: (List<String> selectedItems) {
              controller.selectedVaccines.value = selectedItems;
              if (selectedItems.isNotEmpty) {
                  controller.vaccineTypeController.text = selectedItems.first;
                  controller.vaccineTypeText.value = selectedItems.first;
              } else {
                  controller.vaccineTypeController.text = "";
                  controller.vaccineTypeText.value = "";
              }
              controller.isSelectedCows.isTrue?"":
              controller.pendingVaccineCow(context);
            },
          ),
          controller.isSelectedCows.isTrue
              ? const SizedBox()
              : Column(
                  children: [
                    CustomDropdown(
                      image: 'assets/images/shedId.png',
                      height: 40,
                      selectedItem: controller.shedIDText.value.isNotEmpty
                          ? controller.shedIDText.value.obs
                          : null,
                      text: 'Shed Id'.obs,
                      list: shed.map((data) => data.value).toList(),
                      onChanged: (value) {
                        controller.shedIDController.text = value.toString();
                        controller.shedIDText.value = value.toString();
                        controller.pendingVaccineCow(context);
                      },
                      clearOnPressed: () {
                        controller.shedIDController.text = "";
                        controller.shedIDText.value = "";
                        controller.pendingVaccineCow(context);
                      },
                    ),
                    CustomDropdown(
                      image: 'assets/images/cowType.png',
                      height: 40,
                      selectedItem: controller.cowTypeText.value.isNotEmpty
                          ? controller.cowTypeText.value.obs
                          : null,
                      text: 'Cow Type'.obs,
                      list: cowType.map((data) => data.value).toList(),
                      clearOnPressed: () {
                        controller.cowTypeController.text = "";
                        controller.cowTypeText.value = "";
                        controller.pendingVaccineCow(context);
                      },
                      onChanged: (value) {
                        controller.cowTypeController.text = value.toString();
                        controller.cowTypeText.value = value.toString();
                        controller.pendingVaccineCow(context);
                      },
                    ),
                    controller.pendingVaccineCowList.isNotEmpty
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,),
                            onPressed: () {
                              Get.toNamed(AppRoutes.pendingCowScreen);
                            },
                            child: Text(
                              'Select Cow ${totalSelectCount()}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: controller.gapInDayController,
                  hintText: "Gap in day",
                  labelText: "Gap in day",
                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    controller.nextDoseController = DateTime.now()
                        .add(Duration(days: int.parse(controller.gapInDayController.text)));
                    controller.nextDateController.text =
                        "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
                    controller.nextDateText.value = controller.nextDateController.text;
                  },
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: controller.doseController,
                  hintText: "Dose",
                  labelText: "Dose",
                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/billDate.png'),
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Select Date : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.blueGray9007f,
                      fontSize: 17,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    vaccineDatePicker(context: context);
                  },
                  child: Text(
                    controller.selectFirstDateText.value.isEmpty
                        ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                        : controller.selectFirstDateText.value,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          CustomTextField(
            image: 'assets/images/medication 1.png',
            height: 40,
            controller: controller.nextDateController,
            hintText: "Next Dose",
            labelText: "Next Dose",
            textInputType: TextInputType.none,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: GestureDetector(
              onTap: () {
                controller.ItemName();
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      ),
                      elevation: 0,
                      content: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: 15,
                              child: Icon(Icons.close,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => Dropdown(
                                    selectedItem: controller.updateMedicationMedicineNameText.value.isNotEmpty
                                        ? controller.updateMedicationMedicineNameText.value.obs
                                        : null,
                                    globalKey: controller.updateMedicineKey,
                                    text: 'Medicine Name  '.obs,
                                    list: controller.filteredItemList.toList(),
                                    onChanged: (value) async {
                                      controller.updateMedicationMedicineNameController.text = value.toString();
                                      controller.updateMedicationMedicineNameText.value = value.toString();
                                    },
                                    validator: (value) {
                                      if (value == null || value == 'Medicine Name') {
                                        return 'Please Enter Medicine Name ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                CustomTextFormField(
                                  globalKey: controller.updateQtyKey,
                                  controller: controller.updateAddMedicationQtyController,
                                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                                  hintText: "Qty",
                                  labelText: "Qty",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Qty';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CustomButton(
                                    text: "Add",
                                    width: 200,
                                    height: 55,
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    variant: ButtonVariant.FillGreen600b2,
                                    onTap: () {
                                      controller.AddMedication.add(
                                        Medicine(
                                          itemId: controller.MedicineItemId(),
                                          count: double.parse(controller.updateAddMedicationQtyController.text),
                                          itemName: controller.updateMedicationMedicineNameController.text),
                                      );
                                      Future.delayed(
                                        const Duration(milliseconds: 30),
                                        () {
                                          controller.updateMedicationMedicineNameController.text = 'Medicine Name';
                                          controller.updateMedicationMedicineNameText.value = '';
                                          controller.updateAddMedicationQtyController.clear();
                                          Get.back();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffC4CACD),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Medicine',
                      style: TextStyle(
                          color: Color(0xff232f34),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.add_circle,
                      size: 30,
                      color: Color(0xff232f34),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.AddMedication.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${MedicineName(index: index).length <= 10 ? MedicineName(index: index) : MedicineName(index: index).substring(0, 10) + "..."}",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${controller.AddMedication[index].count} Qty',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            controller.AddMedication.removeAt(index);
                          },
                          child: const Icon(Icons.delete, size: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          CustomTextField(
            image: 'assets/images/remarkIcon.png',
            height: 40,
            controller: controller.remarkController,
            hintText: "Remark",
            labelText: "Remark",
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
            child: CustomButton(
              text: "Submit",
              height: 55,
              textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              variant: ButtonVariant.FillBluegray900,
              onTap: () {
                controller.typeController.text = 'VACCINE';
                controller.totalSelectFilter();
                controller.addVaccine(context);
                controller.vaccineTypeController.text = 'Vaccine Type';
                controller.shedIDController.text = 'Shed Id';
                controller.cowTypeController.text = 'Cow Type';
                controller.AllFieldClear();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget hitModule(BuildContext context, MilkController milkController) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDropdown(
            image: 'assets/images/cowType.png',
            height: 40,
            selectedItem: controller.cowIdText.value.isNotEmpty
                ? controller.cowIdText.value.obs
                : null,
            globalKey: controller.cowIdKey,
            text: 'cowId'.obs,
            list: milkController.cowList
                .map((data) => data.tagId + ' : ' + data.calfName)
                .toList(),
            onChanged: (value) async {
              controller.cowIdController.text = value.toString();
              controller.cowIdText.value = value.toString();
            },
            validator: (value) {
              if (value == null || value == 'cowId') {
                return 'Please Enter cowId';
              }
              return null;
            },
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: controller.gapInDayController,
                  hintText: "Gap in day",
                  labelText: "Gap in day",
                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    controller.nextDoseController = DateTime.now().add(Duration(days: int.parse(controller.gapInDayController.text)));
                    controller.nextDateController.text = "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
                    controller.nextDateText.value = controller.nextDateController.text;
                  },
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  globalKey: controller.doseKey,
                  controller: controller.doseController,
                  hintText: "Attempt",
                  labelText: "Attempt",
                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Dose';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/billDate.png'),
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Select Date : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.blueGray9007f,
                      fontSize: 17,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    hitDatePicker(context: context);
                  },
                  child: Text(
                    controller.selectFirstDateText.value.isEmpty
                        ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                        : controller.selectFirstDateText.value,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          CustomTextField(
            image: 'assets/images/medication 1.png',
            height: 40,
            controller: controller.nextDateController,
            hintText: "Next Dose",
            labelText: "Next Dose",
            textInputType: TextInputType.none,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                controller.ItemName();
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      ),
                      elevation: 0,
                      content: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: 15,
                              child: Icon(Icons.close,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => Dropdown(
                                    selectedItem: controller.updateMedicationMedicineNameText.value.isNotEmpty
                                        ? controller.updateMedicationMedicineNameText.value.obs
                                        : null,
                                    globalKey: controller.updateMedicineKey,
                                    text: 'Medicine Name  '.obs,
                                    list: controller.filteredItemList.toList(),
                                    onChanged: (value) async {
                                      controller.updateMedicationMedicineNameController.text = value.toString();
                                      controller.updateMedicationMedicineNameText.value = value.toString();
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value == 'Medicine Name') {
                                        return 'Please Enter Medicine Name ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                CustomTextFormField(
                                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                                  globalKey: controller.updateQtyKey,
                                  controller: controller.updateAddMedicationQtyController,
                                  hintText: "Qty",
                                  labelText: "Qty",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Qty';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CustomButton(
                                    text: "Add",
                                    width: 200,
                                    height: 55,
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    variant: ButtonVariant.FillGreen600b2,
                                    onTap: () {
                                      controller.AddMedication.add(
                                        Medicine(
                                          itemId: controller.MedicineItemId(),
                                          count: double.parse(controller.updateAddMedicationQtyController.text),
                                          itemName: controller.updateMedicationMedicineNameController.text,
                                        ),
                                      );
                                      Future.delayed(
                                        const Duration(milliseconds: 30),
                                        () {
                                          controller.updateMedicationMedicineNameController.text = 'Medicine Name';
                                          controller.updateMedicationMedicineNameText.value = '';
                                          controller.updateAddMedicationQtyController.clear();
                                          Get.back();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffC4CACD),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Medicine',
                      style: TextStyle(
                          color: Color(0xff232f34),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.add_circle,
                      size: 30,
                      color: Color(0xff232f34),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.AddMedication.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${MedicineName(index: index).length <= 10 ? MedicineName(index: index) : MedicineName(index: index).substring(0, 10) + "..."}",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${controller.AddMedication[index].count} Qty',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            controller.AddMedication.removeAt(index);
                          },
                          child: const Icon(Icons.delete, size: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          CustomTextField(
            image: 'assets/images/remarkIcon.png',
            height: 40,
            controller: controller.remarkController,
            hintText: "Remark",
            labelText: "Remark",
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
            child: CustomButton(
              text: "Submit",
              height: 55,
              textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              variant: ButtonVariant.FillBluegray900,
              onTap: () {
                controller.typeController.text = 'HEAT';
                if (controller.cowIdKey.currentState!.validate() &&
                    controller.doseKey.currentState!.validate()) {
                  controller.addVaccine(context);
                }
                controller.cowIdController.text = 'cowId';
                controller.vaccineTypeController.text = 'Vaccine Type';
                controller.AllFieldClear();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget checkUpModule(BuildContext context, MilkController milkController) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDropdown(
            image: 'assets/images/cowType.png',
            height: 40,
            selectedItem: controller.cowIdText.value.isNotEmpty
                ? controller.cowIdText.value.obs
                : null,
            globalKey: controller.cowIdKey,
            text: 'cowId'.obs,
            list: milkController.cowList.map((data) => data.tagId + ' : ' + data.calfName).toList(),
            onChanged: (value) async {
              controller.cowIdController.text = value.toString();
              controller.cowIdText.value = value.toString();
            },
            validator: (value) {
              if (value == null || value == 'cowId') {
                return 'Please Enter cowId';
              }
              return null;
            },
          ),
          CustomTextField(
            image: 'assets/images/medicine 1.png',
            height: 40,
            globalKey: controller.medicineNameKey,
            controller: controller.medicineNameController,
            hintText: "Medicine Name",
            labelText: "Medicine Name",
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Medicine Name';
              }
              return null;
            },
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: controller.gapInDayController,
                  hintText: "Gap in day",
                  labelText: "Gap in day",
                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    controller.nextDoseController = DateTime.now().add(Duration(days: int.parse(controller.gapInDayController.text)));
                    controller.nextDateController.text = "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
                    controller.nextDateText.value = controller.nextDateController.text;
                    controller.toDateController = controller.nextDoseController.add(const Duration(days: 5));
                    controller.nextToDateController.text = "${DateFormat('dd-MM-yyyy').format(controller.toDateController)}";
                    controller.nextToDateText.value = controller.nextToDateController.text;
                  },
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  globalKey: controller.doseKey,
                  controller: controller.doseController,
                  hintText: "Dose",
                  labelText: "Dose",
                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Dose';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/billDate.png'),
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Select Date : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.blueGray9007f,
                      fontSize: 17,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    checkUpDatePicker(context: context);
                  },
                  child: Text(
                    controller.selectFirstDateText.value.isEmpty
                        ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                        : controller.selectFirstDateText.value,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          CustomTextField(
            image: 'assets/images/medication 1.png',
            height: 40,
            controller: controller.nextDateController,
            hintText: "Next Dose",
            labelText: "Next Dose",
            textInputType: TextInputType.none,
          ),
          CustomTextField(
            image: 'assets/images/medication 1.png',
            height: 40,
            controller: controller.nextToDateController,
            hintText: "To Date",
            labelText: "To Date",
            textInputType: TextInputType.none,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                controller.ItemName();
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      ),
                      elevation: 0,
                      content: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: 15,
                              child: Icon(Icons.close,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => Dropdown(
                                    selectedItem: controller.updateMedicationMedicineNameText.value.isNotEmpty
                                        ? controller.updateMedicationMedicineNameText.value.obs
                                        : null,
                                    globalKey: controller.updateMedicineKey,
                                    text: 'Medicine Name  '.obs,
                                    list: controller.filteredItemList.toList(),
                                    onChanged: (value) async {
                                      controller.updateMedicationMedicineNameController.text = value.toString();
                                      controller.updateMedicationMedicineNameText.value = value.toString();
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value == 'Medicine Name') {
                                        return 'Please Enter Medicine Name ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                CustomTextFormField(
                                  globalKey: controller.updateQtyKey,
                                  controller: controller.updateAddMedicationQtyController,
                                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                                  hintText: "Qty",
                                  labelText: "Qty",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Qty';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CustomButton(
                                    text: "Add",
                                    width: 200,
                                    height: 55,
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    variant: ButtonVariant.FillGreen600b2,
                                    onTap: () {
                                      controller.AddMedication.add(
                                        Medicine(
                                          itemId: controller.MedicineItemId(),
                                          count: double.parse(controller.updateAddMedicationQtyController.text),
                                          itemName: controller.updateMedicationMedicineNameController.text,
                                        ),
                                      );
                                      Future.delayed(
                                        const Duration(milliseconds: 30),
                                        () {
                                          controller.updateMedicationMedicineNameController.text = 'Medicine Name';
                                          controller.updateMedicationMedicineNameText.value = '';
                                          controller.updateAddMedicationQtyController.clear();
                                          Get.back();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffC4CACD),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Medicine',
                      style: TextStyle(
                          color: Color(0xff232f34),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.add_circle,
                      size: 30,
                      color: Color(0xff232f34),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.AddMedication.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${MedicineName(index: index).length <= 10 ? MedicineName(index: index) : MedicineName(index: index).substring(0, 10) + "..."}",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${controller.AddMedication[index].count} Qty',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            controller.AddMedication.removeAt(index);
                          },
                          child: const Icon(Icons.delete, size: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          CustomTextField(
            image: 'assets/images/remarkIcon.png',
            height: 40,
            controller: controller.remarkController,
            hintText: "Remark",
            labelText: "Remark",
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
            child: CustomButton(
              text: "Submit",
              height: 55,
              textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              variant: ButtonVariant.FillBluegray900,
              onTap: () {
                controller.typeController.text = 'MEDICALCHECKUP';
                if (controller.cowIdKey.currentState!.validate() &&
                    controller.medicineNameKey.currentState!.validate() &&
                    controller.doseKey.currentState!.validate()) {
                  controller.addVaccine(context);
                }
                controller.cowIdController.text = 'cowId';
                controller.vaccineTypeController.text = 'Vaccine Type';
                controller.AllFieldClear();
              },
            ),
          ),
        ],
      ),
    );
  }

  void vaccineDatePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.selectFirstDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate).toString();
    controller.selectFirstDateText.value = controller.selectFirstDateController.text;
    controller.nextDoseController = pickedDate.add(Duration(days: int.parse(controller.gapInDayController.text)));
    controller.nextDateController.text = "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
    controller.nextDateText.value = controller.nextDateController.text;
  }

  void hitDatePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.selectFirstDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate).toString();
    controller.selectFirstDateText.value = controller.selectFirstDateController.text;
    controller.nextDoseController = pickedDate.add(Duration(days: int.parse(controller.gapInDayController.text)));
    controller.nextDateController.text = "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
    controller.nextDateText.value = controller.nextDateController.text;
  }

  void checkUpDatePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.selectFirstDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate).toString();
    controller.selectFirstDateText.value = controller.selectFirstDateController.text;
    controller.nextDoseController = pickedDate.add(Duration(days: int.parse(controller.gapInDayController.text)));
    controller.nextDateController.text = "${DateFormat('dd-MM-yyyy').format(controller.nextDoseController)}";
    controller.nextDateText.value = controller.nextDateController.text;
    controller.toDateController = controller.nextDoseController.add(const Duration(days: 5));
    controller.nextToDateController.text = "${DateFormat('dd-MM-yyyy').format(controller.toDateController)}";
    controller.nextToDateText.value = controller.nextToDateController.text;
  }

  String MedicineName({required int index}) {
    for (var item in itemMaster) {
      if (item.itemId == controller.AddMedication[index].itemId) {
        return item.itemName;
      }
    }
    return '';
  }
}
