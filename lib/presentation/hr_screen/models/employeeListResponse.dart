import 'dart:convert';

EmployeeListResponse employeeListResponseFromJson(String str) =>
    EmployeeListResponse.fromJson(json.decode(str));

String employeeListResponseToJson(EmployeeListResponse data) =>
    json.encode(data.toJson());

class EmployeeListResponse {
  final String status;
  final String message;
  final Data data;

  EmployeeListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeListResponse(
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
  final List<Employee> data;

  Data({
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data:
            List<Employee>.from(json["data"].map((x) => Employee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Employee {
  final String empId;
  final String payrollName;
  bool isActive;
  final String id;

  Employee({
    required this.empId,
    required this.payrollName,
    required this.isActive,
    required this.id,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        empId: json["emp_id"],
        payrollName: json["payroll_name"],
        isActive: json["isActive"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "payroll_name": payrollName,
        "isActive": isActive,
        "id": id,
      };
}
