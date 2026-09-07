import 'package:cattle_app/core/utils/pref_utils.dart';
import 'package:cattle_app/presentation/report_screen/model/monthlyReportRequest.dart';
import 'package:cattle_app/widgets/loder.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;

import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';

class GuashalaReportScreenController extends GetxController {
  RxInt Report = 1.obs;
  RxList<String> emailList = <String>[].obs;

  RxInt selectedYear = DateTime.now().year.obs;
  RxInt selectedMonth =  DateTime.now().month.obs;

  TextEditingController emailIDController = TextEditingController();
  GlobalKey<FormState> emailIDKey = GlobalKey<FormState>();

  Future<void> SendReport() async {
    AppLoader().show();
    final Response response = await WebService.cmPostWithTokenRequest(
      url: Report.value == 1
          ? ApiClient.sendExpenseReport
          : Report.value == 2
              ? ApiClient.sendProfitLossReport
              : ApiClient.sendSalesEmail,
      body: monthlyReportRequestToJson(MonthlyReportRequest(
          mail: emailList,
          reqYear: selectedYear.value.toString(),
          reqMonth: selectedMonth.value.toString())),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        AppLoader().hide();
        CattleToast.msg("Successfully Send Report");
        selectedYear.value =  DateTime.now().year;
        selectedMonth.value =  DateTime.now().month;
        emailList.clear();
      } else {
        AppLoader().hide();
        CattleToast.msg("Error");
        print("*******************statusCode***********************");
        print(response.statusCode);
        print("*******************statusCode***********************");
      }
    } catch (error) {
      AppLoader().hide();
      CattleToast.msg("Error");
      print("********************ERROR**********************");
      print(error.toString());
      print("********************ERROR**********************");
    }
    return;
  }
}
