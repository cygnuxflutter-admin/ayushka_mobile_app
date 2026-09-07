import 'dart:convert';

UpdateEmployeeSalaryRequest updateEmployeeSalaryRequestFromJson(String str) => UpdateEmployeeSalaryRequest.fromJson(json.decode(str));

String updateEmployeeSalaryRequestToJson(UpdateEmployeeSalaryRequest data) => json.encode(data.toJson());

class UpdateEmployeeSalaryRequest {
  final String empId;
  final String date;
  final int amountDecided;

  UpdateEmployeeSalaryRequest({
    required this.empId,
    required this.date,
    required this.amountDecided,
  });

  factory UpdateEmployeeSalaryRequest.fromJson(Map<String, dynamic> json) => UpdateEmployeeSalaryRequest(
    empId: json["emp_id"],
    date: json["date"],
    amountDecided: json["amountDecided"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "date": date,
    "amountDecided": amountDecided,
  };
}
