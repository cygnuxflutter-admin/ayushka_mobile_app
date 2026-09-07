import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:cattle_app/core/utils/color_constant.dart';
import 'package:cattle_app/core/utils/size_utils.dart';
import 'package:cattle_app/presentation/common%20file/defaultVariablesList.dart';
import 'package:cattle_app/presentation/sales_entry/sales_entry_controller.dart';

import 'package:cattle_app/widgets/custom_button.dart';
import 'package:cattle_app/widgets/dropdown/dropdown.dart';
import 'package:cattle_app/widgets/rich_text.dart';

import '../../widgets/app_bar/custom_app_bar.dart';

class SalesTransactionScreen extends GetView<SalesEntryController> {
  const SalesTransactionScreen({Key? key}) : super(key: key);

  String convertDateFormat({required String date}) {
    try {
      DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);
      String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);
      return formattedDate;
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: "Sales History",
          actions: [
            Padding(
              padding: getPadding(left: 13, top: 6, right: 13, bottom: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  size: 28,
                  color: Colors.white,
                ),
                onPressed: () {
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
                                child: Icon(Icons.close, color: Colors.black, size: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 0, right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Start Date : ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.blueGray9007f,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Spacer(),
                                        TimePickerSpinnerPopUp(
                                          mode: CupertinoDatePickerMode.date,
                                          initTime: DateTime.now(),
                                          maxTime: DateTime.now().add(const Duration(days: 10)),
                                          barrierColor: Colors.black12,
                                          minuteInterval: 1,
                                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                          cancelText: 'Cancel',
                                          confirmText: 'OK',
                                          pressType: PressType.singlePress,
                                          timeFormat: 'dd-MM-yyyy',
                                          onChange: (dateTime) {
                                            controller.StartDateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 0, right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'End Date : ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.blueGray9007f,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Spacer(),
                                        TimePickerSpinnerPopUp(
                                          mode: CupertinoDatePickerMode.date,
                                          initTime: DateTime.now(),
                                          maxTime: DateTime.now().add(const Duration(days: 10)),
                                          barrierColor: Colors.black12,
                                          minuteInterval: 1,
                                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                          cancelText: 'Cancel',
                                          confirmText: 'OK',
                                          pressType: PressType.singlePress,
                                          timeFormat: 'dd-MM-yyyy',
                                          onChange: (dateTime) {
                                            controller.EndDateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => Dropdown(
                                      selectedItem: controller.itemNameText,
                                      text: 'Item Name  '.obs,
                                      list: salesItem.map((data) => data.itemName).toList(),
                                      onChanged: (value) async {
                                        controller.itemNameController.text = value.toString();
                                        controller.itemNameText.value = value.toString();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CustomButton(
                                      text: "Apply",
                                      width: 200,
                                      height: 55,
                                      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                                      variant: ButtonVariant.FillGreen600b2,
                                      onTap: () {
                                        controller.LastSalesHistory.value = false;
                                        controller.SalesTransactionHistory(context);
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
              ),
            ),
          ],
          styleType: Style.bgFillBluegray900,
        ),
        body: Stack(
          children: [
            Obx(
              () => controller.showHistorySticker.value == true
                  ? Column(
                      children: [
                        RepaintBoundary(
                          key: controller.historyGlobalKey,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey, width: 3)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      width: 15,
                                      child: const Divider(
                                        color: Colors.black,
                                      )),
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
                                                child: Image(
                                                  image: AssetImage(
                                                    'assets/images/img_printLogo.png',
                                                  ),
                                                  height: 70,
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  controller.sleepNumber.value.toString(),
                                                  style: const TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  controller.date.value,
                                                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                                                ),
                                                Text(
                                                  controller.time.value,
                                                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                                                ),
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
                                        controller.dName.value,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, top: 10),
                                      child: CattleRichText(
                                        text: 'Item Name : ',
                                        richText: controller.itemName.value,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, top: 10),
                                      child: CattleRichText(
                                        text: 'QTY : ',
                                        richText: controller.qty.toString(),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    controller.vehicleNumber.value.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(left: 20, top: 10),
                                            child: CattleRichText(
                                              text: 'Vehicle No. : ',
                                              richText: controller.vehicleNumber.value,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : const SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, top: 10),
                                      child: CattleRichText(
                                        text: 'Mobile NO. : ',
                                        richText: controller.mobileNumber.value,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    controller.driverName.value.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(left: 20, top: 10),
                                            child: CattleRichText(
                                              text: 'Driver Name : ',
                                              richText: controller.driverName.value,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : const SizedBox(),
                                    controller.location.value.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(left: 20, top: 10),
                                            child: CattleRichText(
                                              text: 'Location : ',
                                              richText: controller.location.value,
                                              color: Colors.grey,
                                            ),
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
                                                Text(
                                                  'Security sign',
                                                  style: TextStyle(color: Colors.grey),
                                                ),
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
                                                  Text(
                                                    'Vendor sign',
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                ],
                                              )),
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
              height: double.infinity,
              color: Colors.white,
              child: Obx(
                () => controller.SalesHistory.isEmpty
                    ? Center(
                        child: Text(
                          "No record found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.SalesHistory.length,
                        itemBuilder: (context, index) {
                          final item = controller.SalesHistory[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          controller.showHistorySticker.value = true;
                                          controller.historyGlobalKey = item.historyGlobalKey;
      
                                          controller.dName.value = item.departmentName;
                                          controller.itemName.value = item.itemName;
                                          controller.qty.value = item.qty;
                                          controller.rate.value = item.rate;
                                          controller.mobileNumber.value = item.mobileNumber;
                                          controller.vehicleNumber.value = item.vehicleNumber;
                                          controller.driverName.value = item.driverName;
                                          controller.date.value = convertDateFormat(date: item.date);
                                          controller.sleepNumber.value = item.sleepNumber;
                                          controller.time.value = item.time;
                                          controller.location.value = item.location;
      
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            controller.captureAndSaveHistoryScreenshot(
                                              context: context,
                                              historyGlobalKey: item.historyGlobalKey,
                                            );
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.print,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    CattleRichText(
                                      text: 'Sleep Number : ',
                                      fontSize1: 14,
                                      color: const Color(0xff262626),
                                      richText: '${item.sleepNumber}',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    CattleRichText(
                                      text: 'Item Name : ',
                                      fontSize1: 14,
                                      color: const Color(0xff262626),
                                      richText: '${item.itemName}',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    CattleRichText(
                                      text: 'Department Name : ',
                                      fontSize1: 14,
                                      color: const Color(0xff262626),
                                      richText: '${item.departmentName}',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    CattleRichText(
                                      text: 'Mobile Number : ',
                                      fontSize1: 14,
                                      color: const Color(0xff262626),
                                      richText: '${item.mobileNumber}',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    CattleRichText(
                                      text: 'QTY : ',
                                      fontSize1: 14,
                                      color: const Color(0xff262626),
                                      richText: '${item.qty}',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    item.driverName.isNotEmpty
                                        ? CattleRichText(
                                            text: 'Driver Name : ',
                                            fontSize1: 14,
                                            color: const Color(0xff262626),
                                            richText: '${item.driverName}',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )
                                        : const SizedBox(),
                                    item.vehicleNumber.isNotEmpty
                                        ? CattleRichText(
                                            text: 'Vehicle Number : ',
                                            fontSize1: 14,
                                            color: const Color(0xff262626),
                                            richText: '${item.vehicleNumber}',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )
                                        : const SizedBox(),
                                    item.location.isNotEmpty
                                        ? CattleRichText(
                                            text: 'Location : ',
                                            fontSize1: 14,
                                            color: const Color(0xff262626),
                                            richText: '${item.location}',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )
                                        : const SizedBox(),
                                    CattleRichText(
                                      text: 'Date : ',
                                      fontSize1: 14,
                                      color: const Color(0xff262626),
                                      richText: convertDateFormat(date: item.date),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    CattleRichText(
                                      text: 'Time : ',
                                      fontSize1: 14,
                                      color: const Color(0xff262626),
                                      richText: '${item.time}',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
