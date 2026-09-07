import 'package:cattle_app/presentation/dairy_usage_screen/dairy_usage_history_screen.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/models/milkUsageHistoryRequest.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/models/milkUsageHistoryResponse.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:cattle_app/presentation/dairy_usage_screen/models/milkUsageResponse.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/models/todayMilkUsageResponse.dart';
import 'package:cattle_app/presentation/dashboard_screen/controller/dashboard_controller.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/pref_utils.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/apiClient/api_methods.dart';
import '../../common file/defaultVariablesList.dart';
import '../models/milkUsageRequest.dart';

enum DataStatus { loading, done, error }

class DairyUsageController extends GetxController {
  Rx<DataStatus> dataStatus = DataStatus.loading.obs;

  TextEditingController literController = TextEditingController();

  TextEditingController usedInController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController distributionController = TextEditingController();

  TextEditingController startDateController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  DashboardController dashboardController = Get.put(DashboardController());
  RxBool distribution = false.obs;
  RxBool milkUsageDay = false.obs;

  RxString todaysMilk = ''.obs;
  RxString todayMilkUsage = ''.obs;
  RxString morningMilkUsage = ''.obs;
  RxString eveningMilkUsage = ''.obs;
  RxString morningMilk = ''.obs;
  RxString eveningMilk = ''.obs;

  TextEditingController dayTimeController = TextEditingController();
  GlobalKey<FormState> dayTimeKey = GlobalKey<FormState>();

  TextEditingController filterDayTimeController = TextEditingController();

  HistoryData? historyData;

  RxList<MilkUsageHistoryDatum> MilkUsageHistoryList = <MilkUsageHistoryDatum>[]
      .obs;

  TodayMilkUsageResponse? todayMilkUsageResponse;

  GlobalKey<FormState> literKey = GlobalKey<FormState>();
  GlobalKey<FormState> usedInKey = GlobalKey<FormState>();
  GlobalKey<FormState> distributionKey = GlobalKey<FormState>();

  void onInit() {
    super.onInit();
    cmTodayMilkUsageApi();
    retrieveCowData();
    todaysMilk.value = dashboardController.dashBoardDataResponse!.data.todaysMilk.toStringAsFixed(1);
    todayMilkUsage.value = dashboardController.dashBoardDataResponse!.data.todayMilkUsage.toStringAsFixed(1);
    morningMilkUsage.value = (dashboardController.dashBoardDataResponse!.data.morningMilkUsage ?? 0.0).toStringAsFixed(1);
    eveningMilkUsage.value = (dashboardController.dashBoardDataResponse!.data.eveningMilkUsage ?? 0.0).toStringAsFixed(1);
    morningMilk.value = (dashboardController.dashBoardDataResponse!.data.morningMilk ?? 0.0).toStringAsFixed(1);
    eveningMilk.value = (dashboardController.dashBoardDataResponse!.data.eveningMilk ?? 0.0).toStringAsFixed(1);
  }

  isDistribution(String selected) {
    if (selected == "Distribution-Free") {
      return distribution.value = true;
    } else {
      return distribution.value = false;
    }
  }

  Future<void> cmDairyUsageEntry(BuildContext context) async {
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.milkUsage,
      body: milkUsageRequestToJson(
        MilkUsageRequest(
          liter: literController.text,
          usedIn: usedInController.text,
          description: descriptionController.text,
          distributionPerson: distributionController.text.isEmpty
              ? ""
              : distributionController.text,
          dayTime: dayTimeController.text.toLowerCase(),
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        MilkUsageResponse milkUsageResponse =
        milkUsageResponseFromJson(response.data);
        if (milkUsageResponse.status.toString() == "SUCCESS") {
          literController.clear();
          usedInController.clear();
          distributionController.clear();
          descriptionController.clear();
          dashboardController.cmDashBoardData();
          dashboardController.getReminders();
          CattleToast.msg(milkUsageResponse.message);
        } else {
          CattleToast.msg(milkUsageResponse.message);
          print("****************status ${milkUsageResponse.status}**************************");
        }
      } else {
        CattleToast.msg(response.statusMessage!);
        print("*******************statusCode${response.statusCode}***********************");
      }
    } catch (error) {
      CattleToast.msg(error.toString());
      print("********************ERROR${error.toString()}**********************");
    }
    return;
  }

  Future<void> DairyUsageHistory() async {
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.milkUsageHistory,
      body: milkUsageHistoryRequestToJson(
        MilkUsageHistoryRequest(
          startDate: milkUsageDay.value == true ?
          DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 7)))
              : startDateController.text.isEmpty
              ? ''
              : convertDateFormat(date: startDateController.text),
          endDate: milkUsageDay.value == true ?
          DateFormat('yyyy-MM-dd').format(DateTime.now())
              : endDateController.text.isEmpty
              ? ''
              : convertDateFormat(date: endDateController.text),
          dayTime: filterDayTimeController.text.isEmpty ? null : filterDayTimeController.text.toLowerCase(),
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        MilkUsageHistoryResponse milkUsageHistoryResponse =
        milkUsageHistoryResponseFromJson(response.data);
        if (milkUsageHistoryResponse.status.toString() == "SUCCESS") {
          MilkUsageHistoryList.value = milkUsageHistoryResponse.milkUsageHistoryData;
          milkUsageDay.isTrue ? Get.to(DairyUsageHistoryScreen()):Get.back();
          CattleToast.msg(milkUsageHistoryResponse.message);
        } else {
          MilkUsageHistoryList.value = [];
          milkUsageDay.isTrue ? Get.to(DairyUsageHistoryScreen()):Get.back();
          CattleToast.msg(milkUsageHistoryResponse.message);
          print("****************status ${milkUsageHistoryResponse.status}**************************");
        }
      } else {
        CattleToast.msg(response.statusMessage!);
        print("*******************statusCode${response.statusCode}***********************");
      }
    } catch (error) {
      CattleToast.msg(error.toString());
      print("********************ERROR${error.toString()}**********************");
    }
    return;
  }

  Future<void> cmTodayMilkUsageApi() async {
    final Response response = await WebService.cmGetRequestWithToken(
      url: ApiClient.todayMilkUsage,
      body: '',
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        todayMilkUsageResponse = todayMilkUsageResponseFromJson(response.data);
        if (todayMilkUsageResponse!.status == "SUCCESS") {
          historyData = todayMilkUsageResponse!.data;
          CattleToast.msg(todayMilkUsageResponse!.message);
          _changeStatus(DataStatus.done);
        } else {
          print(todayMilkUsageResponse!.status);
          CattleToast.msg(todayMilkUsageResponse!.message);
          _changeStatus(DataStatus.error);
        }
      } else {
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
        _changeStatus(DataStatus.error);
      }
    } catch (error) {
      print(error.toString());
      CattleToast.msg(error.toString());
      _changeStatus(DataStatus.error);
    }
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("dd-MM-yyyy").parse(date);

    String formattedDate = DateFormat("yyyy-MM-dd").format(inputDate);

    return formattedDate;
  }

  _changeStatus(DataStatus value) => dataStatus(value);
}
