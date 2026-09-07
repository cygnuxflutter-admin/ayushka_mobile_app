import 'dart:convert';

AllEmpAttendanceHistoryResponse allEmpAttendanceHistoryResponseFromJson(String str) => AllEmpAttendanceHistoryResponse.fromJson(json.decode(str));

String allEmpAttendanceHistoryResponseToJson(AllEmpAttendanceHistoryResponse data) => json.encode(data.toJson());

class AllEmpAttendanceHistoryResponse {
  final String status;
  final String message;
  final List<EmpHistoryDatum> empHistoryData;

  AllEmpAttendanceHistoryResponse({
    required this.status,
    required this.message,
    required this.empHistoryData,
  });

  factory AllEmpAttendanceHistoryResponse.fromJson(Map<String, dynamic> json) => AllEmpAttendanceHistoryResponse(
    status: json["status"],
    message: json["message"],
    empHistoryData: List<EmpHistoryDatum>.from(json["data"].map((x) => EmpHistoryDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "EmpHistoryData": List<dynamic>.from(empHistoryData.map((x) => x.toJson())),
  };
}

class EmpHistoryDatum {
  final String id;
  final String empId;
  final String date;
  final String attendanceType;
  final String leaveType;
  final String remark;
  final String empHistoryDatumId;
  final String payrollName;
  final String gender;

  EmpHistoryDatum({
    required this.id,
    required this.empId,
    required this.date,
    required this.attendanceType,
    required this.leaveType,
    required this.remark,
    required this.empHistoryDatumId,
    required this.payrollName,
    required this.gender,
  });

  factory EmpHistoryDatum.fromJson(Map<String, dynamic> json) => EmpHistoryDatum(
      id: json["_id"]??"",
      empId: json["emp_id"]??"",
      date: json["date"]??"",
      attendanceType: json["attendanceType"]??"",
      leaveType: json["leaveType"]??"",
      remark: json["remark"]??"",
      empHistoryDatumId: json["id"]??"",
      payrollName: json["payroll_name"]??"",
      gender:json["gender"]??"",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "emp_id": empId,
    "date": date,
    "attendanceType":attendanceType,
    "leaveType": leaveType,
    "remark": remark,
    "id": empHistoryDatumId,
    "payroll_name": payrollName,
    "gender": gender,
  };
}

