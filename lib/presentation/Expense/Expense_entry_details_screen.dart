import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/Expense/Expense_screen_controller.dart';
import 'package:cattle_app/presentation/common%20file/defaultVariablesList.dart';
import 'package:cattle_app/widgets/custom_button.dart';

import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/dropdown/dropdown.dart';

class ExpenseEntryDetailsScreen extends StatelessWidget {
  const ExpenseEntryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExpenseScreenController expenseScreenController = Get.put(ExpenseScreenController());

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIconOnTap: () {
            Get.back();
          },
          leadingIcon: const Icon(Icons.arrow_back, color: Colors.white,),
          centerTitle: true,
          height: 60,
          title: "Expense Entry Details",
          styleType: Style.bgFillBluegray900,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                  GestureDetector(
                    onTap: () {
                      startDatePicker(context: context, expenseScreenController: expenseScreenController);
                    },
                    child: Obx(() => Text(
                      expenseScreenController.selectedStartDate.value.isEmpty
                          ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                          : expenseScreenController.selectedStartDate.value,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                  GestureDetector(
                    onTap: () {
                      endDatePicker(context: context, expenseScreenController: expenseScreenController);
                    },
                    child: Obx(() => Text(
                      expenseScreenController.selectedEndDate.value.isEmpty
                          ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                          : expenseScreenController.selectedEndDate.value,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    )),
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
                text: "Continue",
                width: 200,
                height: 55,
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
    );
  }

  startDatePicker({required BuildContext context, required ExpenseScreenController expenseScreenController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    expenseScreenController.selectedStartDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    expenseScreenController.StartDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }

  endDatePicker({required BuildContext context, required ExpenseScreenController expenseScreenController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    expenseScreenController.selectedEndDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    expenseScreenController.EndDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }
}
