// ignore_for_file: invalid_use_of_protected_member
import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:english_words/english_words.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/Expense/Expense_screen_controller.dart';
import 'package:path_provider/path_provider.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/dropdown/dropdown.dart';
import '../common file/defaultVariablesList.dart';

class ExpenseScreen extends StatelessWidget {
  ExpenseScreen({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  void _getImage(ExpenseScreenController expenseScreenController, ImageSource source) async {
    String directory = (await getTemporaryDirectory()).path;
    List<XFile>? pickedFiles;

    if (source == ImageSource.camera) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        pickedFiles = [pickedFile];
      }
    } else {
      pickedFiles = await _picker.pickMultiImage();
    }

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (XFile pickedFile in pickedFiles) {
        File file = File(pickedFile.path);
        int fileSize = await file.length();

        if (fileSize > 5120) {
          File? compressedFile = await _compressImage(file, directory);
          if (compressedFile != null) {
            file = compressedFile;
          }
        }

        expenseScreenController.selectedImages.add(file);
      }
    }
  }

  Future<File?> _compressImage(File file, String targetDirectory) async {
    int quality = 90;
    XFile? compressedXFile;

    while (true) {
      final newImageName =
          "$targetDirectory/${generateRandomName()}.${file.path.split('.').last}";

      compressedXFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        newImageName,
        quality: quality,
      );

      if (compressedXFile == null) {
        break;
      }

      File compressedFile = File(compressedXFile.path);
      int compressedSize = await compressedFile.length();

      if (compressedSize <= 5120 || quality <= 5) {
        return compressedFile;
      }

      quality -= 5;
    }

    return null;
  }

  String generateRandomName() {
    final random = Random();
    final wordPair = WordPair.random(random: random);
    final word1 = wordPair.first;
    final word2 = WordPair.random(random: random).first;
    final word3 = WordPair.random(random: random).first;
    final word4 = WordPair.random(random: random).first;
    return '${word1}_${word2}_${word3}_${word4}';
  }

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
          title: "Add Stock",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Column(
                  children: [
                    CustomDropdown(
                      image: 'assets/images/expenseType.png',
                      height: 40,
                      globalKey: expenseScreenController.expenseKey,
                      text: 'Expense type'.obs,
                      selectedItem: expenseScreenController.selectedExpenseType,
                      list: expenseType.map((data) => data.value).toList(),
                      onChanged: (value) {
                        expenseScreenController.selectedExpenseType.value = value.toString();
                        expenseScreenController.expenseController.text = value.toString();
                        expenseScreenController.selectedVendorId.value = 'VendorId';
                        expenseScreenController.vendorIdController.text = 'VendorId';
                        expenseScreenController.selectedItemName.value = 'itemName';
                        expenseScreenController.itemNameController.text = 'itemName';
                        expenseScreenController.vendorIdName();
                        expenseScreenController.ItemName();
                        expenseScreenController.ALlControllerClear();
                      },
                      validator: (value) {
                        if (value == null || value == 'Expense type') {
                          return 'Please Enter Expense type ';
                        }
                        return null;
                      },
                    ),
                    expenseScreenController.selectedExpenseType.value == 'Stipend'
                        ? const SizedBox()
                        : CustomDropdown(
                            image: 'assets/images/vendorId.png',
                            height: 40,
                            selectedItem: expenseScreenController.selectedVendorId,
                            globalKey: expenseScreenController.vendorIdKey,
                            text: 'VendorId  '.obs,
                            list: expenseScreenController.filteredVendorList,
                            onChanged: (value) async {
                              expenseScreenController.selectedVendorId.value = value.toString();
                              expenseScreenController.vendorIdController.text = value.toString();
                            },
                            validator: (value) {
                              if (value == null || value == 'VendorId') {
                                  return 'Please Enter VendorId ';
                              }
                              return null;
                            },
                          ),
                  ],
                ),
              ),
              Obx(
                () => PrefUtils.getGaushalaId.toString() == "02" || PrefUtils.getGaushalaId.toString() == "03"
                    ? CustomTextField(
                        image: 'assets/images/lastRFO.png',
                        height: 40,
                        globalKey: expenseScreenController.RFOKey,
                        controller: expenseScreenController.RFONumberController,
                        hintText: "Last RFO Number : ${expenseScreenController.lastRfoNumber.value}",
                        labelText: "Last RFO Number : ${expenseScreenController.lastRfoNumber.value}",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter RFO Number ';
                          }
                          return null;
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: Image(
                              image: AssetImage('assets/images/lastRFO.png'),
                              height: 40,
                            ),
                          ),
                          Text(
                            'Last RFO Number : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.blueGray9007f,
                              fontSize: 17,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${expenseScreenController.lastRfoNumber.value}',
                            style: const TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ])),
              ),
              CustomTextField(
                image: 'assets/images/party_name.png',
                height: 40,
                globalKey: expenseScreenController.partyNameKey,
                controller: expenseScreenController.partyNameController,
                hintText: "Party Name",
                labelText: "Party Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Party Name ';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: Image(
                        image: AssetImage('assets/images/billDate.png'),
                        height: 40,
                      ),
                    ),
                    Text(
                      'RFO Date : ',
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
                        expenseScreenController.selectedRfoDate.value.isEmpty ? DateFormat('dd-MM-yyyy').format(DateTime.now()) : expenseScreenController.selectedRfoDate.value,
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      )),
                    ),
                  ],
                ),
              ),
              CustomDropdown(
                image: 'assets/images/payment_type.png',
                height: 32,
                selectedItem: expenseScreenController.selectedPaymentType,
                globalKey: expenseScreenController.paymentTypeKey,
                text: 'payment Type'.obs,
                list: const ["ONLINE", "CARD PAY", "CHEQUE"],
                onChanged: (value) async {
                  expenseScreenController.selectedPaymentType.value = value.toString();
                  expenseScreenController.paymentTypeController.text = value.toString();
                },
                validator: (value) {
                  if (value == null || value == 'payment Type') {
                    return 'Please Enter VendorId ';
                  }
                  return null;
                },
              ),
              CustomDropdown(
                image: 'assets/images/rfo_type.png',
                height: 32,
                selectedItem: expenseScreenController.selectedRfoType,
                globalKey: expenseScreenController.rfoTypeKey,
                text: 'RFO Type'.obs,
                list: const ["EXPANSE", "PURCHASE", "ADVANCE AGAINST STIPEND"],
                onChanged: (value) async {
                  expenseScreenController.selectedRfoType.value = value.toString();
                  expenseScreenController.rfoTypeController.text = value.toString();
                  if (value == "ADVANCE AGAINST STIPEND") {
                    expenseScreenController.remarkController.text = value.toString();
                  } else {
                    expenseScreenController.remarkController.clear();
                  }
                },
                validator: (value) {
                  if (value == null || value == 'RFO Type') {
                    return 'Please Enter VendorId ';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Select OnDate',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Obx(
                    () => Checkbox(
                      activeColor: const Color(0xff232f34),
                      value: expenseScreenController.selectOnDate.value,
                      onChanged: (bool? newValue) {
                        expenseScreenController.selectOnDate.value = newValue!;
                      },
                    ),
                  ),
                ],
              ),
              Obx(() => expenseScreenController.selectOnDate.isFalse
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10),
                                child: Image(
                                  image: const AssetImage('assets/images/billDate.png'),
                                  height: 40,
                                ),
                              ),
                              Text(
                                'From Date : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.blueGray9007f,
                                  fontSize: 17,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  fromDatePicker(context: context, expenseScreenController: expenseScreenController);
                                },
                                child: Text(
                                  expenseScreenController.selectedFromDate.value.isEmpty ? DateFormat('dd-MM-yyyy').format(DateTime.now()) : expenseScreenController.selectedFromDate.value,
                                  style: const TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10),
                                child: Image(
                                  image: const AssetImage('assets/images/billDate.png'),
                                  height: 40,
                                ),
                              ),
                              Text(
                                'To Date : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.blueGray9007f,
                                  fontSize: 17,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  toDatePicker(context: context, expenseScreenController: expenseScreenController);
                                },
                                child: Text(
                                  expenseScreenController.selectedToDate.value.isEmpty ? DateFormat('dd-MM-yyyy').format(DateTime.now()) : expenseScreenController.selectedToDate.value,
                                  style: const TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Image(
                              image: const AssetImage('assets/images/billDate.png'),
                              height: 40,
                            ),
                          ),
                          Text(
                            'On Date : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.blueGray9007f,
                              fontSize: 17,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              onDatePicker(context: context, expenseScreenController: expenseScreenController);
                            },
                            child: Text(
                              expenseScreenController.selectedOnDateVal.value.isEmpty ? DateFormat('dd-MM-yyyy').format(DateTime.now()) : expenseScreenController.selectedOnDateVal.value,
                              style: const TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    )),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Image(
                        image: const AssetImage('assets/images/addItem.png'),
                        height: 40,
                      ),
                    ),
                    Text(
                      'Add Item',
                      style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        expenseScreenController.addItemWidgetList.isEmpty
                            ? expenseScreenController.addItemWidgetList.add(
                                addItemWidget(expenseScreenController: expenseScreenController),
                              )
                            : null;
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
                              content: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        expenseScreenController.stockInReqList.isNotEmpty
                                            ? expenseScreenController.showSubmit.value = true
                                            : expenseScreenController.showSubmit.value = false;
                                        Get.back();
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.black26,
                                        radius: 15,
                                        child: Icon(Icons.close, color: Colors.black, size: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Obx(
                                          () => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: expenseScreenController.addItemWidgetList
                                                .map(
                                                  (element) => addItemWidget(expenseScreenController: expenseScreenController),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant.blueGray9007f, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/images/add.png',
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.blueGray9007f, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Image(
                            image: const AssetImage('assets/images/totalAmount.png'),
                            height: 40,
                          ),
                        ),
                        Obx(
                          () => Text(
                            "\u{20B9} ${expenseScreenController.GstTotal.value.toStringAsFixed(0)}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Total Amount ",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Obx(
                  () => Column(
                    children: expenseScreenController.stockInReqList
                        .map(
                          (element) => AddedItemListWidget(
                            item: expenseScreenController.StockInItemName(itemID: element.itemId),
                            qty: element.qty,
                            amount: element.totalAmount.toStringAsFixed(2),
                            onTap: () {
                              expenseScreenController.stockInReqList.remove(element);
                              expenseScreenController.stockInReqList.refresh();
                              expenseScreenController.addedSum();
                              expenseScreenController.addItemWidgetList.isEmpty
                                  ? expenseScreenController.showSubmit.value = false
                                  : expenseScreenController.showSubmit.value = true;
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () => _getImage(expenseScreenController, ImageSource.camera),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey,
                          ),
                        )),
                    GestureDetector(
                        onTap: () => _getImage(expenseScreenController, ImageSource.gallery),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(
                  () => Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: expenseScreenController.selectedImages.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: expenseScreenController.selectedImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        expenseScreenController.selectedImages.removeAt(index);
                                      },
                                      child: Image.asset(
                                        'assets/images/clearImg.png',
                                        height: 20,
                                      ),
                                    ),
                                    Image.file(
                                      expenseScreenController.selectedImages[index],
                                      height: 250,
                                      width: 250,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => (expenseScreenController.addItemWidgetList.isEmpty && expenseScreenController.stockInReqList.isNotEmpty) || expenseScreenController.showSubmit.isTrue
                ? Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 10),
                      child: CustomButton(
                        text: "SUBMIT",
                        height: 55,
                        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                        variant: ButtonVariant.FillBluegray900,
                        onTap: () {
                          expenseScreenController.StockInApi(context);
                          expenseScreenController.selectedExpenseType.value = 'Expense type';
                          expenseScreenController.expenseController.text = 'Expense type';
                          expenseScreenController.selectedVendorId.value = 'VendorId';
                          expenseScreenController.vendorIdController.text = 'VendorId';
                          expenseScreenController.selectedItemName.value = 'itemName';
                          expenseScreenController.itemNameController.text = 'itemName';
                          expenseScreenController.addedTotal.value = 0;
                          expenseScreenController.GstTotal.value = 0;
                        },
                      ),
                    ),
                  )
                : const SizedBox()),
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
  }

  fromDatePicker({required BuildContext context, required ExpenseScreenController expenseScreenController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    expenseScreenController.selectedFromDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    expenseScreenController.fromDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }

  toDatePicker({required BuildContext context, required ExpenseScreenController expenseScreenController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    expenseScreenController.selectedToDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    expenseScreenController.toDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }

  onDatePicker({required BuildContext context, required ExpenseScreenController expenseScreenController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    expenseScreenController.selectedOnDateVal.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    expenseScreenController.onDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }
}

class addItemWidget extends StatelessWidget {
  const addItemWidget({
    Key? key,
    required this.expenseScreenController,
  }) : super(key: key);

  final ExpenseScreenController expenseScreenController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: Column(
          children: [
            Column(
              children: [
                CustomDropdown(
                  image: 'assets/images/iteamName.png',
                  height: 40,
                  globalKey: expenseScreenController.itemNameKey,
                  text: 'itemName'.obs,
                  selectedItem: expenseScreenController.selectedItemName,
                  list: expenseScreenController.filteredItemList,
                  onChanged: (value) async {
                    expenseScreenController.selectedItemName.value = value.toString();
                    expenseScreenController.itemNameController.text = value.toString();
                    expenseScreenController.IsStock();
                  },
                  validator: (value) {
                    if (value == null || value == 'itemName') {
                      return 'Please Enter itemName ';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 0, right: 10),
                  child: Row(
                    children: [
                      Text(
                        'Bill Date : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.blueGray9007f,
                          fontSize: 17,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          billDatePicker(context: context, expenseScreenController: expenseScreenController);
                        },
                        child: Text(
                          expenseScreenController.selectedBillDate.value.isEmpty ? DateFormat('dd-MM-yyyy').format(DateTime.now()) : expenseScreenController.selectedBillDate.value,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.blueGray9007f,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  image: 'assets/images/billNumber.png',
                  height: 40,
                  globalKey: expenseScreenController.BillKey,
                  controller: expenseScreenController.BillNumberController,
                  hintText: "Bill Number",
                  labelText: "Bill Number",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Bill Number ';
                    }
                    return null;
                  },
                ),
                expenseScreenController.expenseController.text == 'Green' ||
                        expenseScreenController.expenseController.text == 'Fuel' ||
                        expenseScreenController.expenseController.text == 'Miscellaneous' ||
                        expenseScreenController.IsStock() == false
                    ? const SizedBox()
                    : CustomTextFormField(
                        globalKey: expenseScreenController.totalWtOrQtyKey,
                        controller: expenseScreenController.totalWtOrQtyController,
                        hintText: expenseScreenController.expenseController.text == 'Labour Charges'
                            ? 'No Of Labour'
                            : expenseScreenController.expenseController.text == 'Stipend'
                                ? 'No Of Person'
                                : "Total ${expenseScreenController.OUTUnitType()} ",
                        labelText: expenseScreenController.expenseController.text == 'Labour Charges'
                            ? 'No Of Labour'
                            : expenseScreenController.expenseController.text == 'Stipend'
                                ? 'No Of Person'
                                : "Total ${expenseScreenController.OUTUnitType()} ",
                        textInputType: const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (value) {
                          expenseScreenController.QuantityCalculate();
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == 0 || value == 0.0) {
                            return 'Please Enter Total Weight';
                          }
                          return null;
                        },
                      ),
                expenseScreenController.expenseController.text == 'Labour Charges' || expenseScreenController.expenseController.text == 'Stipend'
                    ? CustomTextFormField(
                        globalKey: expenseScreenController.totalWtOrQtyKey,
                        controller: expenseScreenController.totalWtOrQtyController,
                        hintText: expenseScreenController.expenseController.text == 'Labour Charges'
                            ? 'No Of Labour'
                            : expenseScreenController.expenseController.text == 'Stipend'
                                ? 'No Of Person'
                                : "Total ${expenseScreenController.OUTUnitType()} ",
                        labelText: expenseScreenController.expenseController.text == 'Labour Charges'
                            ? 'No Of Labour'
                            : expenseScreenController.expenseController.text == 'Stipend'
                                ? 'No Of Person'
                                : "Total ${expenseScreenController.OUTUnitType()} ",
                        textInputType: const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (value) {
                          expenseScreenController.QuantityCalculate();
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == 0 || value == 0.0) {
                            return 'Please Enter Total Weight';
                          }
                          return null;
                        },
                      )
                    : const SizedBox(),
                expenseScreenController.IsStock() == false
                    ? const SizedBox()
                    : Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              globalKey: expenseScreenController.QtyKey,
                              controller: expenseScreenController.qtyController,
                              hintText: "QTY in ${expenseScreenController.itemUnitType()}",
                              labelText: "QTY in ${expenseScreenController.itemUnitType()}",
                              textInputType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (value) {
                                if (expenseScreenController.expenseController.text == 'Green' ||
                                    expenseScreenController.expenseController.text == 'Fuel' ||
                                    expenseScreenController.expenseController.text == 'Miscellaneous') {
                                  expenseScreenController.totalWtOrQtyController.text = value;
                                }
                                expenseScreenController.QuantityCalculate();
                                expenseScreenController.TotalAmountCalculate();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Qty ';
                                }
                                return null;
                              },
                            ),
                          ),
                          expenseScreenController.expenseController.text == 'Green' ||
                                  expenseScreenController.expenseController.text == 'Fuel' ||
                                  expenseScreenController.expenseController.text == 'Miscellaneous'
                              ? const SizedBox()
                              : Expanded(
                                  child: CustomTextFormField(
                                    globalKey: expenseScreenController.kgPerUnitKey,
                                    controller: expenseScreenController.kgPerUnitController,
                                    hintText: "${expenseScreenController.OUTUnitType()} Per  ${expenseScreenController.itemUnitType()}",
                                    labelText: "${expenseScreenController.OUTUnitType()} Per  ${expenseScreenController.itemUnitType()}",
                                    textInputType: TextInputType.none,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter kg Per Unit ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                        ],
                      ),
                Row(
                  children: [
                    expenseScreenController.IsStock() == false
                        ? const SizedBox()
                        : Expanded(
                            child: CustomTextFormField(
                              globalKey: expenseScreenController.ratePerUnitKey,
                              controller: expenseScreenController.ratePerUnitController,
                              hintText: "Rate Per ${expenseScreenController.itemUnitType()}",
                              labelText: "Rate Per ${expenseScreenController.itemUnitType()}",
                              textInputType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (value) {
                                expenseScreenController.TotalAmountCalculate();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Rate Per ${expenseScreenController.itemUnitType()} ';
                                }
                                return null;
                              },
                            ),
                          ),
                    Expanded(
                      child: CustomTextFormField(
                        globalKey: expenseScreenController.totalAmountKey,
                        controller: expenseScreenController.totalAmountController,
                        hintText: "Total amount",
                        labelText: "Total amount",
                        textInputType: expenseScreenController.IsStock() == false ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.none,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Total amount';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (expenseScreenController.IsStock() == false) {
                            expenseScreenController.ratePerUnitController.text = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            expenseScreenController.expenseController.text == 'Repairs & Maintenance'
                ? CustomDropdown(
                    image: 'assets/images/expenseType.png',
                    height: 40,
                    globalKey: expenseScreenController.vehicleNoKey,
                    text: 'Vehicle No'.obs,
                    selectedItem: expenseScreenController.selectedVehicleNo,
                    list: vehicle.map((data) => data.vehicleNumber).toSet().toList(),
                    onChanged: (value) async {
                      expenseScreenController.selectedVehicleNo.value = value.toString();
                      expenseScreenController.vehicleNoController.text = value.toString();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please Enter Vehicle No ';
                      }
                      return null;
                    },
                  )
                : const SizedBox(),
            CustomTextFormField(
              controller: expenseScreenController.GSTController,
              hintText: "GST",
              labelText: "GST",
              textInputType: TextInputType.number,
              onChanged: (value) {
                expenseScreenController.GSTController.text = value;
              },
            ),
            CustomTextFormField(
              globalKey: expenseScreenController.remarkKey,
              labelText: "Remark",
              controller: expenseScreenController.remarkController,
              hintText: "Remark",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Remark';
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
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                variant: ButtonVariant.FillGreen600b2,
                onTap: () {
                  expenseScreenController.showSubmit.value = false;
                  if (expenseScreenController.expenseController.text == 'Repairs & Maintenance') {
                    if (expenseScreenController.RepairsMaintenanceCondition()) {
                      expenseScreenController.StockIn(context);
                    }
                  } else if (expenseScreenController.expenseController.text == 'Stipend') {
                    if (expenseScreenController.StipendCondition()) {
                      expenseScreenController.StockIn(context);
                    }
                  } else if (expenseScreenController.expenseController.text == 'Labour Charges') {
                    if (expenseScreenController.LabourChargesCondition()) {
                      expenseScreenController.StockIn(context);
                    }
                  } else if (expenseScreenController.expenseController.text == 'Green' ||
                      expenseScreenController.expenseController.text == 'Fuel' ||
                      expenseScreenController.expenseController.text == 'Miscellaneous') {
                    if (expenseScreenController.MiscellaneousCondition()) {
                      expenseScreenController.StockIn(context);
                    }
                  } else if (expenseScreenController.expenseController.text == 'Mix' ||
                      expenseScreenController.expenseController.text == 'Dry' ||
                      expenseScreenController.expenseController.text == 'Medical' ||
                      expenseScreenController.expenseController.text == 'Sweet Material') {
                    if (expenseScreenController.SweetMaterialCondition()) {
                      expenseScreenController.StockIn(context);
                    }
                  } else if (expenseScreenController.IsStock() == false) {
                    if (expenseScreenController.expenseKey.currentState!.validate() &&
                                expenseScreenController.vendorIdKey.currentState!.validate() &&
                                PrefUtils.getGaushalaId.toString() == "02" ||
                            PrefUtils.getGaushalaId.toString() == "03"
                        ? expenseScreenController.RFOKey.currentState!.validate()
                        : expenseScreenController.partyNameKey.currentState!.validate() &&
                            expenseScreenController.paymentTypeKey.currentState!.validate() &&
                            expenseScreenController.rfoTypeKey.currentState!.validate() &&
                            expenseScreenController.itemNameKey.currentState!.validate() &&
                            expenseScreenController.BillKey.currentState!.validate() &&
                            expenseScreenController.totalAmountKey.currentState!.validate() &&
                            expenseScreenController.remarkKey.currentState!.validate()) {
                      expenseScreenController.StockIn(context);
                    }
                  } else if (expenseScreenController.StockInCondition()) {
                    expenseScreenController.StockIn(context);
                  }
                  expenseScreenController.selectedItemName.value = 'itemName';
                  expenseScreenController.itemNameController.text = 'itemName';
                  Get.back();
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  billDatePicker({required BuildContext context, required ExpenseScreenController expenseScreenController}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    expenseScreenController.selectedBillDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    expenseScreenController.billDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }
}

class AddedItemListWidget extends StatelessWidget {
  const AddedItemListWidget({
    Key? key,
    required this.item,
    required this.qty,
    required this.amount,
    required this.onTap,
  }) : super(key: key);

  final String item;
  final String qty;
  final String amount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: ColorConstant.blueGray9007f),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                item.length <= 10 ? item : "${item.substring(0, 10)}...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 17,
                ),
              ),
              Text(
                "\u{20B9} $amount",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/remove.png',
                  height: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
