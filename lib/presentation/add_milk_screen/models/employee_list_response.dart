import 'dart:convert';

EmployeeListResponse employeeListResponseFromJson(String str) =>
    EmployeeListResponse.fromJson(json.decode(str));

String employeeListResponseToJson(EmployeeListResponse data) =>
    json.encode(data.toJson());

class EmployeeListResponse {
  final String status;
  final String message;
  final List<EmployeeData> data;

  EmployeeListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeListResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] != null
            ? List<EmployeeData>.from(
                (json["data"] as List).map((x) => EmployeeData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EmployeeData {
  final String empId;
  final String payrollName;

  EmployeeData({
    required this.empId,
    required this.payrollName,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        empId: json["emp_id"] ?? "",
        payrollName: json["payroll_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "payroll_name": payrollName,
      };
}
