import 'dart:convert';

import 'package:cattle_app/data/apiClient/api_client.dart';
import 'package:cattle_app/data/apiClient/api_methods.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/controller/dairy_usage_controller.dart';
import 'package:cattle_app/presentation/dashboard_screen/models/dashBoardDataResponse.dart';
import 'package:cattle_app/presentation/dashboard_screen/models/getReminders_Response.dart';
import 'package:cattle_app/presentation/splashScreen/models/defaultVariables_response.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/pref_utils.dart';
import '../../milk_screen/controller/milk_controller.dart';
import '../models/getLatestAppVersion_response.dart';

enum DataStatus { loading, done, error }

class DashboardController extends GetxController {
  RxBool isNetOn = false.obs;

  MilkController milkController = Get.put(MilkController());
  Rx<DataStatus> dataStatus = DataStatus.loading.obs;
  DashBoardDataResponse? dashBoardDataResponse;
  RxBool activeConnection = false.obs;
  RxBool reminderData = false.obs;

  RxString todaysMilk = ''.obs;
  RxString todayMilkUsage = ''.obs;
  RxString milkingCows = ''.obs;
  RxString version = '29.08.26'.obs;
  RxString appUrl = ''.obs;

  CowData? cowData;

  Map<String, dynamic>? retrievedData = PrefUtils.getData;

  GetReminderData? getReminderData;
  @override
  void onInit() {
    getLatestAppVersion();
    cmDashBoardData();
    defaultVariable();
    getReminders();
    milkController.cmCowList();
    Connectivity().checkConnectivity().then((value) => noInterNetDialog(value));
    Connectivity().onConnectivityChanged.listen((event) {
      noInterNetDialog(event);
    });
    Connectivity().onConnectivityChanged.listen((event) {
      activeConnection.value = (ConnectivityResult.none == event) ? false : true;
      if (activeConnection.value) {
        noInterNetDialog(event);
      } else if (activeConnection.value == false) {}
    });

    super.onInit();
  }

  void noInterNetDialog(List<ConnectivityResult> result) {
    bool isConnected = (result != ConnectivityResult.none);
    if (!isConnected) {
      Get.defaultDialog(
        title: 'No Internet Connection',
        backgroundColor: Colors.white,
        middleText: 'Please check your internet connection and try again.',
        barrierDismissible: false,
        confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: const Text('OK', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Connectivity().checkConnectivity().then((value) {
              if (value == ConnectivityResult.none) {
                isNetOn = false.obs;
              } else {
                Get.back();
                isNetOn = true.obs;
              }
            });
          },
        ),
      );
    }
  }

  Future<void> launchInBrowser() async {
    final Uri url = Uri.parse(appUrl.value);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void appUpdateDialog() {
    Get.defaultDialog(
      title: 'App Update',
      backgroundColor: Colors.white,
      middleText: 'Please Update App',
      barrierDismissible: false,
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        child: const Text('Update', style: TextStyle(color: Colors.white)),
        onPressed: () {
          launchInBrowser();
        },
      ),
    );
  }

  Future<void> cmDashBoardData() async {
    final Response response = await WebService.cmGetRequestWithToken(url: ApiClient.dashBoardData, body: '', token: PrefUtils.getToken.toString());
    // try {
    if (response.statusCode == 200) {
      dashBoardDataResponse = dashBoardDataResponseFromJson(response.data);
      todaysMilk.value = dashBoardDataResponse!.data.todaysMilk.toStringAsFixed(1);
      todayMilkUsage.value = dashBoardDataResponse!.data.todayMilkUsage.toStringAsFixed(1);
      milkingCows.value = dashBoardDataResponse!.data.milkingCows.toString();

      // Ensure morning and evening usages are handled
      if (Get.isRegistered<DairyUsageController>()) {
        Get.find<DairyUsageController>().morningMilkUsage.value = (dashBoardDataResponse!.data.morningMilkUsage ?? 0.0).toStringAsFixed(1);
        Get.find<DairyUsageController>().eveningMilkUsage.value = (dashBoardDataResponse!.data.eveningMilkUsage ?? 0.0).toStringAsFixed(1);
        Get.find<DairyUsageController>().morningMilk.value = (dashBoardDataResponse!.data.morningMilk ?? 0.0).toStringAsFixed(1);
        Get.find<DairyUsageController>().eveningMilk.value = (dashBoardDataResponse!.data.eveningMilk ?? 0.0).toStringAsFixed(1);
      }
      _changeStatus(DataStatus.done);
    } else {
      CattleToast.msg(response.statusMessage!);
      print("*******************statusCode***********************");
      print(response.statusCode);
      print("*******************statusCode***********************");
      _changeStatus(DataStatus.error);
    }
    // } catch (error) {
    //   print("********************ERROR**********************");
    //   print(error.toString());
    //   CattleToast.msg(error.toString());
    //   print("********************ERROR**********************");
    //   _changeStatus(DataStatus.error);
    // }
    return;
  }

  Future<void> getReminders() async {
    final Response response = await WebService.cmGetRequestWithToken(url: ApiClient.getReminders, body: '', token: PrefUtils.getToken.toString());
    // try {
    if (response.statusCode == 200) {
      reminderData.value = true;
      GetRemindersResponse getRemindersResponse = getRemindersResponseFromJson(response.data);
      getReminderData = getRemindersResponse.getReminderData;
    } else {
      CattleToast.msg(response.statusMessage!);
      print("*******************statusCode***********************");
      print(response.statusCode);
      print("*******************statusCode***********************");
    }
    // } catch (error) {
    //   print("********************ERROR**********************");
    //   print(error.toString());
    //   CattleToast.msg(error.toString());
    //   print("********************ERROR**********************");
    // }
    return;
  }

  Future<CowData?> defaultVariable() async {
    Response response = await WebService.cmGetRequestWithToken(url: ApiClient.defaultVariables, body: '', token: PrefUtils.getToken.toString());
    // try {
    if (response.statusCode == 200) {
      DefaultVariablesResponse defaultVariablesResponse = defaultVariablesResponseFromJson(response.data);
      String cowDataJson = json.encode(defaultVariablesResponse.data);
      await PrefUtils.setDefaultVariables(cowDataJson);
      cowData = defaultVariablesResponse.data;
      print(response.statusCode);
    } else {
      print("*******************statusCode***********************");
      print(response.statusCode);
      print("*******************statusCode***********************");
    }
    // } catch (error) {
    //   print("******************Catch**ERROR**********************");
    //   print(error.toString());
    //   print("********************ERROR**********************");
    // }
    return cowData;
  }

  Future<void> getLatestAppVersion() async {
    final Response response = await WebService.cmPostWithoutTokenRequest(url: ApiClient.getLatestAppVersion, body: '');

    try {
      if (response.statusCode == 200) {
        GetLatestAppVersionResponse getLatestAppVersionResponse = getLatestAppVersionResponseFromJson(response.data);
        if (getLatestAppVersionResponse.status.toString() == "SUCCESS") {
          if (version.value != getLatestAppVersionResponse.latestAppVersionData.appVersion) {
            appUrl.value = getLatestAppVersionResponse.latestAppVersionData.appLink;
            // appUpdateDialog();
          }
          getLatestAppVersionResponse.latestAppVersionData.appVersion;
          getLatestAppVersionResponse.latestAppVersionData.appLink;
        } else {
          print("****************status**************************");

          print("****************status**************************");
        }
      } else {
        print("*******************statusCode***********************");
        print(response.statusCode);
        print("*******************statusCode***********************");
      }
    } catch (error) {
      print("********************ERROR**********************111");
      print(error.toString());
      print("********************ERROR**********************");
    }
    return;
  }

  _changeStatus(DataStatus value) => dataStatus(value);
}
