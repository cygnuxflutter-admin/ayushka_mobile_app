import 'dart:convert';

AttendanceSubmitResponse attendanceSubmitResponseFromJson(String str) =>
    AttendanceSubmitResponse.fromJson(json.decode(str));

String attendanceSubmitResponseToJson(AttendanceSubmitResponse data) =>
    json.encode(data.toJson());

class AttendanceSubmitResponse {
  final String status;
  final String message;
  final Data data;

  AttendanceSubmitResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttendanceSubmitResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceSubmitResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final int count;

  Data({
    required this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}
