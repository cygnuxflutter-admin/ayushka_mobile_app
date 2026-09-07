import 'dart:convert';

UpdateAttendanceResponse updateAttendanceResponseFromJson(String str) =>
    UpdateAttendanceResponse.fromJson(json.decode(str));

String updateAttendanceResponseToJson(UpdateAttendanceResponse data) =>
    json.encode(data.toJson());

class UpdateAttendanceResponse {
  final String status;
  final String message;
  final Data data;

  UpdateAttendanceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      UpdateAttendanceResponse(
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
  final String empId;
  final String date;
  final String attendanceType;
  final String leaveType;
  final String remark;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final String id;

  Data({
    required this.empId,
    required this.date,
    required this.attendanceType,
    required this.leaveType,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        empId: json["emp_id"],
        date: json["date"],
        attendanceType: json["attendanceType"],
        leaveType: json["leaveType"],
        remark: json["remark"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        isDeleted: json["isDeleted"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "date": date,
        "attendanceType": attendanceType,
        "leaveType": leaveType,
        "remark": remark,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isDeleted": isDeleted,
        "id": id,
      };
}
