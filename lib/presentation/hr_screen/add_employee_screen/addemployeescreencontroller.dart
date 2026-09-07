import 'package:cattle_app/presentation/attendance_screen/attendance_screen_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:cattle_app/data/apiClient/api_client.dart';
import 'package:cattle_app/data/apiClient/api_methods.dart';
import 'package:cattle_app/presentation/hr_screen/add_employee_screen/model/addEmployeeRequest.dart';
import 'package:cattle_app/presentation/hr_screen/add_employee_screen/model/addEmployeeResponse.dart';
import 'package:cattle_app/presentation/hr_screen/add_employee_screen/model/editEmployeeRequest.dart';
import 'package:cattle_app/presentation/hr_screen/add_employee_screen/model/editEmployeeResponse.dart';
import 'package:cattle_app/presentation/hr_screen/employe_detail_screen/employedetailscreencontroller.dart';
import 'package:cattle_app/widgets/loder.dart';

import '../../../core/utils/pref_utils.dart';
import '../../../routes/app_routes.dart';
import '../../common file/defaultVariablesList.dart';
import '../../cow_screen/cow_controller.dart';
import '../employe_detail_screen/model/getEmployeeDetailResponse.dart';
import 'model/update_Employee_Salary_Request.dart';
import 'model/update_Employee_Salary_Response.dart';

enum DataStatus { loading, done, error }

class AddEmployeeScreenController extends GetxController {
  EmployeeDetailScreenController employeeDetailScreenController =
      Get.put(EmployeeDetailScreenController());
  AttendanceScreenController attendanceScreenController =
      Get.put(AttendanceScreenController());

  TextEditingController empIdController = TextEditingController();
  TextEditingController payrollNameController = TextEditingController();
  TextEditingController joiningDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController aadhaarNameController = TextEditingController();
  TextEditingController parentSpouseNameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController aadhaarNumberController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController uanNoController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController pfNoController = TextEditingController();
  TextEditingController esiNoController = TextEditingController();
  TextEditingController salaryAmountController = TextEditingController();
  TextEditingController salaryDateController = TextEditingController();
  TextEditingController employeeCategoryController = TextEditingController();

  RxList<String> Gender = ['FEMALE', 'MALE'].obs;

  Rx<DataStatus> dataStatus = DataStatus.loading.obs;

  SingleEmployeeDetail? singleEmployeeDetail;
  RxBool EmpTemporary = false.obs;
  DateTime? dobInitialDate;

  GlobalKey<FormState> RFOKey = GlobalKey<FormState>();

  RxBool isMale = false.obs;
  RxBool isFemale = false.obs;
  RxBool isPermanent = false.obs;
  RxBool isTemporary = false.obs;

  RxString dobText = ''.obs;
  RxString joiningDateText = ''.obs;
  RxString salaryDateText = ''.obs;

  void onInit() {
    retrieveCowData();
    getTextData(argument: Get.arguments);
    super.onInit();
  }

  changeStatus(DataStatus value) => dataStatus(value);

  void getTextData({required String argument}) {
    if (argument == "PERSONAL" ||
        argument == "BANK" ||
        argument == "SALARY" ||
        argument == "OTHER") {
      getData();
    } else {
      changeStatus(DataStatus.done);
    }
  }

  Future<void> getData() async {
    final parameters = await Get.parameters;
    if (parameters != null) {
      singleEmployeeDetail =
          singleEmployeeDetailFromJson(parameters['employeeDetail']!);
      fillData(singleEmployeeDetail!);
    } else {
      changeStatus(DataStatus.error);
    }
  }

  void fillData(SingleEmployeeDetail singleEmployeeDetail) {
    empIdController = TextEditingController(
      text: singleEmployeeDetail.empId,
    );
    payrollNameController = TextEditingController(
      text: singleEmployeeDetail.payrollName,
    );
    joiningDateController = TextEditingController(
      text: singleEmployeeDetail.joiningDate,
    );
    genderController = TextEditingController(
      text: singleEmployeeDetail.gender,
    );
    aadhaarNameController = TextEditingController(
      text: singleEmployeeDetail.adharName,
    );
    parentSpouseNameController = TextEditingController(
      text: singleEmployeeDetail.parentSpouseName,
    );
    relationshipController = TextEditingController(
      text: singleEmployeeDetail.relationship,
    );
    dobController = TextEditingController(
      text: singleEmployeeDetail.dob,
    );
    dobText.value = singleEmployeeDetail.dob;
    aadhaarNumberController = TextEditingController(
      text: singleEmployeeDetail.adharNumber,
    );
    panCardController = TextEditingController(
      text: singleEmployeeDetail.panCard,
    );
    bankAccountController = TextEditingController(
      text: singleEmployeeDetail.bankAccount.toString(),
    );
    bankNameController = TextEditingController(
      text: singleEmployeeDetail.bankName,
    );
    ifscCodeController = TextEditingController(
      text: singleEmployeeDetail.ifscCode,
    );
    mobileNoController = TextEditingController(
      text: singleEmployeeDetail.mobileNumber.toString(),
    );
    uanNoController = TextEditingController(
      text: singleEmployeeDetail.uanNo.toString(),
    );
    remarkController = TextEditingController(
      text: singleEmployeeDetail.remark,
    );
    pfNoController = TextEditingController(
      text: singleEmployeeDetail.pfNo,
    );
    esiNoController = TextEditingController(
      text: singleEmployeeDetail.esiNo,
    );
    employeeCategoryController = TextEditingController(
      text: singleEmployeeDetail.category,
    );
    salaryAmountController = TextEditingController(
      text:
          "${singleEmployeeDetail.salaryInfo(empSalary: singleEmployeeDetail.salary).amountDecided}",
    );
    salaryDateController = TextEditingController(
      text:
          "${singleEmployeeDetail.salaryInfo(empSalary: singleEmployeeDetail.salary).date}",
    );
    salaryDateText.value = salaryDateController.text;
    joiningDateText.value = joiningDateController.text;

    changeStatus(DataStatus.done);
  }

  void checkAllData() {
    if (bankAccountController.text.isEmpty) {
      bankAccountController.text = "0";
    }
    if (payrollNameController.text.isEmpty ||
        genderController.text.isEmpty ||
        aadhaarNameController.text.isEmpty ||
        parentSpouseNameController.text.isEmpty ||
        relationshipController.text.isEmpty ||
        dobController.text.isEmpty ||
        aadhaarNumberController.text.isEmpty ||
        mobileNoController.text.isEmpty) {
    } else {
      AddEmployeeApi(
        addEmployeeRequest: AddEmployeeRequest(
          empId: empIdController.text.isEmpty?"":empIdController.text,
          payrollName: payrollNameController.text,
          joiningDate: joiningDateController.text.isEmpty ||
                  joiningDateController.text == ''
              ? DateFormat("yyyy-MM-dd").format(DateTime.now())
              : convertDateFormat(date: joiningDateController.text),
          gender: genderController.text,
          isEmpTemporary: isTemporary.isTrue?true:false,
          adharName: aadhaarNameController.text,
          parentSpouseName: parentSpouseNameController.text,
          relationship: relationshipController.text,
          dob: convertDateFormat(date: dobController.text),
          adharNumber: aadhaarNumberController.text,
          mobileNumber: int.parse(mobileNoController.text),
          panCard: panCardController.text.isEmpty ? '' : panCardController.text,
          bankName:
              bankNameController.text.isEmpty ? '' : bankNameController.text,
          bankAccount: bankAccountController.text.isEmpty
              ? 0
              : int.parse(bankAccountController.text),
          ifscCode:
              ifscCodeController.text.isEmpty ? '' : ifscCodeController.text,
          uanNo: uanNoController.text.isEmpty
              ? 0
              : int.parse(uanNoController.text),
          remark: remarkController.text.isEmpty ? '' : remarkController.text,
          pfNo: pfNoController.text.isEmpty ? '' : pfNoController.text,
          esiNo: esiNoController.text.isEmpty ? '' : esiNoController.text,
          category: employeeCategoryController.text,
          salary: [
            SalaryDetails(
              date: salaryDateController.text.isEmpty ||
                      salaryDateController.text == ''
                  ? DateFormat("yyyy-MM-dd").format(DateTime.now())
                  : convertDateFormat(date: salaryDateController.text),
              amountDecided: int.parse(salaryAmountController.text),
            ),
          ],
        ),
      );
    }
  }

  Future<void> AddEmployeeApi({
    required AddEmployeeRequest addEmployeeRequest,
  }) async {
    AppLoader().show();
    try {
      final Response response = await WebService.cmPostWithTokenRequest(
        url: ApiClient.addEmployee,
        body: addEmployeeRequestToJson(addEmployeeRequest),
        token: PrefUtils.getToken.toString(),
      );
      AppLoader().hide();
      if (response.statusCode == 200) {
        employeeDetailScreenController.hrScreenController.cmEmployeeList();
        AddEmployeeResponse addEmployeeResponse =
            addEmployeeResponseFromJson(response.data);
        if (addEmployeeResponse.status == "SUCCESS") {
          if (moduleEnum == ModuleEnum.attendance) {
            attendanceScreenController.empListApi();
            Get.back();
          } else {
            Get.offNamed(AppRoutes.hr);
          }
        } else {
          print(addEmployeeResponse.message);
        }
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      AppLoader().hide();
      print(error);
    }
  }

  void editPart({required String argument}) {
    if (argument == "All") {
      checkAllData();
    } else if (argument == "PERSONAL") {
      checkPersonal();
    } else if (argument == "BANK") {
      checkBank();
    } else if (argument == "SALARY") {
      checkSalary();
    } else if (argument == "OTHER") {
      checkOther();
    } else {
      return;
    }
  }

  void checkPersonal() {
    if (payrollNameController.text.isEmpty ||
        genderController.text.isEmpty ||
        aadhaarNameController.text.isEmpty ||
        parentSpouseNameController.text.isEmpty ||
        relationshipController.text.isEmpty ||
        dobController.text.isEmpty ||
        aadhaarNumberController.text.isEmpty ||
        mobileNoController.text.isEmpty) {
    } else {
      editEmployeeApi(
        id: singleEmployeeDetail!.id,
        editEmployeeRequest: EditEmployeeRequest(
          payrollName: payrollNameController.text,
          gender: genderController.text,
          adharName: aadhaarNameController.text,
          parentSpouseName: parentSpouseNameController.text,
          relationship: relationshipController.text,
          dob: singleEmployeeDetail!.dob == dobController.text
              ? dobController.text
              : convertDateFormat(date: dobController.text),
          adharNumber: aadhaarNumberController.text,
          panCard: panCardController.text,
          bankAccount: int.parse(bankAccountController.text),
          bankName: bankNameController.text,
          ifscCode: ifscCodeController.text,
          mobileNumber: int.parse(mobileNoController.text),
          uanNo: int.parse(uanNoController.text),
          remark: remarkController.text,
          pfNo: pfNoController.text,
          esiNo: esiNoController.text,
          category: employeeCategoryController.text,
        ),
      );
    }
  }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("dd-MM-yyyy").parse(date);

    String formattedDate = DateFormat("yyyy-MM-dd").format(inputDate);

    return formattedDate;
  }

  void checkBank() {
    if (bankAccountController.text.isEmpty) {
      bankAccountController.text = "0";
    }
    editEmployeeApi(
      id: singleEmployeeDetail!.id,
      editEmployeeRequest: EditEmployeeRequest(
        payrollName: payrollNameController.text,
        gender: genderController.text,
        adharName: aadhaarNameController.text,
        parentSpouseName: parentSpouseNameController.text,
        relationship: relationshipController.text,
        dob: singleEmployeeDetail!.dob == dobController.text
            ? dobController.text
            : convertDateFormat(date: dobController.text),
        adharNumber: aadhaarNumberController.text,
        panCard: panCardController.text,
        bankAccount: int.parse(bankAccountController.text),
        bankName: bankNameController.text,
        ifscCode: ifscCodeController.text,
        mobileNumber: int.parse(mobileNoController.text),
        uanNo: int.parse(uanNoController.text),
        remark: remarkController.text,
        pfNo: pfNoController.text,
        esiNo: esiNoController.text,
        category: employeeCategoryController.text,
      ),
    );
  }

  void checkOther() {
    if (joiningDateController.text.isEmpty ||
        uanNoController.text.isEmpty ||
        pfNoController.text.isEmpty) {
    } else {
      editEmployeeApi(
        id: singleEmployeeDetail!.id,
        editEmployeeRequest: EditEmployeeRequest(
          payrollName: payrollNameController.text,
          gender: genderController.text,
          adharName: aadhaarNameController.text,
          parentSpouseName: parentSpouseNameController.text,
          relationship: relationshipController.text,
          dob: singleEmployeeDetail!.dob == dobController.text
              ? dobController.text
              : convertDateFormat(date: dobController.text),
          adharNumber: aadhaarNumberController.text,
          panCard: panCardController.text,
          bankAccount: int.parse(bankAccountController.text),
          bankName: bankNameController.text,
          ifscCode: ifscCodeController.text,
          mobileNumber: int.parse(mobileNoController.text),
          uanNo: int.parse(uanNoController.text),
          remark: remarkController.text,
          pfNo: pfNoController.text,
          esiNo: esiNoController.text,
          category: employeeCategoryController.text,
        ),
      );
    }
  }

  void checkSalary() {
    if (salaryDateController.text.isEmpty ||
        salaryAmountController.text.isEmpty) {
    } else {
      editEmployeeSalary(
        updateEmployeeSalaryRequest: UpdateEmployeeSalaryRequest(
          empId: empIdController.text,
          date: singleEmployeeDetail!
                      .salaryInfo(empSalary: singleEmployeeDetail!.salary)
                      .date ==
                  salaryDateController.text
              ? salaryDateController.text
              : convertDateFormat(date: salaryDateController.text),
          amountDecided: int.parse(salaryAmountController.text),
        ),
      );
    }
  }

  Future<void> editEmployeeApi({
    required String id,
    required EditEmployeeRequest editEmployeeRequest,
  }) async {
    AppLoader().show();
    try {
      final Response response = await WebService.cmPostWithTokenRequest(
        url: "${ApiClient.editEmployee}${id}",
        body: editEmployeeRequestToJson(editEmployeeRequest),
        token: PrefUtils.getToken.toString(),
      );
      AppLoader().hide();
      if (response.statusCode == 200) {
        EditEmployeeResponse editEmployeeResponse =
            editEmployeeResponseFromJson(response.data);
        if (editEmployeeResponse.status == "SUCCESS") {
          employeeDetailScreenController.hrScreenController.cmEmployeeList();
          Get.back();
          Get.back();
        } else {
          print(editEmployeeResponse.message);
        }
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      AppLoader().hide();
      print(error);
    }
  }

  Future<void> editEmployeeSalary({
    required UpdateEmployeeSalaryRequest updateEmployeeSalaryRequest,
  }) async {
    AppLoader().show();
    try {
      final Response response = await WebService.cmPostWithTokenRequest(
        url: ApiClient.editEmployeeSalary,
        body: updateEmployeeSalaryRequestToJson(updateEmployeeSalaryRequest),
        token: PrefUtils.getToken.toString(),
      );
      AppLoader().hide();
      if (response.statusCode == 200) {
        UpdateEmployeeSalaryResponse updateEmployeeSalaryResponse =
            updateEmployeeSalaryResponseFromJson(response.data);
        if (updateEmployeeSalaryResponse.status == "SUCCESS") {
          employeeDetailScreenController.hrScreenController.cmEmployeeList();
          Get.back();
          Get.back();
        } else {
          print(updateEmployeeSalaryResponse.message);
        }
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      AppLoader().hide();
      print(error);
    }
  }
}
