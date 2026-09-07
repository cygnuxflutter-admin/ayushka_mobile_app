import 'dart:convert';

AttendanceSubmitRequest attendanceSubmitRequestFromJson(String str) =>
    AttendanceSubmitRequest.fromJson(json.decode(str));

String attendanceSubmitRequestToJson(AttendanceSubmitRequest data) =>
    json.encode(data.toJson());

class AttendanceSubmitRequest {
  final List<AttendanceSubmitList> attendanceSubmitList;

  AttendanceSubmitRequest({
    required this.attendanceSubmitList,
  });

  factory AttendanceSubmitRequest.fromJson(Map<String, dynamic> json) =>
      AttendanceSubmitRequest(
        attendanceSubmitList: List<AttendanceSubmitList>.from(json["data"].map((x) => AttendanceSubmitList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(attendanceSubmitList.map((x) => x.toJson())),
      };
}

class AttendanceSubmitList {
  final String empId;
  final String date;
  final String attendanceType;
  final String leaveType;
  final String remark;

  AttendanceSubmitList({
    required this.empId,
    required this.date,
    required this.attendanceType,
    required this.leaveType,
    required this.remark,
  });

  factory AttendanceSubmitList.fromJson(Map<String, dynamic> json) => AttendanceSubmitList(
        empId: json["emp_id"],
        date: json["date"],
        attendanceType: json["attendanceType"],
        leaveType: json["leaveType"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "date": date,
        "attendanceType": attendanceType,
        "leaveType": leaveType,
        "remark": remark,
      };
}
