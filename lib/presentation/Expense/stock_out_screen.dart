// ignore_for_file: invalid_use_of_protected_member

import 'package:cattle_app/presentation/splashScreen/models/defaultVariables_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/Expense/Expense_screen_controller.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/dropdown/dropdown.dart';
import '../common file/defaultVariablesList.dart';

class StockOutScreen extends StatelessWidget {
  const StockOutScreen({Key? key}) : super(key: key);

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
          title: "Stock Out",
          actions: [
            Padding(
              padding: getPadding(left: 13, top: 6, right: 13, bottom: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.history,
                  size: 33,
                  color: Colors.white,
                ),
                onPressed: () {
                  expenseScreenController.LastStock.value = true;
                  expenseScreenController.StockList(context);
                },
              ),
            ),
          ],
          styleType: Style.bgFillBluegray900,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: [
                    CustomDropdown(
                      image: 'assets/images/expenseType.png',
                      height: 40,
                      globalKey: expenseScreenController.expenseKey,
                      text: 'Expense type  '.obs,
                      list: expenseScreenController.expenseType,
                      selectedItem: expenseScreenController.selectedExpenseType,
                      onChanged: (value) async {
                        for (var item in itemMaster) {
                          if (item.expenceType == value) {
                            item.stockOut.value = false;
                          }
                        }
                        expenseScreenController.selectedExpenseType.value = value.toString();
                        expenseScreenController.expenseController.text = value.toString();
                        expenseScreenController.StockOutItemName();
                        expenseScreenController.selectedItemName.value = 'itemName';
                        expenseScreenController.itemNameController.text = 'itemName';
                        expenseScreenController.selectedVehicleNo.value = 'Vehicle No';
                        expenseScreenController.vehicleNoController.text = 'Vehicle No';
                      },
                      validator: (value) {
                        if (value == null || value == 'Expense type') {
                          return 'Please Enter Expense type ';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: SizedBox(
                        height: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextField(
                                  controller: expenseScreenController.searchController,
                                  onChanged: (value) {
                                    expenseScreenController.filterSearchResults(value);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Search",
                                    hintText: "Search Item Name",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                    ),
                                  ),
                                ),
                              ),
                              ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1),
                                itemCount: expenseScreenController.SearchItemList.length,
                                itemBuilder: (context, index) {
                                  return _buildItemView(
                                    index: index,
                                    itemList: expenseScreenController.SearchItemList,
                                    expenseScreenController: expenseScreenController,
                                    onTap: () {},
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image(image: const AssetImage('assets/images/billDate.png'), height: 40,),
                    ),
                    Text(
                      'Stock Out Date : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.blueGray9007f,
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        datePicker(context: context, expenseScreenController: expenseScreenController);
                      },
                      child: Obx(() => Text(
                        expenseScreenController.selectedRfoDate.value.isEmpty
                            ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                            : expenseScreenController.selectedRfoDate.value,
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      )),
                    ),
                  ],
                ),
              ),
              Obx(() => expenseScreenController.selectedExpenseType.value == 'Fuel'
                  ? CustomDropdown(
                      image: 'assets/images/expenseType.png',
                      height: 40,
                      globalKey: expenseScreenController.vehicleNoKey,
                      text: 'Vehicle No'.obs,
                      selectedItem: expenseScreenController.selectedVehicleNo,
                      list: vehicle
                          .map((data) => data.vehicleNumber)
                          .toSet()
                          .toList(),
                      onChanged: (value) async {
                        expenseScreenController.selectedVehicleNo.value = value.toString();
                        expenseScreenController.vehicleNoController.text = value.toString();
                      },
                      validator: (value) {
                        if (value == null || value == 'Vehicle No') {
                          return 'Please Enter Vehicle No ';
                        }
                        return null;
                      },
                    )
                  : const SizedBox()),
              CustomTextField(
                image: 'assets/images/remarkIcon.png',
                height: 40,
                labelText: "Remark",
                controller: expenseScreenController.remarkController,
                hintText: "Remark",
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 10),
              child: CustomButton(
                text: "Submit",
                height: 55,
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                variant: ButtonVariant.FillBluegray900,
                onTap: () {
                  if (expenseScreenController.expenseController.text == 'Fuel') {
                    if (expenseScreenController.FuelCondition()) {
                      expenseScreenController.stockOutItem();
                      expenseScreenController.StockOut(context);
                    }
                  } else if (expenseScreenController.StockOutCondition()) {
                    expenseScreenController.stockOutItem();
                    expenseScreenController.StockOut(context);
                  }
                  expenseScreenController.selectedExpenseType.value = 'Expense type';
                  expenseScreenController.expenseController.text = 'Expense type';
                  expenseScreenController.selectedItemName.value = 'itemName';
                  expenseScreenController.itemNameController.text = 'itemName';
                  expenseScreenController.selectedVehicleNo.value = 'Vehicle No';
                  expenseScreenController.vehicleNoController.text = 'Vehicle No';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: GestureDetector(
                onTap: () {
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
                                  CustomTextFormField(
                                    globalKey: expenseScreenController.DailogKey,
                                    controller: expenseScreenController.RFONumberController,
                                    hintText: "RFO Number",
                                    labelText: "RFO Number",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter RFO Number ';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CustomButton(
                                      text: "Cancel RFO",
                                      width: 200,
                                      height: 55,
                                      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                                      variant: ButtonVariant.FillGreen600b2,
                                      onTap: () {
                                        if (expenseScreenController.DailogKey.currentState!.validate()) {
                                          expenseScreenController.CancelRFO();
                                        }
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
                  padding: const EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.blueGray9007f, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Cancel RFO number',
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Outfit',
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  datePicker({required BuildContext context, required ExpenseScreenController expenseScreenController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    expenseScreenController.selectedRfoDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    expenseScreenController.rfoDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    expenseScreenController.stockOutDate = pickedDate;
    expenseScreenController.GetItemStock();
  }

  Widget _buildItemView({
    required int index,
    required List<ItemMaster> itemList,
    required ExpenseScreenController expenseScreenController,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Obx(
            () => Checkbox(
              activeColor: const Color(0xff232f34),
              value: itemList[index].stockOut.value,
              onChanged: (bool? newValue) {
                itemList[index].stockOut.value = newValue!;
                expenseScreenController.selectedItemName.value = itemList[index].itemName;
                expenseScreenController.itemNameController.text = itemList[index].itemName;
                expenseScreenController.GetItemStock();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              itemList[index].itemName.length <= 15
                  ? itemList[index].itemName
                  : "${itemList[index].itemName.substring(0, 15)}...",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87.withOpacity(0.7),
              ),
            ),
          ),
          const Spacer(),
          Obx(
            () => SizedBox(
              width: 150,
              child: TextField(
                style: const TextStyle(fontSize: 12),
                controller: itemList[index].StockOutController,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontSize: 12),
                  labelStyle: const TextStyle(fontSize: 12),
                  hintText: "Total ${itemList[index].stock.value.toStringAsFixed(1)}",
                  labelText: "Total ${itemList[index].stock.value.toStringAsFixed(1)}",
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  if (double.parse(value) > itemList[index].stock.value) {
                    itemList[index].StockOutController.text = "0.0";
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
