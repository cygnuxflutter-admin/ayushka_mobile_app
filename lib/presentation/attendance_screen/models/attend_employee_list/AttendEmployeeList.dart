import 'dart:convert';

import 'package:get/get.dart';

AttendEmployeeListResponse attendEmployeeListResponseFromJson(String str) =>
    AttendEmployeeListResponse.fromJson(json.decode(str));

String attendEmployeeListResponseToJson(AttendEmployeeListResponse data) =>
    json.encode(data.toJson());

class AttendEmployeeListResponse {
  final String status;
  final String message;
  final List<EmployeeDetailsList> employeeList;

  AttendEmployeeListResponse({
    required this.status,
    required this.message,
    required this.employeeList,
  });

  factory AttendEmployeeListResponse.fromJson(Map<String, dynamic> json) =>
      AttendEmployeeListResponse(
        status: json["status"],
        message: json["message"],
        employeeList: List<EmployeeDetailsList>.from(
            json["data"].map((x) => EmployeeDetailsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(employeeList.map((x) => x.toJson())),
      };
}

class EmployeeDetailsList {
  final String id;
  final String empId;
  final String joinDate;
  final String leaveDate;
  final String remark;
  final bool isActive;
  final String datumId;
  final String payrollName;
  RxBool isPresentAbsent = false.obs;
  RxBool isFullDay = true.obs;

  EmployeeDetailsList({
    required this.id,
    required this.empId,
    required this.joinDate,
    required this.leaveDate,
    required this.remark,
    required this.isActive,
    required this.datumId,
    required this.payrollName,
    required this.isPresentAbsent,
    required this.isFullDay,
  });

  factory EmployeeDetailsList.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsList(
        id: json["_id"]??'',
        empId: json["emp_id"]??'',
        joinDate: json["join_date"]??"",
        leaveDate: json["leave_date"]??'',
        remark: json["remark"]??'',
        isActive: json["isActive"]??false,
        datumId: json["id"]??'',
        payrollName: json["payroll_name"]??'',
        isPresentAbsent: RxBool(json['isHalfDay'] ?? false),
        isFullDay: RxBool(json['isHalfDay'] ?? true),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "emp_id": empId,
        "join_date": joinDate,
        "leave_date": leaveDate,
        "remark": remark,
        "isActive": isActive,
        "id": datumId,
        "payroll_name": payrollName,
      };
}
