import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/Medication/medication_controller.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import 'package:cattle_app/widgets/dropdown/dropdown.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../common file/defaultVariablesList.dart';
import '../medical_report_screen/models/medicine_update_request.dart';

class MedicationUpdateScreen extends GetView<MedicationController> {
  const MedicationUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.upComingCows.value = false;
        controller.UpComingMedicationCow.value = false;
        controller.getPendingMedicineDatum.clear();
        controller.AddMedication.clear();
        controller.addMedicationRemarkController.clear();
        controller.getPendingMedicine();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            leadingIconOnTap: () {
              controller.upComingCows.value = false;
              controller.UpComingMedicationCow.value = false;
              controller.getPendingMedicineDatum.clear();
              controller.AddMedication.clear();
              controller.addMedicationRemarkController.clear();
              controller.getPendingMedicine();
              Get.back();
            },
            leadingIcon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            centerTitle: true,
            height: 60,
            title: "${Title()} Update",
            styleType: Style.bgFillBluegray900,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(
              () => ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        controller.medicationCowId.text,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  controller.medicationType.text == 'VACCINE'
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${controller.medicationVaccineName.text} (${controller.medicationAttemptDose.text}/${controller.medicationDose.text})',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    '${Title()} Details',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  controller.medicationType.text == 'VACCINE'
                      ? VaccineUpdate(context)
                      : controller.medicationType.text == 'HEAT'
                          ? HeatUpdate(context)
                          : MedicationUpdate(context),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Medicine',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.ItemName();
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => WillPopScope(
                                  onWillPop: () async => false,
                                  child: AlertDialog(
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22.0)),),
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
                                            child: Icon(Icons.close, color: Colors.black, size: 20),
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
                                                  selectedItem: controller.medicationMedicineNameController.text.obs.isNotEmpty
                                                      ? controller.medicationMedicineNameController.text.obs
                                                      : 'Medicine Name'.obs,
                                                  globalKey: controller.MedicineKey,
                                                  text: 'Medicine Name  '.obs,
                                                  list: controller.filteredItemList,
                                                  onChanged: (value) async {
                                                    controller.medicationMedicineNameController.text = value.toString();
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
                                                globalKey: controller.QtyKey,
                                                controller: controller.addMedicationQtyController,
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
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  variant: ButtonVariant.FillGreen600b2,
                                                  onTap: () {
                                                    controller.AddMedication.add(
                                                      StockList(
                                                        rfoNo: '',
                                                        vendorId: '01',
                                                        billNo: '',
                                                        itemId: controller.itemId(),
                                                        expenceType: 'Medical',
                                                        qty: '1',
                                                        kgPerUnit: 0,
                                                        ratePerUnit: 0,
                                                        totalWtOrQty: double.parse(controller.addMedicationQtyController.text),
                                                        totalAmount: 0,
                                                        isStock: controller.isStock(),
                                                        itemName: controller.medicationMedicineNameController.text,
                                                      ),
                                                    );
                                                    controller.addNewMedicine();
                                                    Future.delayed(
                                                      const Duration(milliseconds: 30),
                                                      () {
                                                        controller.medicationMedicineNameController.text = 'Medicine Name';
                                                        controller.addMedicationQtyController.clear();
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
                            icon: const Icon(
                              Icons.add_circle,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.AddMedication.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
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
                                  '${controller.AddMedication[index].totalWtOrQty} Qty',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    controller.removeMedicine(
                                        itemId: controller.AddMedication[index].itemId,
                                        medicalId: int.parse(controller.medicationMedicalIdController.text));
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
                  controller.medicationType.text == 'HEAT'
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.green,
                                value: controller.isPregnant.value,
                                onChanged: (bool? newValue) {
                                  controller.isPregnant.value = newValue!;
                                },
                              ),
                              const Text(
                                'is Pregnant',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Enter Remark',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: 80, // <-- TextField height
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        controller: controller.addMedicationRemarkController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Remark".tr,
                          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 3),),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 3),),
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 3),),
                          hintStyle: const TextStyle(fontSize: 18, fontFamily: 'Outfit',),
                        ),
                      ),
                    ),
                  ),
                  controller.medicationType.text == 'VACCINE'
                      ? Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: CustomButton(
                                  text: "Stop",
                                  width: 200,
                                  height: 60,
                                  textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                                  variant: ButtonVariant.FillRed600b2,
                                  onTap: () {
                                    controller.medicationStatusController.text = 'STOP';
                                    controller.medicineUpdate(context);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: CustomButton(
                                  text: "Update",
                                  width: 200,
                                  height: 60,
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  variant: ButtonVariant.FillGreen600b2,
                                  onTap: () {
                                    controller.medicationStatusController.text = 'RUNNING';
                                    controller.medicineUpdate(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : controller.medicationType.text == 'HEAT'
                          ? Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: CustomButton(
                                      text: "Stop",
                                      width: 200,
                                      height: 60,
                                      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                                      variant: ButtonVariant.FillRed600b2,
                                      onTap: () {
                                        controller.medicationStatusController.text = 'STOP';
                                        controller.medicineUpdate(context);
                                      },
                                    ),
                                  ),
                                ),
                                if (controller.isPregnant.value == true) ...{
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CustomButton(
                                        text: "Complete",
                                        width: 200,
                                        height: 60,
                                        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                                        variant: ButtonVariant.FillGreen600b2,
                                        onTap: () {
                                          controller.medicationStatusController.text = 'COMPLETED';
                                          controller.medicineUpdate(context);
                                        },
                                      ),
                                    ),
                                  ),
                                } else ...{
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CustomButton(
                                        text: "Skip",
                                        width: 200,
                                        height: 60,
                                        textStyle: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                        variant: ButtonVariant.FillOrenj900,
                                        onTap: () {
                                          controller.medicationStatusController.text = 'RUNNING';
                                          controller.medicineUpdate(context);
                                        },
                                      ),
                                    ),
                                  ),
                                }
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: CustomButton(
                                      text: "Stop",
                                      width: 200,
                                      height: 60,
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      variant: ButtonVariant.FillRed600b2,
                                      onTap: () {
                                        controller.medicationStatusController.text = 'STOP';
                                        controller.medicineUpdate(context);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: CustomButton(
                                      text: "Done",
                                      width: 200,
                                      height: 60,
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      variant: ButtonVariant.FillGreen600b2,
                                      onTap: () {
                                        controller.medicationStatusController.text = 'RUNNING';
                                        controller.medicineUpdate(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String Title() {
    if (controller.medicationType.text == 'VACCINE') {
      return 'Vaccine';
    } else if (controller.medicationType.text == 'HEAT') {
      return 'Heat';
    } else {
      return 'Medication';
    }
  }

  Widget VaccineUpdate(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Vaccine Name : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              controller.medicationVaccineName.text,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Attempt Dose : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${controller.medicationAttemptDose.text}/${controller.medicationDose.text}',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            controller.medicationAttemptDose.text == '0'
                ? const SizedBox()
                : InkWell(
                    onTap: () {
                      controller.medicineHistory(medicalId: int.parse(controller.medicationMedicalIdController.text));
                      Get.toNamed(AppRoutes.medicationHistoryScreen);
                    },
                    child: const Text(
                      'check history >>',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Gap Between Dose : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${controller.medicationGapInDay.text} Days',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Next Dose Time : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Checkbox(
              activeColor: const Color(0xff232f34),
              value: controller.selectCustomTime.value,
              onChanged: (bool? newValue) {
                controller.selectCustomTime.value = newValue!;
              },
            ),
          ],
        ),
        controller.selectCustomTime.value == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Next Dose Time : ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      onTapToDateDate(context: context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: const BorderRadius.all(Radius.circular(7),),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                            ),
                            Text(
                              controller.medicationNextDoseDateText.value,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Next Dose Time : ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month, color: Colors.black38),
                          Text(
                            controller.medicationNextDoseDateText.value,
                            style: const TextStyle(fontSize: 18, color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Widget HeatUpdate(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Heat Attempt : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              controller.medicationAttemptDose.text,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            controller.medicationAttemptDose.text == '0'
                ? const SizedBox()
                : InkWell(
                    onTap: () {
                      controller.medicineHistory(
                          medicalId: int.parse(controller.medicationMedicalIdController.text));
                      Get.toNamed(AppRoutes.medicationHistoryScreen);
                    },
                    child: const Text(
                      'check history >>',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Heat Period: ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${controller.medicationGapInDay.text} Days',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Next Heat Time : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Checkbox(
              activeColor: const Color(0xff232f34),
              value: controller.selectCustomTime.value,
              onChanged: (bool? newValue) {
                controller.selectCustomTime.value = newValue!;
              },
            ),
          ],
        ),
        controller.selectCustomTime.value == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Next Heat Time : ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      onTapToDateDate(context: context);
                    },
                    child: Container(
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
                              controller.medicationNextDoseDateText.value,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Next Heat Time : ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
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
                            color: Colors.black38,
                          ),
                          Text(
                            controller.medicationNextDoseDateText.value,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        controller.selectCustomTime.value == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Time Period: ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
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
                              controller.medicationToDateDateText.value,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Time Period: ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
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
                              color: Colors.black38,
                            ),
                            Text(
                              controller.medicationToDateDateText.value,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Widget MedicationUpdate(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Description : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              controller.medicationVaccineName.text,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Attempted Inspection : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${controller.medicationAttemptDose.text}/${controller.medicationDose.text}',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        controller.medicationAttemptDose.text == '0'
            ? const SizedBox()
            : Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    controller.medicineHistory(
                        medicalId: int.parse(controller.medicationMedicalIdController.text));
                    Get.toNamed(AppRoutes.medicationHistoryScreen);
                  },
                  child: const Text(
                    'check history >>',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Gap Between Inspection : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${controller.medicationGapInDay.text} Days',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Next Dose Time : ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Checkbox(
              activeColor: const Color(0xff232f34),
              value: controller.selectCustomTime.value,
              onChanged: (bool? newValue) {
                controller.selectCustomTime.value = newValue!;
              },
            ),
          ],
        ),
        controller.selectCustomTime.value == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Next Dose Time : ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      onTapToDateDate(context: context);
                    },
                    child: Container(
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
                              controller.medicationNextDoseDateText.value,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Next Dose Time : ',
                    style: TextStyle(
                        color: Colors.grey,
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
                            color: Colors.black38,
                          ),
                          Text(
                            controller.medicationNextDoseDateText.value,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  void onTapToDateDate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now().add(Duration(
          days: controller.UpComingMedicationCow.isTrue ? 0 : 1)),
      initialDate: DateTime.now().add(Duration(
          days: controller.UpComingMedicationCow.isTrue ? 0 : 1)),
    );
    if (pickedDate == null) return;
    controller.medicationNextDoseDate.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    controller.medicationNextDoseDateText.value = controller.medicationNextDoseDate.text;
    DateTime currentMedicationDate = DateTime.parse(pickedDate.toString());
    controller.toDateController = currentMedicationDate.add(const Duration(days: 5));
    controller.medicationToDateController.text =
        "${DateFormat('dd-MM-yyyy').format(controller.toDateController)}";
    controller.medicationToDateDateText.value = controller.medicationToDateController.text;
  }

  String MedicineName({required index}) {
    for (var item in itemMaster) {
      if (item.itemId == controller.AddMedication[index].itemId) {
        return item.itemName;
      }
    }
    return '';
  }
}
