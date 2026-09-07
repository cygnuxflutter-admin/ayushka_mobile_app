import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:cattle_app/core/utils/size_utils.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import 'package:cattle_app/widgets/rich_text.dart';

import '../../core/utils/color_constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dropdown/dropdown.dart';
import 'controller/dairy_usage_controller.dart';

class DairyUsageHistoryScreen extends GetView<DairyUsageController> {
  const DairyUsageHistoryScreen({Key? key}) : super(key: key);

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
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white),
          centerTitle: true,
          height: 60,
          title: "Dairy Usage History",
          actions: [
            Padding(
              padding: getPadding(left: 13, top: 6, right: 13, bottom: 20),
              child: IconButton(
                icon: const Icon(Icons.filter_alt_outlined, size: 28, color: Colors.white),
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
                                            controller.startDateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
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
                                            controller.endDateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                    child: Dropdown(
                                      clearButton: true,
                                      clearOnPressed: () {
                                        controller.filterDayTimeController.clear();
                                      },
                                      text: 'Day Time'.obs,
                                      list: ['Morning', 'Evening'],
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.filterDayTimeController.text = value.toString();
                                        }
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
                                        controller.milkUsageDay.value = false;
                                        controller.DairyUsageHistory();
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
        body: Obx(
          () => controller.MilkUsageHistoryList.isEmpty
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
                  itemCount: controller.MilkUsageHistoryList.length,
                  itemBuilder: (context, index) {
                    final item = controller.MilkUsageHistoryList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffE5F0FF),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CattleRichText(
                                    text: 'Date : ',
                                    fontSize1: 14,
                                    fontSize: 16,
                                    color: const Color(0xff262626),
                                    richText: convertDateFormat(date: item.date),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CattleRichText(
                                    text: 'Liter : ',
                                    fontSize1: 14,
                                    fontSize: 16,
                                    color: const Color(0xff262626),
                                    richText: '${item.liter}',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              CattleRichText(
                                text: 'UsedIn : ',
                                fontSize1: 14,
                                fontSize: 16,
                                color: const Color(0xff262626),
                                richText: '${item.usedIn}',
                                fontWeight: FontWeight.bold,
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
    );
  }
}
