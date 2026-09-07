import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:cattle_app/core/utils/size_utils.dart';
import 'package:cattle_app/presentation/Expense/Expense_screen_controller.dart';
import 'package:cattle_app/widgets/app_bar/custom_app_bar.dart';
import 'package:cattle_app/widgets/rich_text.dart';

import '../../core/utils/color_constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dropdown/dropdown.dart';
import '../common file/defaultVariablesList.dart';

class ExpenseEntryDetailsHistoryScreen extends StatelessWidget {
  const ExpenseEntryDetailsHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExpenseScreenController expenseScreenController = Get.put(ExpenseScreenController());

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
          title: "Expense History",
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
                    builder: (_) => PopScope(
                      canPop: false,
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 0, right: 10),
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
                                            expenseScreenController.selectedStartDate.value = DateFormat('dd-MM-yyyy').format(dateTime).toString();
                                            expenseScreenController.StartDateController.text = DateFormat('dd-MM-yyyy').format(dateTime).toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 0, right: 10),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 10, 12, 10),
                                          cancelText: 'Cancel',
                                          confirmText: 'OK',
                                          pressType: PressType.singlePress,
                                          timeFormat: 'dd-MM-yyyy',
                                          onChange: (dateTime) {
                                            expenseScreenController.selectedEndDate.value = DateFormat('dd-MM-yyyy').format(dateTime).toString();
                                            expenseScreenController.EndDateController.text = DateFormat('dd-MM-yyyy').format(dateTime).toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => Column(
                                      children: [
                                        Dropdown(
                                          text: 'Expense type'.obs,
                                          selectedItem: expenseScreenController.selectedStockExpenseType,
                                          list: expenseType.map((data) => data.value).toList(),
                                          onChanged: (value) {
                                            expenseScreenController.selectedStockExpenseType.value = value.toString();
                                            expenseScreenController.StockExpenseTypeController.text = value.toString();
                                            expenseScreenController.ItemIdName();
                                          },
                                        ),
                                        Dropdown(
                                          selectedItem: expenseScreenController.selectedStockItemID,
                                          text: 'Item id  '.obs,
                                          list: expenseScreenController.filteredItemIdNameList,
                                          onChanged: (value) async {
                                            expenseScreenController.selectedStockItemID.value = value.toString();
                                            expenseScreenController.StockItemIDController.text = value.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CustomButton(
                                      text: "Apply",
                                      width: 200,
                                      height: 55,
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      variant: ButtonVariant.FillGreen600b2,
                                      onTap: () {
                                        expenseScreenController.LastStock.value = false;
                                        expenseScreenController.StockList(context);
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
          () => expenseScreenController.stockData.isEmpty
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
                  itemCount: expenseScreenController.stockData.length,
                  itemBuilder: (context, index) {
                    int reversedIndex = expenseScreenController.stockData.length - 1 - index;
      
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: expenseScreenController.stockData[reversedIndex].rfoNo == ''
                              ? Colors.red.shade100
                              : Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              expenseScreenController.stockData[reversedIndex].rfoNo != ''
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          expenseScreenController.RFOHistory(
                                              rfoNumber: expenseScreenController.stockData[reversedIndex].rfoNo);
                                        },
                                        icon: const Icon(
                                          Icons.print,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  expenseScreenController.stockData[reversedIndex].rfoNo != ''
                                      ? CattleRichText(
                                          text: 'RFO NO. : ',
                                          fontSize1: 14,
                                          fontSize: 16,
                                          color: const Color(0xff262626),
                                          richText: expenseScreenController.stockData[reversedIndex].rfoNo,
                                          fontWeight: FontWeight.bold,
                                        )
                                      : CattleRichText(
                                          text: 'Total QTY : ',
                                          fontSize1: 14,
                                          fontSize: 16,
                                          color: const Color(0xff262626),
                                          richText: '${expenseScreenController.stockData[reversedIndex].totalWtOrQty}',
                                          fontWeight: FontWeight.bold,
                                        ),
                                  Text(
                                    expenseScreenController.stockData[reversedIndex].date,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                '${expenseScreenController.stockData[reversedIndex].expenceType} - ${expenseScreenController.HistoryItemName(reversedIndex)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  expenseScreenController.stockData[reversedIndex].rfoNo != ''
                                      ? CattleRichText(
                                          text: 'Total QTY : ',
                                          fontSize1: 14,
                                          fontSize: 16,
                                          color: const Color(0xff262626),
                                          richText: '${expenseScreenController.stockData[reversedIndex].totalWtOrQty}',
                                          fontWeight: FontWeight.bold,
                                        )
                                      : const SizedBox(),
                                  expenseScreenController.stockData[reversedIndex].rfoNo != ''
                                      ? CattleRichText(
                                          text: 'Total Amount : ',
                                          fontSize1: 14,
                                          color: const Color(0xff262626),
                                          richText: '${expenseScreenController.GSTCalculation(Percentage: double.parse(expenseScreenController.stockData[reversedIndex].cgst) * 2, total: expenseScreenController.stockData[reversedIndex].totalAmount.toDouble())}',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        )
                                      : const SizedBox(),
                                ],
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
