import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/utils/pref_utils.dart';
import 'package:cattle_app/presentation/sales_entry/sales_entry_controller.dart';
import 'package:cattle_app/widgets/rich_text.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/dropdown/dropdown.dart';
import '../common file/defaultVariablesList.dart';

class SalesEntryScreen extends GetView<SalesEntryController> {
  const SalesEntryScreen({Key? key}) : super(key: key);

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
          title: "Sales Entry",
          actions: [
            Padding(
              padding: getPadding(left: 13, top: 6, right: 13, bottom: 20),
              child: IconButton(
                icon: const Icon(Icons.history, size: 33, color: Colors.white),
                onPressed: () {
                  controller.LastSalesHistory.value = true;
                  controller.SalesTransactionHistory(context);
                },
              ),
            ),
          ],
          styleType: Style.bgFillBluegray900,
        ),
        body: Stack(
          children: [
            Obx(
              () => controller.showSticker.value == true
                  ? Column(
                      children: [
                        RepaintBoundary(
                          key: controller.globalKey,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 3),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(width: 15, child: const Divider(color: Colors.black)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          const Spacer(),
                                          const Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Image(image: AssetImage('assets/images/logo.png'), height: 70),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Obx(() => Text("${controller.salesDataSleepNumber.value}", style: const TextStyle(fontSize: 18))),
                                                Text(controller.DateController.text, style: const TextStyle(color: Colors.grey, fontSize: 18)),
                                                Text(DateFormat('HH:mm:a').format(DateTime.now()), style: const TextStyle(color: Colors.grey, fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 5),
                                      child: Center(
                                        child: Text(
                                          controller.departmentNameController.text,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, top: 10),
                                      child: CattleRichText(text: 'Item Name : ', richText: controller.itemNameController.text, color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, top: 10),
                                      child: CattleRichText(text: 'QTY : ', richText: controller.QTYController.text, color: Colors.grey),
                                    ),
                                    controller.vehicleNumberController.text.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(left: 20, top: 10),
                                            child: CattleRichText(
                                              text: 'Vehicle No. : ',
                                              richText: controller.vehicleNumberController.text,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : const SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, top: 10),
                                      child: CattleRichText(text: 'Mobile NO. : ', richText: controller.mobileController.text, color: Colors.grey),
                                    ),
                                    controller.driverController.text.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(left: 20, top: 10),
                                            child: CattleRichText(text: 'Driver Name : ', richText: controller.driverController.text, color: Colors.grey),
                                          )
                                        : const SizedBox(),
                                    controller.locationController.text.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(left: 20, top: 10),
                                            child: CattleRichText(text: 'Location : ', richText: controller.locationController.text, color: Colors.grey),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(height: 50),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                                            child: Column(
                                              children: const [
                                                Divider(color: Colors.black, height: 36),
                                                Text('Security sign', style: TextStyle(color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                            child: Column(
                                              children: const [
                                                Divider(color: Colors.black, height: 36),
                                                Text('Vendor sign', style: TextStyle(color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  children: [
                    Obx(
                      () => Column(
                        children: [
                          CustomDropdown(
                            image: 'assets/images/department.png',
                            height: 40,
                            selectedItem: controller.departmentNameText,
                            globalKey: controller.departmentNameKey,
                            text: 'Department Name  '.obs,
                            list: departmentName.map((data) => data.value).toList(),
                            onChanged: (value) {
                              controller.departmentNameController.text = value.toString();
                              controller.departmentNameText.value = value.toString();
                              controller.findEmailID(value!);
                              controller.findMobileNo(value);
                            },
                            validator: (value) {
                              if (value == null || value == 'Department Name') {
                                return 'Please Enter Department Name';
                              }
                              return null;
                            },
                          ),
                          CustomDropdown(
                            image: 'assets/images/iteamName.png',
                            height: 40,
                            selectedItem: controller.itemNameText,
                            globalKey: controller.itemNameKey,
                            text: 'Item Name  '.obs,
                            list: salesItem.map((data) => data.itemName).toList(),
                            onChanged: (value) {
                              controller.itemSelect.value = true;
                              controller.itemNameController.text = value.toString();
                              controller.itemNameText.value = value.toString();
                              controller.rateController = TextEditingController(text: '${controller.itemRate().value}');
                            },
                            validator: (value) {
                              if (value == null || value == 'itemName') {
                                return 'Please Enter Item Name';
                              }
                              return null;
                            },
                          ),
                          controller.itemSelect.value == true
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "${controller.itemQty().value} - ${controller.itemUnit().value} @ ${controller.itemRate().value}",
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        children: [
                          const Image(image: AssetImage('assets/images/billDate.png'), height: 40),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Select Date : ',
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorConstant.blueGray9007f, fontSize: 17),
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                datePicker(context: context);
                              },
                              child: Text(
                                controller.dateText.value.isEmpty ? DateFormat('dd-MM-yyyy').format(DateTime.now()) : controller.dateText.value,
                                style: const TextStyle(color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextField(
                      image: 'assets/images/entryQTY.png',
                      height: 40,
                      globalKey: controller.QTYKey,
                      labelText: "QTY",
                      controller: controller.QTYController,
                      hintText: "QTY",
                      textInputType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter QTY';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      image: 'assets/images/mobileNumber.png',
                      height: 40,
                      globalKey: controller.mobileKey,
                      controller: controller.mobileController,
                      hintText: "Mobile Number",
                      labelText: "Mobile Number",
                      textInputType: const TextInputType.numberWithOptions(decimal: true),
                      enabled: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Mobile Number';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      image: 'assets/images/remarkIcon.png',
                      height: 40,
                      globalKey: controller.emailIdKey,
                      controller: controller.emailIdController,
                      hintText: "Email Id",
                      labelText: "Email Id",
                      textInputType: TextInputType.emailAddress,
                      enabled: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email Id';
                        }
                        return null;
                      },
                    ),
                    Column(
                      children: [
                        CustomTextFormField(controller: controller.vehicleNumberController, hintText: "Vehicle Number", labelText: "Vehicle Number"),
                        CustomTextFormField(controller: controller.driverController, hintText: "Driver Name", labelText: "Driver Name"),
                        CustomTextFormField(controller: controller.locationController, hintText: "Location", labelText: "Location"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          const Text("Do You Want to Print Sleep ?", style: TextStyle(color: Color(0xff232f34))),
                          Obx(
                            () => Checkbox(
                              activeColor: Colors.green,
                              value: controller.printSelect.value,
                              onChanged: (bool? newValue) {
                                if (newValue != null) {
                                  PrefUtils.setSelectPrint(newValue);
                                  controller.printSelect.value = newValue;
                                }
                              },
                            ),
                          ),
                          const Text("yes"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10, top: 10),
          child: CustomButton(
            text: "Submit",
            height: 55,
            textStyle: const TextStyle(color: Colors.white, fontSize: 20),
            variant: ButtonVariant.FillBluegray900,
            onTap: () {
              if (controller.departmentNameKey.currentState!.validate() &&
                  controller.itemNameKey.currentState!.validate() &&
                  controller.QTYKey.currentState!.validate() &&
                  controller.mobileKey.currentState!.validate() &&
                  controller.emailIdKey.currentState!.validate()) {
                if (controller.DateController.text.isEmpty) {
                  final formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now().toUtc());
                  controller.DateController.text = formattedDate;
                  controller.dateText.value = formattedDate;
                }
                controller.SalesTransaction(context);
              }
              Future.delayed(const Duration(seconds: 3), () {
                controller.departmentNameController.text = 'Department Name';
                controller.departmentNameText.value = 'Department Name';
                controller.itemNameController.text = 'itemName';
                controller.itemNameText.value = 'Item Name';
              });
            },
          ),
        ),
      ),
    );
  }

  datePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.DateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    controller.dateText.value = DateFormat('dd-MM-yyyy').format(pickedDate);
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);
    String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);
    return formattedDate;
  }
}
