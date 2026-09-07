import 'dart:convert';

AttendanceHistoryResponse attendanceHistoryResponseFromJson(String str) => AttendanceHistoryResponse.fromJson(json.decode(str));

String attendanceHistoryResponseToJson(AttendanceHistoryResponse data) => json.encode(data.toJson());

class AttendanceHistoryResponse {
  final String status;
  final String message;
  final List<AttendanceHistoryList> attendanceHistoryList;

  AttendanceHistoryResponse({
    required this.status,
    required this.message,
    required this.attendanceHistoryList,
  });

  factory AttendanceHistoryResponse.fromJson(Map<String, dynamic> json) => AttendanceHistoryResponse(
    status: json["status"],
    message: json["message"],
    attendanceHistoryList: List<AttendanceHistoryList>.from(json["data"].map((x) => AttendanceHistoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "AttendanceHistoryList": List<dynamic>.from(attendanceHistoryList.map((x) => x.toJson())),
  };
}

class AttendanceHistoryList {
  final String id;
  final String empId;
  final String date;
  final String attendanceType;
  final String leaveType;
  final String remark;
  final String attendanceHistoryListId;
  final String payrollName;
  final String gender;

  AttendanceHistoryList({
    required this.id,
    required this.empId,
    required this.date,
    required this.attendanceType,
    required this.leaveType,
    required this.remark,
    required this.attendanceHistoryListId,
    required this.payrollName,
    required this.gender,
  });

  factory AttendanceHistoryList.fromJson(Map<String, dynamic> json) => AttendanceHistoryList(
    id: json["_id"],
    empId: json["emp_id"],
    date: json["date"],
    attendanceType: json["attendanceType"],
    leaveType: json["leaveType"],
    remark: json["remark"],
    attendanceHistoryListId: json["id"],
    payrollName: json["payroll_name"],
    gender:json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "emp_id": empId,
    "date": date,
    "attendanceType":attendanceType,
    "leaveType": leaveType,
    "remark": remark,
    "id": attendanceHistoryListId,
    "payroll_name": payrollName,
    "gender": gender,
  };
}

