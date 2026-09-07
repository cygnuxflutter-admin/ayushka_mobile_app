import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

AbsentEmployeeListResponse absentEmployeeListResponseFromJson(String str) =>
    AbsentEmployeeListResponse.fromJson(json.decode(str));

class AbsentEmployeeListResponse {
  final String status;
  final String message;
  final List<AttendanceEmployeeList> attendanceEmployeeList;

  AbsentEmployeeListResponse({
    required this.status,
    required this.message,
    required this.attendanceEmployeeList,
  });

  factory AbsentEmployeeListResponse.fromJson(Map<String, dynamic> json) =>
      AbsentEmployeeListResponse(
        status: json["status"],
        message: json["message"],
        attendanceEmployeeList: List<AttendanceEmployeeList>.from(
            json["data"].map((x) => AttendanceEmployeeList.fromJson(x))),
      );
}

class AttendanceEmployeeList {
  final String id;
  final String empId;
  final String date;
  final String attendanceType;
  final String leaveType;
  final String remark;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final String datumId;
  final String payrollName;
  final String gender;
  final RxBool isSelect;

  AttendanceEmployeeList({
    required this.id,
    required this.empId,
    required this.date,
    required this.attendanceType,
    required this.leaveType,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.datumId,
    required this.payrollName,
    required this.gender,
    required this.isSelect,
  });

  factory AttendanceEmployeeList.fromJson(Map<String, dynamic> json) =>
      AttendanceEmployeeList(
        id: json["_id"],
        empId: json["emp_id"],
        date: json["date"],
        attendanceType: json["attendanceType"],
        leaveType: json["leaveType"],
        remark: json["remark"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        isDeleted: json["isDeleted"],
        datumId: json["id"],
        payrollName: json["payroll_name"],
        gender: json['gender'],
        isSelect: RxBool(json['isSelect'] ?? false),
      );
}
