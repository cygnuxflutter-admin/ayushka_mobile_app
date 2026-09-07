import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:cattle_app/presentation/hr_screen/models/employeeListResponse.dart';
import 'package:cattle_app/presentation/hr_screen/models/partial_update/partial_update_request.dart';
import 'package:cattle_app/presentation/hr_screen/models/partial_update/partial_update_response.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';

import '../../core/utils/pref_utils.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';

enum DataStatus { loading, done, error }

class HrScreenController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  EmployeeListResponse? employeeListResponse;

  RxList<Employee> employeeList = <Employee>[].obs;

  Rx<DataStatus> dataStatus = DataStatus.loading.obs;

  void onInit() {
    cmEmployeeList();
    super.onInit();
  }

  void updateFilteredItemList(String query) {
    if (query != '') {
      employeeList.value = employeeListResponse!.data.data
          .where(
              (data) => data.empId.toLowerCase().contains(query.toLowerCase())||data.payrollName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      employeeList.value = employeeListResponse!.data.data;
    }
  }

  Future<void> cmEmployeeList() async {
    try {
      final Response response = await WebService.cmPostWithTokenRequest(
        url: ApiClient.employeeList,
        body: "", token:  PrefUtils.getToken.toString(),
      );

      if (response.statusCode == 200) {
        employeeListResponse = employeeListResponseFromJson(response.data);
        if (employeeListResponse!.status == "SUCCESS") {
          employeeList.value = employeeListResponse!.data.data;

          employeeList.refresh();
          changeStatus(DataStatus.done);
        } else {
          print("****************status**************************");
          print(employeeListResponse!.status);
          print("****************status**************************");
          changeStatus(DataStatus.error);
        }
      } else {
        print("*******************statusCode***********************");
        print(response.statusCode);
        print("*******************statusCode***********************");
        changeStatus(DataStatus.error);
      }
    } catch (error) {
      print("******************Catch**ERROR**********************");
      print(error.toString());
      print("********************ERROR**********************");
      changeStatus(DataStatus.error);
    }
    return;
  }

  changeStatus(DataStatus value) => dataStatus(value);

  Future<void> employeePartialUpdateApi({
    required BuildContext context,
    required bool isActive,
    required String id,
  }) async {
    final Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.partialUpdate + id,
      body: partialUpdateRequestToJson(
        PartialUpdateRequest(isActive: isActive),
      ),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        PartialUpdateResponse partialUpdateResponse =
            partialUpdateResponseFromJson(response.data);
        if (partialUpdateResponse.status == "SUCCESS") {
          CattleToast.msg(partialUpdateResponse.message,);
        } else {
          CattleToast.msg(partialUpdateResponse.message,);
          print(employeeListResponse!.status);
        }
      } else {
        CattleToast.msg(response.statusMessage!,);
        print(response.statusCode);
      }
    } catch (error) {
      CattleToast.msg(
       error.toString(),
      );
    }
  }
}
