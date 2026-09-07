import 'dart:convert';

UpdateAttendanceRequest updateAttendanceRequestFromJson(String str) => UpdateAttendanceRequest.fromJson(json.decode(str));

String updateAttendanceRequestToJson(UpdateAttendanceRequest data) => json.encode(data.toJson());

class UpdateAttendanceRequest {
  final String empId;
  final String date;
  final String attendanceType;
  final String leaveType;
  final String remark;

  UpdateAttendanceRequest({
    required this.empId,
    required this.date,
    required this.attendanceType,
    required this.leaveType,
    required this.remark,
  });

  factory UpdateAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      UpdateAttendanceRequest(
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
