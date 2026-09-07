import 'dart:io';

import 'package:cattle_app/presentation/Expense/model/RFO_model/get_RFO_details_response.dart';
import 'package:cattle_app/presentation/splashScreen/models/defaultVariables_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:indian_currency_to_word/indian_currency_to_word.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:cattle_app/presentation/Expense/Expense_screen.dart';
import 'package:cattle_app/presentation/Expense/model/Expense_request.dart';
import 'package:cattle_app/presentation/Expense/model/RFO_model/LastRFONumberResponse.dart';
import 'package:cattle_app/presentation/Expense/model/cancel_RFO_model/Cancel_RFO_request.dart';
import 'package:cattle_app/presentation/Expense/model/cancel_RFO_model/Cancel_RFO_response.dart';
import 'package:cattle_app/presentation/Expense/model/item_stock/getItemStockRequest.dart';
import 'package:cattle_app/presentation/Expense/model/item_stock/getItemStockResponse.dart';
import 'package:cattle_app/presentation/Expense/model/stok_list/stok_list_request.dart';
import 'package:cattle_app/presentation/Expense/model/stok_list/stok_list_response.dart';
import 'package:cattle_app/routes/app_routes.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../core/utils/pref_utils.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';
import '../../widgets/loder.dart';
import '../common file/defaultVariablesList.dart';
import 'model/Expense_addBulkRequest.dart';
import 'model/Expense_addBulkResponse.dart';
import 'model/RFO_model/get_RFO_details_request.dart';

enum DataStatus { loading, done, error }

class ExpenseScreenController extends GetxController {
  TextEditingController expenseController = TextEditingController();
  TextEditingController vendorIdController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController RFONumberController = TextEditingController();
  TextEditingController BillNumberController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController kgPerUnitController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController ratePerUnitController = TextEditingController();
  TextEditingController totalWtOrQtyController = TextEditingController();
  TextEditingController rfoDateController = TextEditingController();
  TextEditingController GSTController = TextEditingController();

  TextEditingController StartDateController = TextEditingController();
  TextEditingController EndDateController = TextEditingController();
  TextEditingController StockExpenseTypeController = TextEditingController();
  TextEditingController StockItemIDController = TextEditingController();

  TextEditingController partyNameController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();
  TextEditingController rfoTypeController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController onDateController = TextEditingController();
  TextEditingController billDateController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  RxList<ItemMaster> SearchItemList = <ItemMaster>[].obs; // Adjust type according to your data model

  Rx<DataStatus> dataStatus = DataStatus.loading.obs;
  Map<String, dynamic>? retrievedData = PrefUtils.getData;

  GlobalKey<FormState> DailogKey = GlobalKey<FormState>();

  GlobalKey<FormState> RFOKey = GlobalKey<FormState>();
  GlobalKey<FormState> BillKey = GlobalKey<FormState>();
  GlobalKey<FormState> QtyKey = GlobalKey<FormState>();
  GlobalKey<FormState> kgPerUnitKey = GlobalKey<FormState>();
  GlobalKey<FormState> ratePerUnitKey = GlobalKey<FormState>();
  GlobalKey<FormState> totalWtOrQtyKey = GlobalKey<FormState>();
  GlobalKey<FormState> expenseKey = GlobalKey<FormState>();
  GlobalKey<FormState> vendorIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> itemNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> vehicleNoKey = GlobalKey<FormState>();
  GlobalKey<FormState> totalAmountKey = GlobalKey<FormState>();
  GlobalKey<FormState> partyNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> paymentTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> rfoTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> remarkKey = GlobalKey<FormState>();

  final converter = AmountToWords();
  RxList<File> selectedImages = <File>[].obs;

  RxString selectedExpenseType = 'Expense type'.obs;
  RxString selectedVendorId = 'VendorId'.obs;
  RxString selectedItemName = 'itemName'.obs;
  RxString selectedPaymentType = 'payment Type'.obs;
  RxString selectedRfoType = 'RFO Type'.obs;
  RxString selectedBillDate = ''.obs;
  RxString selectedRfoDate = ''.obs;
  RxString selectedFromDate = ''.obs;
  RxString selectedToDate = ''.obs;
  RxString selectedOnDateVal = ''.obs;
  RxString selectedVehicleNo = 'Vehicle No'.obs;
  RxString selectedStockExpenseType = 'Expense type'.obs;
  RxString selectedStockItemID = 'Item id  '.obs;
  RxString selectedStartDate = ''.obs;
  RxString selectedEndDate = ''.obs;

  RxDouble rfoTotalAmount = 0.0.obs;

  RxBool LastStock = false.obs;
  RxBool selectOnDate = false.obs;
  RxInt index = 0.obs;
  RxBool showSubmit = false.obs;
  var filteredVendorList = [''].obs;
  var filteredItemList = [''].obs;
  var filteredItemIdNameList = [''].obs;
  RxList<ItemMaster> itemList = <ItemMaster>[].obs;
  RxString lastRfoNumber = "".obs;

  RxList<StockDatum> stockData = <StockDatum>[].obs;
  RxList<GetRfoDetailsDatum> rfoHistoryList = <GetRfoDetailsDatum>[].obs;
  RxList<Item> rfoPrintList = <Item>[].obs;

  RxList<String> expenseType = <String>['Green', 'Mix', 'Dry', 'Medical', 'Sweet Material', 'Fuel', 'Miscellaneous'].obs;

  RxList<addItemWidget> addItemWidgetList = <addItemWidget>[].obs;

  RxList<ExpenseAddBulkRequest> stockInReqList = <ExpenseAddBulkRequest>[].obs;
  RxList<ExpenseRequest> stockOutReqList = <ExpenseRequest>[].obs;

  DateTime stockOutDate = DateTime.now();

  // RxDouble nowStock = 0.0.obs;

  RxDouble addedTotal = 0.0.obs;
  RxDouble GstTotal = 0.0.obs;

  @override
  void onInit() {
    retrieveCowData();
    LastRfo();
    super.onInit();
  }

  void calculateTotalAmount() {
    double quantity = double.tryParse(totalWtOrQtyController.text) ?? 0.0;
    double qty = double.tryParse(qtyController.text) ?? 0.0;
    double kgPerUnit = quantity / qty;
    kgPerUnitController.text = kgPerUnit.toStringAsFixed(0);
  }

  void QuantityCalculate() {
    double quantity = double.tryParse(totalWtOrQtyController.text) ?? 0.0;
    double qty = double.tryParse(qtyController.text) ?? 0.0;
    if (quantity != 0) {
      double kgPerUnit = qty / quantity;
      kgPerUnitController.text = kgPerUnit.toStringAsFixed(2);
    } else {
      kgPerUnitController.text = '0.000';
    }
  }

  void TotalAmountCalculate() {
    double qty = double.tryParse(qtyController.text) ?? 0.0;
    double rate = double.tryParse(ratePerUnitController.text) ?? 0.0;
    double totalAmount = qty * rate;
    totalAmountController.text = totalAmount.toStringAsFixed(0);
  }

  RxString vendorIdName() {
    filteredVendorList.clear();
    for (var type in vendorID) {
      if (type.group == expenseController.text) {
        filteredVendorList.add(type.code + ' - ' + type.name);
      }
    }
    return ''.obs;
  }

  RxString ItemIdName() {
    filteredItemIdNameList.clear();
    for (var type in itemMaster) {
      if (type.expenceType == selectedStockExpenseType.value) {
        filteredItemIdNameList.add(type.itemId + ' - ' + type.itemName);
      }
    }
    return ''.obs;
  }

  String ItemId(String input) {
    List<String> parts = input.split(" - ");
    String id = parts[0];
    return id;
  }

  String vendorId(String input) {
    List<String> parts = input.split(" - ");
    String id = parts[0];
    return id;
  }

  RxString itemType() {
    for (var item in itemMaster) {
      if (item.expenceType == StockExpenseTypeController.text) {
        return item.itemId.obs;
      }
    }
    return ''.obs;
  }

  String itemId() {
    for (var item in itemMaster) {
      if (item.itemName == itemNameController.text) {
        return item.itemId;
      }
    }
    return '';
  }

  String StockInItemName({required itemID}) {
    for (var item in itemMaster) {
      if (item.itemId == itemID) {
        return item.itemName;
      }
    }
    return '';
  }

  String ItemName() {
    filteredItemList.clear();
    for (var item in itemMaster) {
      if (item.expenceType == expenseController.text) {
        filteredItemList.add(item.itemName);
      }
    }
    return '';
  }

  bool IsStock() {
    for (var item in itemMaster) {
      if (item.itemName == selectedItemName.value) {
        return item.isStock;
      }
    }
    return false;
  }

  String HistoryItemName(int index) {
    for (var item in itemMaster) {
      if (item.itemId == stockData[index].itemId) {
        return item.itemName;
      }
    }
    return '';
  }

  StockOutItemName() {
    itemList.clear();
    for (var item in itemMaster) {
      if (item.expenceType == expenseController.text) {
        print(expenseController.text);
        itemList.add(item);
        filterSearchResults('');
      }
    }
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      SearchItemList.value = itemList.where((item) {
        return item.itemName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      SearchItemList.value = itemList;
    }
  }

  RxString itemUnitType() {
    for (var item in itemMaster) {
      if (item.itemName == selectedItemName.value) {
        return item.unitType.obs;
      }
    }
    return ''.obs;
  }

  RxString OUTUnitType() {
    for (var item in itemMaster) {
      if (item.itemName == selectedItemName.value) {
        return item.outUnitType.obs;
      }
    }
    return ''.obs;
  }

  condition() {
    return expenseController.text == 'Electricity' ||
        expenseController.text == 'Printing & Stationery' ||
        expenseController.text == 'Repairs & Maintenance' ||
        expenseController.text == 'Travel' ||
        expenseController.text == 'Telephone & Postage' ||
        expenseController.text == 'Capital' ||
        expenseController.text == 'Labour Charges' ||
        expenseController.text == 'Stipend';
  }

  RepairsMaintenanceCondition() {
    return expenseKey.currentState!.validate() && vendorIdKey.currentState!.validate() && PrefUtils.getGaushalaId.toString() == "02" || PrefUtils.getGaushalaId.toString() == "03"
        ? RFOKey.currentState!.validate()
        : partyNameKey.currentState!.validate() &&
            partyNameKey.currentState!.validate() &&
            paymentTypeKey.currentState!.validate() &&
            rfoTypeKey.currentState!.validate() &&
            itemNameKey.currentState!.validate() &&
            BillKey.currentState!.validate() &&
            vehicleNoKey.currentState!.validate() &&
            totalAmountKey.currentState!.validate() &&
            remarkKey.currentState!.validate();
  }

  StipendCondition() {
    return expenseKey.currentState!.validate() && PrefUtils.getGaushalaId.toString() == "02" || PrefUtils.getGaushalaId.toString() == "03"
        ? RFOKey.currentState!.validate()
        : partyNameKey.currentState!.validate() &&
            partyNameKey.currentState!.validate() &&
            paymentTypeKey.currentState!.validate() &&
            rfoTypeKey.currentState!.validate() &&
            itemNameKey.currentState!.validate() &&
            BillKey.currentState!.validate() &&
            totalWtOrQtyKey.currentState!.validate() &&
            totalAmountKey.currentState!.validate() &&
            remarkKey.currentState!.validate();
  }

  LabourChargesCondition() {
    return expenseKey.currentState!.validate() && vendorIdKey.currentState!.validate() && PrefUtils.getGaushalaId.toString() == "02" || PrefUtils.getGaushalaId.toString() == "03"
        ? RFOKey.currentState!.validate()
        : partyNameKey.currentState!.validate() &&
            partyNameKey.currentState!.validate() &&
            paymentTypeKey.currentState!.validate() &&
            rfoTypeKey.currentState!.validate() &&
            itemNameKey.currentState!.validate() &&
            BillKey.currentState!.validate() &&
            totalWtOrQtyKey.currentState!.validate() &&
            totalAmountKey.currentState!.validate() &&
            remarkKey.currentState!.validate();
  }

  StockInCondition() {
    return expenseKey.currentState!.validate() && vendorIdKey.currentState!.validate() && PrefUtils.getGaushalaId.toString() == "02" || PrefUtils.getGaushalaId.toString() == "03"
        ? RFOKey.currentState!.validate()
        : partyNameKey.currentState!.validate() &&
            partyNameKey.currentState!.validate() &&
            paymentTypeKey.currentState!.validate() &&
            rfoTypeKey.currentState!.validate() &&
            itemNameKey.currentState!.validate() &&
            BillKey.currentState!.validate() &&
            QtyKey.currentState!.validate() &&
            kgPerUnitKey.currentState!.validate() &&
            totalWtOrQtyKey.currentState!.validate() &&
            ratePerUnitKey.currentState!.validate() &&
            totalAmountKey.currentState!.validate() &&
            remarkKey.currentState!.validate();
  }

  MiscellaneousCondition() {
    return expenseKey.currentState!.validate() && vendorIdKey.currentState!.validate() && PrefUtils.getGaushalaId.toString() == "02" || PrefUtils.getGaushalaId.toString() == "03"
        ? RFOKey.currentState!.validate()
        : partyNameKey.currentState!.validate() &&
                partyNameKey.currentState!.validate() &&
                paymentTypeKey.currentState!.validate() &&
                rfoTypeKey.currentState!.validate() &&
                itemNameKey.currentState!.validate() &&
                BillKey.currentState!.validate() &&
                IsStock() == true
            ? ratePerUnitKey.currentState!.validate()
            : totalAmountKey.currentState!.validate() && remarkKey.currentState!.validate();
  }

  FuelCondition() {
    return expenseKey.currentState!.validate() && vehicleNoKey.currentState!.validate();
  }

  StockOutCondition() {
    return expenseKey.currentState!.validate();
  }

  SweetMaterialCondition() {
    return vendorIdKey.currentState!.validate() && PrefUtils.getGaushalaId.toString() == "02" || PrefUtils.getGaushalaId.toString() == "03"
        ? RFOKey.currentState!.validate()
        : partyNameKey.currentState!.validate() &&
            partyNameKey.currentState!.validate() &&
            paymentTypeKey.currentState!.validate() &&
            rfoTypeKey.currentState!.validate() &&
            itemNameKey.currentState!.validate() &&
            BillKey.currentState!.validate() &&
            QtyKey.currentState!.validate() &&
            kgPerUnitKey.currentState!.validate() &&
            ratePerUnitKey.currentState!.validate() &&
            totalAmountKey.currentState!.validate();
  }

  ALlControllerClear() {
    qtyController.clear();
    kgPerUnitController.clear();
    remarkController.clear();
    RFONumberController.clear();
    BillNumberController.clear();
    ratePerUnitController.clear();
    totalWtOrQtyController.clear();
    totalAmountController.clear();
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("dd-MM-yyyy").parse(date);

    String formattedDate = DateFormat("yyyy-MM-dd").format(inputDate);

    return formattedDate;
  }

  String billDateFormat({required String date}) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);

    String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);

    return formattedDate;
  }

  StockIn(BuildContext context) {
    stockInReqList.add(
      ExpenseAddBulkRequest(
        rfoNo: RFONumberController.text,
        gaushalaId: PrefUtils.getGaushalaId.toString(),
        vendorId: expenseController.text == 'Stipend' ? '00' : vendorId(vendorIdController.text),
        billNo: BillNumberController.text,
        itemId: itemId(),
        expenceType: expenseController.text,
        qty: qtyController.text.isEmpty || qtyController.text == "" ? '' : qtyController.text,
        kgPerUnit: kgPerUnitController.text == '' || kgPerUnitController.text.isEmpty || kgPerUnitController.text == '0' ? 0.0 : double.parse(kgPerUnitController.text),
        ratePerUnit: ratePerUnitController.text == '' || ratePerUnitController.text.isEmpty || ratePerUnitController.text == '0' ? 0.0 : double.parse(ratePerUnitController.text),
        totalWtOrQty: totalWtOrQtyController.text == '' || totalWtOrQtyController.text.isEmpty ? 0.0 : double.parse(totalWtOrQtyController.text),
        totalAmount: totalAmountController.text == '' || totalAmountController.text.isEmpty ? 0.0 : double.parse(totalAmountController.text),
        entryBy: retrievedData!['user_id'],
        remark: remarkController.text == '' || remarkController.text.isEmpty
            ? expenseController.text == 'Repairs & Maintenance'
                ? '${vehicleNoController.text}'
                : ''
            : "${vehicleNoController.text == 'Vehicle No' ? '' : vehicleNoController.text} - ${remarkController.text}",
        isStock: IsStock(),
        date: rfoDateController.text.isEmpty ? DateFormat('yyyy-MM-dd').format(DateTime.now()) : convertDateFormat(date: rfoDateController.text),
        rfo_type: rfoTypeController.text == "EXPANSE"
            ? 1
            : rfoTypeController.text == "PURCHASE"
                ? 2
                : 3,
        paymentType: paymentTypeController.text == "ONLINE"
            ? 1
            : paymentTypeController.text == "CARD PAY"
                ? 2
                : 3,
        vendorName: partyNameController.text,
        fromDate: selectOnDate.isTrue
            ? onDateController.text.isEmpty
                ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                : convertDateFormat(date: onDateController.text)
            : fromDateController.text.isEmpty
                ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                : convertDateFormat(date: fromDateController.text),
        toDate: selectOnDate.isTrue
            ? "1900-01-01"
            : toDateController.text.isEmpty
                ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                : convertDateFormat(date: toDateController.text),
        bill_date: expenseController.text == "NA"
            ? ""
            : billDateController.text.isEmpty
                ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                : convertDateFormat(date: billDateController.text),
        sgst: GSTController.text.isEmpty ? "0" : "${double.parse(GSTController.text) / 2}",
        cgst: GSTController.text.isEmpty ? "0" : "${double.parse(GSTController.text) / 2}",
      ),
    );
    stockInReqList.refresh();
    addedSum();

    qtyController.clear();
    kgPerUnitController.clear();
    remarkController.clear();
    ratePerUnitController.clear();
    totalWtOrQtyController.clear();
    totalAmountController.clear();
    selectedItemName.value = 'itemName';
    itemNameController.text = 'itemName';
    selectedVehicleNo.value = 'Vehicle No';
    vehicleNoController.clear();
    addItemWidgetList.clear();

    CattleToast.msg(
      "item added",
    );
  }

  void addedSum() {
    addedTotal.value = 0.0;
    GstTotal.value = 0.0;
    for (var data in stockInReqList) {
      addedTotal.value += data.totalAmount;
      double itemGstPercent = (double.tryParse(data.cgst) ?? 0.0) + (double.tryParse(data.sgst) ?? 0.0);
      GstTotal.value += data.totalAmount + (data.totalAmount * (itemGstPercent / 100));
    }
  }

  addGst() {
    double cgstPercentage = GSTController.text.isEmpty ? 0.0 : double.tryParse(GSTController.text) ?? 0.0;
    double baseAmount = addedTotal.value;
    double cgstAmount = baseAmount * (cgstPercentage / 100);
    GstTotal.value = baseAmount + cgstAmount;
    return GstTotal.value;
  }

  GSTCalculation({required double Percentage, required double total}) {
    RxDouble TotalGstValue = 0.0.obs;
    double cgstAmount = total * (Percentage / 100);
    TotalGstValue.value = total + cgstAmount;
    return TotalGstValue.value;
  }

  stockOutItem() {
    for (var data in itemMaster) {
      if (data.stockOut.isTrue) {
        stockOutReqList.add(ExpenseRequest(
          itemId: data.itemId,
          expenceType: expenseController.text,
          totalWtOrQty: data.StockOutController.text == '' || data.StockOutController.text.isEmpty ? 0.0 : double.parse(data.StockOutController.text),
          entryBy: retrievedData!['user_id'],
          remark: remarkController.text == '' || remarkController.text.isEmpty
              ? expenseController.text == 'Fuel'
                  ? '${vehicleNoController.text}'
                  : ''
              : "${vehicleNoController.text == 'Vehicle No' ? '' : vehicleNoController.text} - ${remarkController.text}",
          isStock: IsStock(),
          date: rfoDateController.text.isEmpty ? DateFormat('yyyy-MM-dd').format(DateTime.now()) : convertDateFormat(date: rfoDateController.text),
        ));
      }
    }
  }

  Future<void> StockInApi(BuildContext context) async {
    AppLoader().show();
    await WebService.MultiPartRequest(
      token: PrefUtils.getToken.toString(),
      images: selectedImages.map((e) => e.path.toString()).toList(),
      items: expenseAddBulkRequestToJson(stockInReqList),
      url: ApiClient.stockAddBulk,
    ).then((value) async {
      AppLoader().hide();
      ExpenseAddBulkResponse expenseAddBulkResponse = await expenseAddBulkResponseFromJson(value);
      try {
        if (expenseAddBulkResponse.message == "Your request is successfully executed") {
          LastRfo();
          stockInReqList.clear();
          qtyController.clear();
          kgPerUnitController.clear();
          remarkController.clear();
          RFONumberController.clear();
          BillNumberController.clear();
          ratePerUnitController.clear();
          totalWtOrQtyController.clear();
          totalAmountController.clear();
          partyNameController.clear();
          paymentTypeController.clear();
          rfoTypeController.clear();
          billDateController.clear();
          // rfoController.clear();
          fromDateController.clear();
          toDateController.clear();
          selectOnDate.value = false;
          selectedImages.clear();
          GSTController.clear();

          CattleToast.msg(expenseAddBulkResponse.message);
        } else {
          CattleToast.msg(expenseAddBulkResponse.message);
          print("*******************statusCode***********************");
          print("*******************statusCode***********************");
          _changeStatus(DataStatus.error);
        }
      } catch (error, s) {
        AppLoader().hide();
        print('##########################################################$s');
        print("******************Catch**ERROR**********************");
        print(error.toString());
        CattleToast.msg(error.toString());
        print("********************ERROR**********************");
        _changeStatus(DataStatus.error);
      }
    });

    return;
  }

  Future<void> StockOut(BuildContext context) async {
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.stock,
      body: expenseRequestToJson(stockOutReqList),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        // ExpenseResponse expenseResponse =
        //     await expenseResponseFromJson(response.data);
        // nowStock.value = 0.0;
        for (var data in itemMaster) {
          if (data.stockOut.isTrue) {
            data.stock.value = 0.0;
            data.StockOutController.clear();
          }
        }

        stockOutReqList.clear();
        SearchItemList.clear();
        itemNameController.clear();
        expenseController.clear();
        ratePerUnitController.clear();
        remarkController.clear();
        totalWtOrQtyController.clear();

        // CattleToast.msg(response.data.m);

        print(response.statusCode);
      } else {
        print("*******************statusCode***********************");
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
        print("*******************statusCode***********************");
        _changeStatus(DataStatus.error);
      }
    } catch (error, s) {
      AppLoader().hide();
      print('##########################################################$s');
      print("******************Catch**ERROR**********************");
      print(error.toString());
      CattleToast.msg(error.toString());
      print("********************ERROR**********************");
      _changeStatus(DataStatus.error);
    }
    return;
  }

  Future<void> StockList(BuildContext context) async {
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.stockList,
      body: stockListRequestToJson(
        StockListRequest(
          startDate: LastStock.value == true
              ? DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 7)))
              : StartDateController.text.isEmpty
                  ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                  : convertDateFormat(date: StartDateController.text),
          endDate: LastStock.value == true
              ? DateFormat('yyyy-MM-dd').format(DateTime.now())
              : EndDateController.text.isEmpty
                  ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                  : convertDateFormat(date: EndDateController.text),
          expenceType: StockExpenseTypeController.text.isEmpty ? [] : [StockExpenseTypeController.text],
          itemId: StockItemIDController.text.isEmpty ? [] : [ItemId(StockItemIDController.text)],
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        StockListResponse stockListResponse = stockListResponseFromJson(response.data);
        stockData.value = stockListResponse.stockData;
        LastStock.value == true ? Get.toNamed(AppRoutes.expenseEntryDetailsHistory) : Get.back();
        StartDateController.clear();
        EndDateController.clear();
        StockExpenseTypeController.clear();
        StockItemIDController.clear();
        print(response.statusCode);
      } else {
        print("*******************statusCode***********************");
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
        print("*******************statusCode***********************");
        _changeStatus(DataStatus.error);
      }
    } catch (error, s) {
      AppLoader().hide();
      print('##########################################################$s');
      print("******************Catch**ERROR**********************");
      print(error.toString());
      CattleToast.msg(error.toString());
      print("********************ERROR**********************");
      _changeStatus(DataStatus.error);
    }
  }

  Future<void> LastRfo() async {
    Response response = await WebService.cmGetRequestWithToken(
      url: ApiClient.lastRFONo,
      body: '',
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        LastRfoNumberResponse lastRfoNumberResponse = lastRfoNumberResponseFromJson(response.data);
        lastRfoNumber.value = lastRfoNumberResponse.lastRfoData;
      } else {
        print("*******************statusCode***********************");
        print(response.statusCode);
        print("*******************statusCode***********************");
        _changeStatus(DataStatus.error);
      }
    } catch (error, s) {
      print('##########################################################$s');
      print("******************Catch**ERROR**********************");
      print(error.toString());
      print("********************ERROR**********************");
      _changeStatus(DataStatus.error);
    }
    return;
  }

  Future<void> CancelRFO() async {
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.CancelRFO,
      body: cancelRfoRequestToJson(CancelRfoRequest(rfoNo: RFONumberController.text)),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        CancelRfoResponse cancelRfoResponse = cancelRfoResponseFromJson(response.data);
        RFONumberController.clear();
        CattleToast.msg(
          cancelRfoResponse.message,
        );
        print(response.statusCode);
      } else {
        print("*******************statusCode***********************");
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
        print("*******************statusCode***********************");
        _changeStatus(DataStatus.error);
      }
    } catch (error, s) {
      AppLoader().hide();
      print('##########################################################$s');
      print("******************Catch**ERROR**********************");
      print(error.toString());
      CattleToast.msg(error.toString());
      print("********************ERROR**********************");
      _changeStatus(DataStatus.error);
    }
    return;
  }

  Future<void> GetItemStock() async {
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.getItemStock,
      body: getItemStockRequestToJson(GetItemStockRequest(
        year: DateFormat("yyyy").format(stockOutDate),
        month: DateFormat("MM").format(stockOutDate),
        itemId: itemId(),
      )),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        print("get Response");
        GetItemStockResponse getItemStockResponse = getItemStockResponseFromJson(response.data);
        for (var item in itemMaster) {
          if (item.itemId == itemId()) {
            item.stock.value = getItemStockResponse.data.closingQtyOfItem;
          }
        }

        print("${getItemStockResponse.data.closingQtyOfItem} stock");
        print("object object object object object object object object object object object");
        // nowStock.value = getItemStockResponse.data.closingQtyOfItem;

        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } catch (error, s) {
      AppLoader().hide();
      print("${error} - ${s}");
    }
    return;
  }

  Future<void> RFOHistory({required String rfoNumber}) async {
    rfoHistoryList.clear();
    rfoPrintList.clear();
    rfoTotalAmount.value = 0.0;
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.getRFODetails,
      body: getRfoDetailsRequestToJson(GetRfoDetailsRequest(rfoNo: rfoNumber)),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        print("get Response");
        GetRfoDetailsResponse getRfoDetailsResponse = getRfoDetailsResponseFromJson(response.data);
        for (var data in getRfoDetailsResponse.getRfoDetailsData) {
          rfoHistoryList.add(data);
          for (var item in data.items) {
            if (rfoNumber == data.rfoNo) {
              rfoPrintList.add(item);
              rfoTotalAmount.value += item.totalAmount;
            }
          }
        }
        checkAddData();
        print(response.statusCode);
      } else {
        AppLoader().hide();
        print(response.statusCode);
      }
    } catch (error, s) {
      AppLoader().hide();
      print("${error} - ${s}");
    }
    return response.data;
  }

  void checkAddData() {
    AppLoader().show();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppLoader().hide();
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("PRINT"),
            content: Container(
              height: 500,
              width: 500,
              child: PdfPreview(
                build: (format) => generatePdf(),
                initialPageFormat: PdfPageFormat.a4,
              ),
            ),
          );
        },
      );
    });
  }

  removeBrekets({required String data}) {
    String formatted = data.substring(1, data.length - 1);

    return formatted;
  }

  Future<Uint8List> generatePdf() async {
    final doc = pw.Document();
    final List<String> imageUrls = rfoHistoryList[0].items[0].billImage;
    final ByteData image = await rootBundle.load("assets/images/Gaushala RF - rf-Form_page-0001.jpg");

    Uint8List RFOImage = (image).buffer.asUint8List();
    List<pw.MemoryImage> images = [];
    for (String url in imageUrls) {
      int retries = 3;
      while (retries > 0) {
        try {
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            images.add(pw.MemoryImage(response.bodyBytes));
            break; // Exit the retry loop if successful
          } else {
            retries--;
            if (retries == 0) {
              throw Exception('Failed to load image after multiple attempts');
            }
          }
        } catch (e) {
          retries--;
          if (retries == 0) {
            throw Exception('Failed to load image after multiple attempts');
          }
          await Future.delayed(Duration(seconds: 2)); // Wait before retrying
        }
      }
    }

    doc.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Center(
                      child: pw.Text('VAIDIC DHARAMA SANSTHAN',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Center(
                    child: pw.Text(
                        PrefUtils.getGaushalaId.toString() == "01"
                            ? '21 K.M,VVMVP CAMPUS, KANAKAPURA MAIN ROAD,UDAYAPURA, BANGALORE SOUTH TALUK - 560082'
                            : "Ved Vignan Maha Vidhya Peeth Ankalavadi Village, Vasad Sarsa Road, Vasad , Gujarat 388306",
                        style: pw.TextStyle(fontSize: 9)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.RichText(
                          text: pw.TextSpan(
                              text: 'PARTY NAME : ',
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline,
                              ),
                              children: [
                                pw.TextSpan(
                                  text: '${removeBrekets(data: rfoHistoryList.map((element) => element.vendorName).toString().toUpperCase())}',
                                  style: pw.TextStyle(decoration: pw.TextDecoration.underline, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 10),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.RichText(
                          text: pw.TextSpan(
                              text: 'DEPARTMENT : ',
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline,
                              ),
                              children: [
                                pw.TextSpan(
                                  text: 'GAUSHALA',
                                  style: pw.TextStyle(decoration: pw.TextDecoration.underline, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 10),
                                )
                              ]),
                        ),
                        pw.RichText(
                          text: pw.TextSpan(
                              text: 'DATE : ',
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              children: [
                                pw.TextSpan(
                                  text: '${billDateFormat(date: removeBrekets(data: rfoHistoryList.map((element) => element.date).toString()))}',
                                  style: pw.TextStyle(fontWeight: pw.FontWeight.normal, color: PdfColors.black, fontSize: 10),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.RichText(
                          text: pw.TextSpan(
                              text: 'MODE OF PAYMENT : ',
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline,
                              ),
                              children: [
                                pw.TextSpan(
                                  text: '${rfoHistoryList[0].paymentType == 1 ? "ONLINE" : rfoHistoryList[0].paymentType == 2 ? "CARD PAY" : "CHEQUE".toUpperCase()}',
                                  style: pw.TextStyle(decoration: pw.TextDecoration.underline, color: PdfColors.black, fontWeight: pw.FontWeight.normal, fontSize: 10),
                                )
                              ]),
                        ),
                        pw.RichText(
                          text: pw.TextSpan(text: 'RF. NO. : ', style: pw.TextStyle(color: PdfColors.black, fontSize: 9, fontWeight: pw.FontWeight.bold), children: [
                            pw.TextSpan(
                              text: '${removeBrekets(data: rfoHistoryList.map((element) => element.rfoNo).toString())}',
                              style: pw.TextStyle(fontWeight: pw.FontWeight.normal, color: PdfColors.red, fontSize: 12),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Table.fromTextArray(
              headers: [
                'SL.No',
                'Bill No',
                'Bill Date',
                'Paid to',
                'Qty',
                'Rate',
                '',
                '',
                'Total',
              ],
              data: List<List<String>>.generate(
                rfoPrintList.length,
                (index) => [
                  '${index + 1}',
                  '${rfoPrintList[index].billNo}',
                  '${rfoHistoryList[0].items[0].expenceType == "NA" ? "" : billDateFormat(date: rfoPrintList[index].billDate)}',
                  '${rfoPrintList[index].remark.toString().toUpperCase()}',
                  '${rfoPrintList[index].qty}',
                  '${rfoPrintList[index].ratePerUnit.toStringAsFixed(2)}',
                  '',
                  '',
                  '${NumberFormat('#,##,##0').format(rfoPrintList[index].totalAmount.toDouble())}',
                ],
              ),
              columnWidths: {
                0: pw.FixedColumnWidth(40),
                1: pw.FixedColumnWidth(40),
                2: pw.FixedColumnWidth(60),
                3: pw.FixedColumnWidth(90),
                4: pw.FixedColumnWidth(40),
                5: pw.FixedColumnWidth(50),
                6: pw.FixedColumnWidth(40),
                7: pw.FixedColumnWidth(40),
                8: pw.FixedColumnWidth(60),
              },
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
              cellStyle: pw.TextStyle(fontSize: 8),
              headerAlignment: pw.Alignment.center,
              cellAlignment: pw.Alignment.center,
            ),
            pw.Table.fromTextArray(
              cellAlignment: pw.Alignment.centerLeft,
              headerAlignment: pw.Alignment.center,
              headerStyle: pw.TextStyle(
                fontSize: 7,
              ),
              cellStyle: pw.TextStyle(
                fontSize: 7,
              ),
              border: pw.TableBorder.all(
                color: PdfColors.black,
                width: 1,
              ),
              columnWidths: {
                0: pw.FixedColumnWidth(340), // Fixed size for the first column
                1: pw.FixedColumnWidth(60), // Fixed size for the second column
                2: pw.FixedColumnWidth(60), // Fixed size for the second column
              },
              data: [
                [
                  "",
                  'TOTAL',
                  NumberFormat('#,##,##0').format(rfoTotalAmount.toDouble()),
                ],
              ],
            ),
            pw.Table.fromTextArray(
              cellAlignment: pw.Alignment.centerLeft,
              headerAlignment: pw.Alignment.center,
              headerStyle: pw.TextStyle(
                fontSize: 7,
              ),
              cellStyle: pw.TextStyle(
                fontSize: 7,
              ),
              border: pw.TableBorder.all(
                color: PdfColors.black,
                width: 1,
              ),
              columnWidths: {
                0: pw.FixedColumnWidth(340),
                1: pw.FixedColumnWidth(60),
                2: pw.FixedColumnWidth(60),
              },
              data: [
                [
                  "",
                  'CGST',
                  "${rfoHistoryList[0].cgst} %",
                ],
              ],
            ),
            pw.Table.fromTextArray(
              cellAlignment: pw.Alignment.centerLeft,
              headerAlignment: pw.Alignment.center,
              headerStyle: pw.TextStyle(
                fontSize: 7,
              ),
              cellStyle: pw.TextStyle(
                fontSize: 7,
              ),
              border: pw.TableBorder.all(
                color: PdfColors.black,
                width: 1,
              ),
              columnWidths: {
                0: pw.FixedColumnWidth(340),
                1: pw.FixedColumnWidth(60),
                2: pw.FixedColumnWidth(60),
              },
              data: [
                [
                  "",
                  'SGST',
                  "${rfoHistoryList[0].sgst} %",
                ],
              ],
            ),
            pw.Table.fromTextArray(
              cellAlignment: pw.Alignment.centerLeft,
              headerAlignment: pw.Alignment.center,
              headerStyle: pw.TextStyle(
                fontSize: 7,
              ),
              cellStyle: pw.TextStyle(
                fontSize: 7,
              ),
              border: pw.TableBorder.all(
                color: PdfColors.black,
                width: 1,
              ),
              columnWidths: {
                0: pw.FixedColumnWidth(100),
                2: pw.FixedColumnWidth(100),
              },
              data: [
                [
                  'TOTAL AMOUNT',
                  "${converter.convertAmountToWords(GSTCalculation(Percentage: double.parse(rfoHistoryList[0].cgst) * 2, total: rfoTotalAmount.toDouble()), ignoreDecimal: true).toUpperCase()} ONLY",
                  NumberFormat('#,##,##0').format(GSTCalculation(Percentage: double.parse(rfoHistoryList[0].cgst) * 2, total: rfoTotalAmount.toDouble())),
                ],
              ],
            ),
            pw.Padding(
              padding: pw.EdgeInsets.only(top: 20, bottom: 10),
              child: pw.RichText(
                text: pw.TextSpan(
                    text: 'PURPOSE DESCRIPTION : ',
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                    ),
                    children: [
                      pw.TextSpan(
                        text: rfoHistoryList[0].items[0].expenceType == "NA"
                            ? "TOWARDS THE PAYMENT FOR ADVANCE AGAINST STIPEND OF ${rfoHistoryList[0].vendorName.toUpperCase()}"
                            : billDateFormat(date: removeBrekets(data: rfoHistoryList.map((element) => element.toDate).toString())) != "01-01-1900"
                                ? 'TOWARDS THE PAYMENT FOR ${removeBrekets(data: '${rfoHistoryList.map((element) => element.rfoType)}') == "1" ? "EXPANSE" : removeBrekets(data: '${rfoHistoryList.map((element) => element.rfoType)}') == "2" ? "PURCHASE" : "ADVANCE AGAINST STIPEND".toUpperCase()} ${removeBrekets(data: rfoPrintList.map((element) => element.remark).toString()).toUpperCase()} FROM ${billDateFormat(date: removeBrekets(data: rfoHistoryList.map((element) => element.fromDate).toString()))} TO ${billDateFormat(date: removeBrekets(data: rfoHistoryList.map((element) => element.toDate).toString()))}'
                                : 'TOWARDS THE PAYMENT FOR ${removeBrekets(data: '${rfoHistoryList.map((element) => element.rfoType)}') == "1" ? "EXPANSE" : removeBrekets(data: '${rfoHistoryList.map((element) => element.rfoType)}') == "2" ? "PURCHASE" : "ADVANCE AGAINST STIPEND".toUpperCase()} ${removeBrekets(data: rfoPrintList.map((element) => element.remark).toString()).toUpperCase()} ON ${billDateFormat(date: removeBrekets(data: rfoHistoryList.map((element) => element.fromDate).toString()))}',
                        style: pw.TextStyle(
                          decoration: pw.TextDecoration.underline,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.normal,
                          fontSize: 10,
                        ),
                      )
                    ]),
              ),
            ),
            pw.Spacer(),
            pw.Container(
              child: pw.Column(children: [
                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                        pw.Text('Submitted by', style: pw.TextStyle(fontSize: 9)),
                        pw.Text('date', style: pw.TextStyle(fontSize: 9)),
                      ]),
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                        pw.Text('Approved by', style: pw.TextStyle(fontSize: 9)),
                        pw.Text('date', style: pw.TextStyle(fontSize: 9)),
                      ]),
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                        pw.Text('Payment', style: pw.TextStyle(fontSize: 9)),
                        pw.Text('date', style: pw.TextStyle(fontSize: 9)),
                      ]),
                    ],
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Text('NOTE : ', style: pw.TextStyle(fontSize: 9)),
                    pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                      pw.Text('1. All the expenses should be provided with suitable bill/invoices', style: pw.TextStyle(fontSize: 9)),
                      pw.Text('2. Bills pertaining to the expense period only will be passed for payment.', style: pw.TextStyle(fontSize: 9)),
                    ]),
                  ],
                ),
              ]),
            ),
            pw.Image(pw.MemoryImage(RFOImage)),
            for (var image in images)
              pw.Container(
                height: 700,
                child: pw.Image(image),
              ),
          ];
        },
      ),
    );

    return doc.save();
  }

  _changeStatus(DataStatus value) => dataStatus(value);
}
