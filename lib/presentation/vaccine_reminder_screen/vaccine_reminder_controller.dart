import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/data/apiClient/api_client.dart';
import 'package:cattle_app/data/apiClient/api_methods.dart';
import 'package:cattle_app/presentation/vaccine_reminder_screen/models/vaccine_reminder_request.dart' as req;
import 'package:cattle_app/presentation/vaccine_reminder_screen/models/vaccine_reminder_response.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../../../widgets/loder.dart';

class VaccineReminderController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<CowReminder> cowReminders = <CowReminder>[].obs;
  TextEditingController cowIdController = TextEditingController();
  RxString cowIdText = ''.obs;

  @override
  void onReady() {
    super.onReady();
    fetchPendingVaccines();
  }

  Future<void> fetchPendingVaccines({String? tagId}) async {
    isLoading.value = true;
    AppLoader().show();
    try {
      var request = req.VaccineReminderRequest(
        query: req.Query(tagId: tagId),
        options: req.Options(page: 1, limit: 100, pagination: true),
      );

      final dio.Response response = await WebService.cmPostWithTokenRequest(
        url: ApiClient.pendingVaccinesList,
        body: req.vaccineReminderRequestToJson(request),
        token: PrefUtils.getToken.toString(),
      );

      if (response.statusCode == 200) {
        var resData = vaccineReminderResponseFromJson(response.data);
        if (resData.status == "SUCCESS" && resData.data != null) {
          cowReminders.value = resData.data!.data;
        } else {
          cowReminders.clear();
        }
      } else {
        cowReminders.clear();
      }
    } catch (e) {
      print("Error fetching vaccine reminders: $e");
      cowReminders.clear();
    } finally {
      AppLoader().hide();
      isLoading.value = false;
    }
  }
}
