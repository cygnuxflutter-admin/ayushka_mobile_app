import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/presentation/attendance_screen/models/absent_employee_list/absent_employee_list_request.dart';
import 'package:cattle_app/presentation/attendance_screen/models/attendance_histroy/attendance_histroy_request.dart';
import 'package:cattle_app/presentation/attendance_screen/models/attendance_histroy/attendane_history_response.dart';
import 'package:cattle_app/presentation/attendance_screen/models/attendance_submit/attendance_submit_request.dart';
import 'package:cattle_app/presentation/attendance_screen/models/update_attendence/update_attendence_request.dart';
import 'package:cattle_app/presentation/attendance_screen/models/update_attendence/update_attendence_response.dart';
import 'package:cattle_app/presentation/attendance_screen/page/user_history_page.dart';
import 'package:cattle_app/widgets/loder.dart';
import 'package:cattle_app/widgets/toast_message/toast_message.dart';

import '../../core/utils/pref_utils.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/api_methods.dart';
import 'models/absent_employee_list/absent_employee_list_response.dart';
import 'models/all_emp_attendance_history/all_emp_attendance_history_request.dart';
import 'models/all_emp_attendance_history/all_emp_attendance_history_response.dart';
import 'models/attend_employee_list/AttendEmployeeList.dart';
import 'models/attendance_submit/attendence_submit_response.dart';

enum AttendanceDataStatus { loading, done, error }

class AttendanceScreenController extends GetxController {
  Rx<AttendanceDataStatus> attendanceDataStatus =
      AttendanceDataStatus.loading.obs;
  Rx<AttendanceDataStatus> allEmpHistoryStatus = AttendanceDataStatus.loading.obs;
  Rx<AttendanceDataStatus> absentDataStatus = AttendanceDataStatus.loading.obs;
  RxBool SelectAll = false.obs;
  late AttendEmployeeListResponse attendEmployeeListResponse;

  RxList<EmployeeDetailsList> employeeList = <EmployeeDetailsList>[].obs;
  RxList<AttendanceEmployeeList> attendanceEmployeeList =
      <AttendanceEmployeeList>[].obs;
  RxList<AttendanceEmployeeList> absentEmployeeList =
      <AttendanceEmployeeList>[].obs;
  RxList<AttendanceEmployeeList> presentEmployeeList =
      <AttendanceEmployeeList>[].obs;
  RxList<EmpHistoryDatum> AllEmpHistoryList = <EmpHistoryDatum>[].obs;
  RxList<EmpHistoryDatum> AllEmpPresentHistoryList = <EmpHistoryDatum>[].obs;
  RxList<EmpHistoryDatum> AllEmpAbsentHistoryList = <EmpHistoryDatum>[].obs;

  RxList<AttendanceHistoryList> attendanceHistoryListD =
      <AttendanceHistoryList>[].obs;
  Rx<AttendanceDataStatus> emyCalLoader = AttendanceDataStatus.loading.obs;
  RxString selectedHistoryDate = ''.obs;
  RxString absentSearchQuery = ''.obs;
  RxString presentSearchQuery = ''.obs;
  RxString mainSearchQuery = ''.obs;
  Rx<DateTime> historyStartDate = DateTime.now().subtract(const Duration(days: 7)).obs;
  Rx<DateTime> historyEndDate = DateTime.now().obs;
  RxString historyEmployeeId = 'SSG'.obs;
  Rx<String?> historyErrorMessage = Rx<String?>(null);
  TextEditingController searchController = TextEditingController();
  TextEditingController absentSearchController = TextEditingController();
  TextEditingController presentSearchController = TextEditingController();
  TextEditingController empHistoryDateController = TextEditingController();

  void onInit() {
    empListApi();
    super.onInit();
  }

  RxList<EmployeeDetailsList> updateFilteredItemList(String query) {
    List<EmployeeDetailsList> ListTamp;
    if (query != '') {
      ListTamp = employeeList
          .where((data) =>
              data.empId.toLowerCase().contains(query.toLowerCase()) ||
              data.payrollName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      ListTamp = employeeList;
    }
    return ListTamp.obs;
  }

  EmpHistoryListShot(List<EmpHistoryDatum> TapList) {
    TapList.sort((a, b) {
      final genderA = a.gender;
      final genderB = b.gender;

      if (genderA == 'FEMALE' && genderB == 'MALE') {
        return -1;
      } else if (genderA == 'MALE' && genderB == 'FEMALE') {
        return 1;
      } else {
        return a.empId.compareTo(b.empId);
      }
    });
  }

  RxList<AttendanceEmployeeList> absentFilteredItemList(String query) {
    List<AttendanceEmployeeList> listData;
    if (query != '') {
      listData = absentEmployeeList
          .where((data) =>
              data.empId.toLowerCase().contains(query.toLowerCase()) ||
              data.payrollName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      listData = absentEmployeeList;
    }

    return listData.obs;
  }

  RxList<AttendanceEmployeeList> presentFilteredItemList(String query) {
    List<AttendanceEmployeeList> listData;
    if (query != '') {
      listData = presentEmployeeList
          .where((data) =>
              data.empId.toLowerCase().contains(query.toLowerCase()) ||
              data.payrollName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      listData = presentEmployeeList;
    }
    return listData.obs;
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("dd-MM-yyyy").parse(date);

    String formattedDate = DateFormat("yyyy-MM-dd").format(inputDate);

    return formattedDate;
  }

  Future<void> allEmpHistory({
    required BuildContext context,
  }) async {
    allEmpHistoryStatus.value = AttendanceDataStatus.loading;
    Response response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.empHistory,
      body: allEmpAttendanceHistoryRequestToJson(
        AllEmpAttendanceHistoryRequest(
          startDate: empHistoryDateController.text.isEmpty
              ? DateFormat('yyyy-MM-dd').format(DateTime.now())
              : convertDateFormat(date: empHistoryDateController.text),
          endDate: empHistoryDateController.text.isEmpty
              ? DateFormat('yyyy-MM-dd').format(DateTime.now())
              : convertDateFormat(date: empHistoryDateController.text),
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        AllEmpAttendanceHistoryResponse allEmpAttendanceHistoryResponse =
            allEmpAttendanceHistoryResponseFromJson(response.data);
        if (allEmpAttendanceHistoryResponse.status == 'SUCCESS') {
          AllEmpHistoryList.value =
              allEmpAttendanceHistoryResponse.empHistoryData;
          AllEmpAbsentHistoryList.value =
              AllEmpHistoryList.where((emp) => emp.attendanceType != "Present")
                  .toList();
          AllEmpPresentHistoryList.value =
              AllEmpHistoryList.where((emp) => emp.attendanceType == "Present")
                  .toList();
          EmpHistoryListShot(AllEmpPresentHistoryList);
          EmpHistoryListShot(AllEmpAbsentHistoryList);
          CattleToast.msg(allEmpAttendanceHistoryResponse.message);
          allEmpHistoryStatus.value = AttendanceDataStatus.done;
        } else {
          allEmpHistoryStatus.value = AttendanceDataStatus.error;
          print("emp History List  ${allEmpAttendanceHistoryResponse.message}");
          CattleToast.msg(allEmpAttendanceHistoryResponse.message);
        }
      } else {
        allEmpHistoryStatus.value = AttendanceDataStatus.error;
        print("emp History List  ${response.statusMessage}");
        CattleToast.msg(response.statusMessage!);
      }
    } catch (error) {
      allEmpHistoryStatus.value = AttendanceDataStatus.error;
      print("emp History List  ${error}");
    }
  }

  ///Attendance Employee List Api Method
  Future<void> empListApi() async {
    try {
      final response = await WebService.cmGetRequestWithToken(
          url: ApiClient.empList,
          body: '',
          token: PrefUtils.getToken.toString());
      if (response.statusCode == 200) {
        attendEmployeeListResponse =
            attendEmployeeListResponseFromJson(response.data);

        if (attendEmployeeListResponse.status == 'SUCCESS') {
          employeeList.value = attendEmployeeListResponse.employeeList;
          employeeList.removeWhere((element) => element.isActive == false);
          await absentEmpListApi();
          changeStatus(AttendanceDataStatus.done);
        } else {
          CattleToast.msg(attendEmployeeListResponse.message);
          print(attendEmployeeListResponse.message);
          changeStatus(AttendanceDataStatus.error);
        }
        print(response.statusCode);
      } else {
        print(response.statusCode);
        CattleToast.msg(response.statusMessage!);
        changeStatus(AttendanceDataStatus.error);
      }
    } catch (error) {
      print("Attendance Employee error ${error.toString()}");
      changeStatus(AttendanceDataStatus.error);
    }
  }

  changeStatus(AttendanceDataStatus value) => attendanceDataStatus(value);

  ///Absent employee list api method
  Future<void> absentEmpListApi() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.absentEmpList,
      body: absentEmployeeListRequestToJson(
        AbsentEmployeeListRequest(date: formattedDate),
      ),
      token: PrefUtils.getToken.toString(),
    );
    try {
      if (response.statusCode == 200) {
        AbsentEmployeeListResponse absentEmployeeListResponse =
            absentEmployeeListResponseFromJson(response.data);
        if (absentEmployeeListResponse.status == 'SUCCESS') {
          absentEmployeeList.value =
              absentEmployeeListResponse.attendanceEmployeeList;
          updateEmployeeList(employeeList, absentEmployeeList);
        } else if (absentEmployeeListResponse.status == 'RECORD_NOT_FOUND') {
          CattleToast.msg(absentEmployeeListResponse.message);
          print("Absent ${absentEmployeeListResponse.message}");
        }
      } else {
        CattleToast.msg(response.statusMessage!);
        print("Absent  ${response.statusMessage}");
      }
    } catch (error) {
      print("Absent api ${error}");
    }
    return;
  }

  /// Update employee list
  updateEmployeeList(List<EmployeeDetailsList> employeeList,
      List<AttendanceEmployeeList> attendanceEmployeeList) {
    List<EmployeeDetailsList> updatedEmployeeList = List.from(employeeList);

    if (attendanceEmployeeList.isNotEmpty) {
      List<AttendanceEmployeeList> copyAttendanceList =
          List.from(attendanceEmployeeList);

      absentEmployeeList.value = copyAttendanceList
          .where((element) => element.attendanceType == 'Absent')
          .toList();
      presentEmployeeList.value = copyAttendanceList
          .where((element) => element.attendanceType != 'Absent')
          .toList();
      for (var attendance in copyAttendanceList) {
        updatedEmployeeList
            .removeWhere((data) => data.empId == attendance.empId);
      }
    }
    employeeList.clear();
    employeeList.addAll(updatedEmployeeList);
    print(employeeList.length);
  }

  /// Attendance submit api request method
  List<AttendanceSubmitList> attendanceSubmitRequest(String attendanceType) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    List<AttendanceSubmitList> attendanceSubmitList = <AttendanceSubmitList>[];
    for (var details in employeeList) {
      if (details.isPresentAbsent.value == true) {
        attendanceSubmitList.add(
          AttendanceSubmitList(
            empId: details.empId,
            date: formattedDate,
            attendanceType:
                "${details.isFullDay.value == false ? 'HalfDay' : attendanceType}",
            leaveType: '',
            remark: '',
          ),
        );
      }
    }
    return attendanceSubmitList;
  }

  /// Attendance submit api method
  Future<void> attendanceSubmitApi({
    required BuildContext context,
    required String attendanceType,
  }) async {
    bool isAtLeastOneSelected =
        employeeList.any((element) => element.isPresentAbsent.value);
    if (isAtLeastOneSelected) {
      AppLoader().show();
      final response = await WebService.cmPostWithTokenRequest(
        url: ApiClient.attendanceSubmit,
        body: attendanceSubmitRequestToJson(
          AttendanceSubmitRequest(
            attendanceSubmitList: attendanceSubmitRequest(attendanceType),
          ),
        ),
        token: PrefUtils.getToken.toString(),
      );
      AppLoader().hide();
      try {
        if (response.statusCode == 200) {
          AttendanceSubmitResponse attendanceSubmitResponse =
              attendanceSubmitResponseFromJson(response.data);
          if (attendanceSubmitResponse.status == 'SUCCESS') {
            removeListEmployee(employeeList);
            updateFilteredItemList("");
            employeeList.refresh();
            absentEmpListApi();
            CattleToast.msg(attendanceSubmitResponse.message);
          } else {
            print("Attendance submit  ${attendanceSubmitResponse.message}");
            CattleToast.msg(attendanceSubmitResponse.message);
          }
        } else {
          print("Attendance submit  ${response.statusMessage}");
          CattleToast.msg(response.statusMessage!);
        }
      } catch (error) {
        AppLoader().hide();
        print("Attendance error  ${error}");
        CattleToast.msg(error.toString());
      }
    } else {
      CattleToast.msg("At list select one employee");
    }
  }

  /// Remove employees from the list
  removeListEmployee(List<EmployeeDetailsList> employeeList) {
    List<EmployeeDetailsList> updatedEmployeeList = List.from(employeeList);

    for (var data in employeeList) {
      if (data.isPresentAbsent.value == true) {
        updatedEmployeeList.remove(data);
      }
    }
    employeeList.clear();
    employeeList.addAll(updatedEmployeeList);
  }

  /// Attendance submit api request method
  presentSubmitRequest(String attendanceType) {
    for (var details in presentEmployeeList) {
      if (details.isSelect.value == true) {
        return UpdateAttendanceRequest(
          empId: details.empId,
          date: details.date,
          attendanceType: attendanceType,
          remark: '',
          leaveType: '',
        );
      }
    }
  }

  String? findId() {
    String? selectedEmployeeId;
    for (var data in presentEmployeeList) {
      if (data.isSelect.value) {
        selectedEmployeeId = data.id;
        break;
      }
    }
    return selectedEmployeeId;
  }

  /// Update Attendance api method
  Future<void> UpdateAttendanceApi({
    required BuildContext context,
    required String attendanceType,
    required String id,
  }) async {
    bool isAtLeastOneSelected =
        presentEmployeeList.any((element) => element.isSelect.value);
    if (isAtLeastOneSelected) {
      AppLoader().show();
      final response = await WebService.cmPostWithTokenRequest(
        url: ApiClient.updateAttendance + id,
        body: updateAttendanceRequestToJson(
          presentSubmitRequest(attendanceType),
        ),
        token: PrefUtils.getToken.toString(),
      );
      AppLoader().hide();
      try {
        if (response.statusCode == 200) {
          UpdateAttendanceResponse updateAttendanceResponse =
              updateAttendanceResponseFromJson(response.data);
          if (updateAttendanceResponse.status == 'SUCCESS') {
            PresentRemoveListEmployee();
            absentEmpListApi();
            CattleToast.msg(updateAttendanceResponse.message);
          } else {
            print(
                "Update Attendance submit  ${updateAttendanceResponse.message}");
            CattleToast.msg(updateAttendanceResponse.message);
          }
        } else {
          print("Update Attendance submit  ${response.statusMessage}");
          CattleToast.msg(
            response.statusMessage!,
          );
        }
      } catch (error) {
        AppLoader().hide();
        print("Update Attendance error  ${error}");
        CattleToast.msg(
          "${error}",
        );
      }
    } else {
      CattleToast.msg(
        "At list select one employee",
      );
    }
  }

  /// Remove employees from the PresentList
  PresentRemoveListEmployee() {
    List<AttendanceEmployeeList> updatedEmployeeList =
        List.from(presentEmployeeList);

    for (var data in presentEmployeeList) {
      if (data.isSelect.value == true) {
        updatedEmployeeList.remove(data);
      }
    }
    presentEmployeeList.clear();
    presentEmployeeList.addAll(updatedEmployeeList);
  }

  Future<void> attendanceHistory({
    required BuildContext context,
    required String startDate,
    required String endDate,
    required List<String> empId,
  }) async {
    String startFormattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate));
    String endFormattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate));
    emyCalLoader(AttendanceDataStatus.loading);

    AppLoader().show();
    final response = await WebService.cmPostWithTokenRequest(
      url: ApiClient.attendanceHistory,
      body: attendanceHistoryRequestToJson(
        AttendanceHistoryRequest(
          startDate: startFormattedDate,
          endDate: endFormattedDate,
          empId: empId,
        ),
      ),
      token: PrefUtils.getToken.toString(),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        AttendanceHistoryResponse attendanceHistoryResponse =
            attendanceHistoryResponseFromJson(response.data);
        if (attendanceHistoryResponse.status == 'SUCCESS') {
          attendanceHistoryListD(
              attendanceHistoryResponse.attendanceHistoryList);
          Get.back();
          emyCalLoader(AttendanceDataStatus.done);
          Get.to(
            UserHistory(
              attendanceHistoryListDup: attendanceHistoryListD,
              minDay: DateTime.parse(startDate),
              maxDay: DateTime.parse(endDate),
            ),
          );
          CattleToast.msg(
            attendanceHistoryResponse.message,
          );
        } else {
          print("Attendance History  ${attendanceHistoryResponse.message}");
          emyCalLoader(AttendanceDataStatus.error);
          CattleToast.msg(
            attendanceHistoryResponse.message,
          );
        }
      } else {
        print("Attendance History  ${response.statusMessage}");
        emyCalLoader(AttendanceDataStatus.error);
        CattleToast.msg(
          response.statusMessage!,
        );
      }
    } catch (error) {
      AppLoader().hide();
      emyCalLoader(AttendanceDataStatus.error);
      print("Attendance History error  ${error}");
      CattleToast.msg(
        "RECORD NOT FOUND",
      );
    }
  }

  ///present list short
  PresentAbsentShot(List<AttendanceEmployeeList> TapList) {
    TapList.sort((a, b) {
      final genderA = a.gender;
      final genderB = b.gender;

      if (genderA == 'FEMALE' && genderB == 'MALE') {
        return -1;
      } else if (genderA == 'MALE' && genderB == 'FEMALE') {
        return 1;
      } else {
        return a.empId.compareTo(b.empId);
      }
    });
  }
}
