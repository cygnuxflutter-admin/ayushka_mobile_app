import 'dart:convert';

ExitEmployeeRequest exitEmployeeRequestFromJson(String str) =>
    ExitEmployeeRequest.fromJson(json.decode(str));

String exitEmployeeRequestToJson(ExitEmployeeRequest data) =>
    json.encode(data.toJson());

class ExitEmployeeRequest {
  final bool isActive;
  final bool isDeleted;

  ExitEmployeeRequest({
    required this.isActive,
    required this.isDeleted,
  });

  factory ExitEmployeeRequest.fromJson(Map<String, dynamic> json) =>
      ExitEmployeeRequest(
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
      };
}
