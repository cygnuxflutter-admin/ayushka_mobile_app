import 'dart:convert';

AllEmpAttendanceHistoryRequest allEmpAttendanceHistoryRequestFromJson(String str) => AllEmpAttendanceHistoryRequest.fromJson(json.decode(str));

String allEmpAttendanceHistoryRequestToJson(AllEmpAttendanceHistoryRequest data) => json.encode(data.toJson());

class AllEmpAttendanceHistoryRequest {
  final String startDate;
  final String endDate;

  AllEmpAttendanceHistoryRequest({
    required this.startDate,
    required this.endDate,
  });

  factory AllEmpAttendanceHistoryRequest.fromJson(Map<String, dynamic> json) => AllEmpAttendanceHistoryRequest(
    startDate: json["startDate"],
    endDate: json["endDate"],
  );

  Map<String, dynamic> toJson() => {
    "startDate":startDate,
    "endDate": endDate,
  };
}
