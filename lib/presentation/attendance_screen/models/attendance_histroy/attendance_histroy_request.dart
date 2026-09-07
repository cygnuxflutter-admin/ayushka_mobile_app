import 'dart:convert';

AttendanceHistoryRequest attendanceHistoryRequestFromJson(String str) => AttendanceHistoryRequest.fromJson(json.decode(str));

String attendanceHistoryRequestToJson(AttendanceHistoryRequest data) => json.encode(data.toJson());

class AttendanceHistoryRequest {
  final String startDate;
  final String endDate;
  final List<String> empId;

  AttendanceHistoryRequest({
    required this.startDate,
    required this.endDate,
    required this.empId,
  });

  factory AttendanceHistoryRequest.fromJson(Map<String, dynamic> json) =>
      AttendanceHistoryRequest(
        startDate: json["startDate"],
        endDate: json["endDate"],
        empId: List<String>.from(json["emp_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "emp_id": List<dynamic>.from(empId.map((x) => x)),
      };
}
