import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/medical_report_screen/medical_report_controller.dart';
import 'package:cattle_app/presentation/medical_report_screen/models/medicine_update_request.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/dropdown/dropdown.dart';

class MedicalUpdateScreen extends GetView<MedicalReportController> {
  const MedicalUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white),
          centerTitle: true,
          height: 60,
          title: "Medical Update Report",
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.addMedicineHistory);
              },
              icon: const Icon(
                Icons.history,
              ),
            ),
          ],
          styleType: Style.bgFillBluegray900,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller.updateCowIdController,
                hintText: "Cow ID",
                labelText: "Cow ID",
                textInputType: TextInputType.none,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.updateVaccineNameController,
                      hintText: "Vaccine Name",
                      labelText: "Vaccine Name",
                      textInputType: TextInputType.none,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.updateDoseController,
                      hintText: "Dose",
                      labelText: "Dose",
                      textInputType: TextInputType.none,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.updateGapInDayController,
                      hintText: "Gap in day",
                      labelText: "Gap in day",
                      textInputType: TextInputType.none,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.updateTypeController,
                      hintText: "Type",
                      labelText: "Type",
                      textInputType: TextInputType.none,
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                controller: controller.updateStatusController,
                hintText: "Status",
                labelText: "Status",
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.updateToDateController,
                      hintText: "To Date",
                      labelText: "To Date",
                      textInputType: TextInputType.none,
                      onTap: () => onTapToDateDate(context: context),
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.updateNextDoseDateController,
                      hintText: "Next Dose Date",
                      labelText: "Next Dose Date",
                      textInputType: TextInputType.none,
                      onTap: () => onTapNextDoseDate(context: context),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.updateDoseDateController,
                      hintText: "Dose Date",
                      labelText: "Dose Date",
                      textInputType: TextInputType.none,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.updateHeatAttemptController,
                      hintText: "Heat Attempt",
                      labelText: "Heat Attempt",
                      textInputType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                controller: controller.updateRemarkController,
                hintText: "Remark",
                labelText: "Remark",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 3,
                      color: ColorConstant.indigo200,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: const Text(
                          "Add Medicine",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        labelText: "Expens Type",
                        controller: controller.updateStockExpensTypeController,
                        hintText: "Expens Type",
                        textInputType: TextInputType.none,
                      ),
                      Obx(
                        () => Dropdown(
                          selectedItem: controller.updateStockItemNameText,
                          globalKey: controller.updateStockItemNameKey,
                          text: 'itemName  '.obs,
                          list: controller.filteredItemList,
                          onChanged: (value) async {
                            controller.updateStockItemNameController.text = value.toString();
                            controller.updateStockItemNameText.value = value.toString();
                            controller.OUTUnitType();
                          },
                          validator: (value) {
                            if (value == null || value == 'itemName') {
                              return 'Please Enter itemName ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          globalKey: controller.updateStockTotalWtOrQtyKey,
                          controller: controller.updateStockTotalWtOrQtyController,
                          hintText: "Total ${controller.OUTUnitType().value}",
                          labelText: "Total ${controller.OUTUnitType().value}",
                          textInputType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Total Weight ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomTextFormField(
                          labelText: "Remark",
                          controller: controller.updateMedicalLogRemarkController,
                          hintText: "Remark",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                  text: "Continue",
                  width: 200,
                  height: 55,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                  variant: ButtonVariant.FillGreen600b2,
                  onTap: () {
                    controller.stockList.add(
                      StockList(
                        rfoNo: '',
                        vendorId: '01',
                        billNo: '',
                        itemId: controller.itemId(),
                        expenceType: 'Medical',
                        qty: '1',
                        kgPerUnit: 0,
                        ratePerUnit: 0,
                        totalWtOrQty: controller.updateStockTotalWtOrQtyController.text == '' ||
                                controller.updateStockTotalWtOrQtyController.text.isEmpty ? 0
                            : double.parse(controller.updateStockTotalWtOrQtyController.text),
                        totalAmount: 0,
                        isStock: controller.isStock(),
                        itemName: controller.updateStockItemNameController.text,
                      ),
                    );
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        controller.updateStockItemNameController.text = 'itemName';
                        controller.updateStockItemNameText.value = 'itemName';
                        controller.updateStockTotalWtOrQtyController.text = '';
                        controller.updateMedicalLogRemarkController.text = '';
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapNextDoseDate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(3000),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.updateNextDoseDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }

  onTapToDateDate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(3000),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.updateToDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }
}
