import 'dart:convert';
import 'dart:io';
import 'package:cattle_app/presentation/sales_entry/model/sales_transaction_response.dart';
import 'package:cattle_app/routes/app_routes.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';

import 'package:cattle_app/presentation/sales_entry/model/sales_transaction_request.dart';
import 'package:vision_gallery_saver/vision_gallery_saver.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';
import '../../widgets/loder.dart';
import '../common file/defaultVariablesList.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'model/sales_transaction_history/sales_transaction_history_request.dart';
import 'model/sales_transaction_history/sales_transaction_history_response.dart';

enum DataStatus { loading, done, error }

class SalesEntryController extends GetxController {
  TextEditingController departmentNameController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController QTYController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController driverController = TextEditingController();

  TextEditingController locationController = TextEditingController();
  TextEditingController DateController = TextEditingController();

  TextEditingController StartDateController = TextEditingController();
  TextEditingController EndDateController = TextEditingController();

  RxBool itemSelect = false.obs;
  RxBool showSticker = false.obs;
  RxBool showHistorySticker = false.obs;

  RxBool LastSalesHistory = false.obs;
  Rx<DataStatus> dataStatus = DataStatus.loading.obs;

  RxString departmentNameText = 'Department Name'.obs;
  RxString itemNameText = 'Item Name'.obs;
  RxString dateText = ''.obs;
  RxBool printSelect = (PrefUtils.getSelectPrint ?? false).obs;

  GlobalKey globalKey = GlobalKey();

  GlobalKey? historyGlobalKey;

  MethodChannel channel = MethodChannel("cattleManagement.com/method");

  late SalesData salesData;

  RxInt salesDataSleepNumber = 0.obs;

  GlobalKey<FormState> departmentNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> itemNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> QTYKey = GlobalKey<FormState>();

  GlobalKey<FormState> mobileKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailIdKey = GlobalKey<FormState>();
  List<String> printList = [];
  RxList<Datum> SalesHistory = <Datum>[].obs;

  RxString dName = "".obs;
  RxString itemName = "".obs;
  RxDouble qty = 0.0.obs;
  RxDouble rate = 0.0.obs;
  RxString mobileNumber = "".obs;
  RxString vehicleNumber = "".obs;
  RxString driverName = "".obs;
  RxString date = "".obs;
  RxString time = "".obs;
  RxString location = "".obs;
  RxInt sleepNumber = 0.obs;

  @override
  void onInit() {
    retrieveCowData();
    globalKey = GlobalKey();
    super.onInit();
  }


  // Future<dynamic> printImageByMethodChannel(String arg) async {
  //   await channel.invokeListMethod("launchIntent", arg).then((value) => print(" heloooooooo" + value!.toList().toString() + " heloooooooo"));
  // }

  static const MethodChannel _channel =
  MethodChannel("cattleManagement.com/method");

  Future<void> printImageByMethodChannel(String base64Image) async {
    try {
      await _channel.invokeMethod("printImage", {
        "image": base64Image,
      });
    } catch (e) {
      print("Print Error: $e");
    }
  }


  String findDepartmentId(String name) {
    for (var item in departmentName) {
      if (item.value == name) {
        return item.id;
      }
    }
    return '';
  }

  String findEmailID(String name) {
    for (var item in departmentName) {
      if (item.value == name) {
        return emailIdController.text = item.emailId;
      }
    }
    return '';
  }

  Object findMobileNo(String Name) {
    for (var items in departmentName) {
      if (items.value == Name) {
        return mobileController.text = items.mobileNo.obs.toString();
      }
    }
    return 0.obs;
  }

  RxInt itemRate() {
    for (var item in salesItem) {
      if (item.itemName == itemNameController.text) {
        return item.ratePerUnit.obs;
      }
    }
    return 0.obs;
  }

  RxString itemUnit() {
    for (var item in salesItem) {
      if (item.itemName == itemNameController.text) {
        return item.unit.obs;
      }
    }
    return ''.obs;
  }

  RxString itemQty() {
    for (var item in salesItem) {
      if (item.itemName == itemNameController.text) {
        return item.pieceQty.obs;
      }
    }
    return ''.obs;
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("dd-MM-yyyy").parse(date);

    String formattedDate = DateFormat("yyyy-MM-dd").format(inputDate);

    return formattedDate;
  }

  Future<void> SalesTransaction(
    BuildContext context,
  ) async {
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.salesTransaction,
      body: salesTransactionRequestToJson(
        SalesTransactionRequest(
          departmentId: findDepartmentId(departmentNameController.text),
          departmentName: departmentNameController.text,
          itemName: itemNameController.text,
          qty: double.parse(QTYController.text),
          rate: itemRate().value,
          total: total(),
          mobileNumber: mobileController.text,
          email: emailIdController.text,
          vehicleNumber: vehicleNumberController.text == '' || vehicleNumberController.text.isEmpty
              ? ''
              : vehicleNumberController.text,
          driverName: driverController.text == '' || driverController.text.isEmpty
                  ? ''
                  : driverController.text,
          date: DateController.text.isEmpty
              ? DateFormat('yyyy-MM-dd').format(DateTime.now())
              : convertDateFormat(date: DateController.text),
          gaushalaId: PrefUtils.getGaushalaId.toString(),
          time: DateFormat('HH:mm:ss').format(DateTime.now().toUtc()),
          location: locationController.text == '' || locationController.text.isEmpty
                  ? ''
                  : locationController.text,
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        SalesTransactionResponse salesTransactionResponse = await salesTransactionResponseFromJson(response.data);
        showSticker.value = true;
        if (salesTransactionResponse.status == "SUCCESS") {
          salesData = salesTransactionResponse.salesData;
          salesDataSleepNumber.value = salesData.sleepNumber;
          print(salesData);
          if (PrefUtils.getSelectPrint == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              captureAndSaveScreenshot(context, globalKey);
            });
          } else {
            departmentNameController.clear();
            departmentNameText.value = 'Department Name';
            itemNameController.clear();
            itemNameText.value = 'Item Name';
            QTYController.clear();
            rateController.clear();
            mobileController.clear();
            emailIdController.clear();
            DateController.clear();
            dateText.value = '';
            vehicleNumberController.clear();
            driverController.clear();
            locationController.clear();
          }
          print(response.statusCode);
          CattleToast.msg(salesTransactionResponse.message);
        }
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

  Future<void> SalesTransactionHistory(BuildContext context) async {
    AppLoader().show();
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.salesTransactionHistory,
      body: salesTransactionHistoryRequestToJson(
        SalesTransactionHistoryRequest(
          startDate: LastSalesHistory.value == true
              ? DateFormat('yyyy-MM-dd').format(
                  DateTime.now().subtract(const Duration(days: 7),),
                )
              : StartDateController.text.isEmpty
                  ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                  : convertDateFormat(date: StartDateController.text),
          endDate: LastSalesHistory.value == true
              ? DateFormat('yyyy-MM-dd').format(DateTime.now())
              : EndDateController.text.isEmpty
                  ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                  : convertDateFormat(date: EndDateController.text),
          itemName: itemNameController.text.isEmpty ||
                  itemNameController.text == 'itemName'
              ? []
              : [itemNameController.text],
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        SalesTransactionHistoryResponse salesTransactionHistoryResponse = salesTransactionHistoryResponseFromJson(response.data);
        SalesHistory.value = salesTransactionHistoryResponse.salesTransactionData.data;
        LastSalesHistory.value == true
            ? Get.toNamed(AppRoutes.sealsTransaction)
            : Get.back();
        CattleToast.msg(
         salesTransactionHistoryResponse.message,
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

  int total() {
    double total;
    total = double.parse(QTYController.text) * double.parse(rateController.text);
    return total.toInt();
  }

  // Future<void> captureAndSaveScreenshot(
  //     BuildContext context, GlobalKey globalKey) async {
  //   print("Screen short done");
  //   RenderRepaintBoundary boundary = await globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage(); //sdf
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   if (byteData != null) {
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //     final directory = await getApplicationDocumentsDirectory();
  //     final imagePath = '${directory.path}/screenshot.png';
  //     await File(imagePath).writeAsBytes(pngBytes);
  //     final result = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes));
  //     String base64String = base64Encode(pngBytes);
  //     printImageByMethodChannel(base64String);
  //
  //     if (result['isSuccess']) {
  //       AppLoader().show();
  //       print('Screenshot saved in gallery');
  //       departmentNameController.clear();
  //       itemNameController.clear();
  //       QTYController.clear();
  //       rateController.clear();
  //       DateController.clear();
  //       mobileController.clear();
  //       emailIdController.clear();
  //       vehicleNumberController.clear();
  //       driverController.clear();
  //       locationController.clear();
  //       AppLoader().hide();
  //     } else {
  //       print('Failed to save screenshot in gallery');
  //     }
  //   }
  // }
  //
  // Future<void> captureAndSaveHistoryScreenshot({
  //   required BuildContext context,
  //   required GlobalKey historyGlobalKey,
  // }) async {
  //   RenderRepaintBoundary boundary = historyGlobalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage();
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //
  //   if (byteData != null) {
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //     final directory = await getApplicationDocumentsDirectory();
  //     final imagePath = '${directory.path}/screenshot.png';
  //     await File(imagePath).writeAsBytes(pngBytes);
  //     final result = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes));
  //     String base64String = base64Encode(pngBytes);
  //     printImageByMethodChannel(base64String);
  //
  //     if (result['isSuccess']) {
  //       AppLoader().show();
  //       dName.value = '';
  //       itemName.value = '';
  //       qty.value = 0;
  //       rate.value = 0;
  //       mobileNumber.value = '';
  //       vehicleNumber.value = '';
  //       driverName.value = '';
  //       date.value = '';
  //       sleepNumber.value = 0;
  //       time.value = '';
  //       location.value = '';
  //       AppLoader().hide();
  //     } else {
  //       print('Failed to save screenshot in gallery');
  //     }
  //   }
  // }


  Future<void> captureAndSaveScreenshot(
      BuildContext context, GlobalKey globalKey) async {

    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      /// 🔥 Convert to base64
      String base64String = base64Encode(pngBytes);

      /// 🔥 OPEN PRINT PREVIEW (IMPORTANT)
      await printImageByMethodChannel(base64String);

      /// 🔥 OPTIONAL – Gallery Save
      final result = await VisionGallerySaver.saveImage(
        pngBytes,
        name: "screenshot_${DateTime.now().millisecondsSinceEpoch}",
        androidRelativePath: "Pictures/CattleApp",
      );

      if (result['isSuccess'] == true) {

        AppLoader().show();

        departmentNameController.clear();
        departmentNameText.value = 'Department Name';
        itemNameController.clear();
        itemNameText.value = 'Item Name';
        QTYController.clear();
        rateController.clear();
        DateController.clear();
        dateText.value = '';
        mobileController.clear();
        emailIdController.clear();
        vehicleNumberController.clear();
        driverController.clear();
        locationController.clear();

        AppLoader().hide();

        print("Screenshot saved successfully");
      } else {
        print("Failed to save screenshot");
      }

    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> captureAndSaveHistoryScreenshot({
    required BuildContext context,
    required GlobalKey historyGlobalKey,
  }) async {

    try {
      RenderRepaintBoundary boundary =
      historyGlobalKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      /// 🔥 Convert to base64
      String base64String = base64Encode(pngBytes);

      /// 🔥 OPEN PRINT PREVIEW
      await printImageByMethodChannel(base64String);

      final result = await VisionGallerySaver.saveImage(
        pngBytes,
        name: "history_${DateTime.now().millisecondsSinceEpoch}",
        androidRelativePath: "Pictures/CattleApp",
      );

      if (result['isSuccess'] == true) {

        AppLoader().show();

        dName.value = '';
        itemName.value = '';
        qty.value = 0;
        rate.value = 0;
        mobileNumber.value = '';
        vehicleNumber.value = '';
        driverName.value = '';
        date.value = '';
        sleepNumber.value = 0;
        time.value = '';
        location.value = '';

        AppLoader().hide();

        CattleToast.msg("History screenshot saved successfully");

        print("History screenshot saved successfully");

      } else {
        print("Failed to save history screenshot");
      }

    } catch (e) {
      print("Error: $e");
    }
  }

  _changeStatus(DataStatus value) => dataStatus(value);
}
