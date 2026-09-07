import 'dart:convert';

MilkUsageResponse milkUsageResponseFromJson(String str) => MilkUsageResponse.fromJson(json.decode(str));

String milkUsageResponseToJson(MilkUsageResponse data) => json.encode(data.toJson());

class MilkUsageResponse {
  final String status;
  final String message;

  MilkUsageResponse({
    required this.status,
    required this.message,
  });

  factory MilkUsageResponse.fromJson(Map<String, dynamic> json) => MilkUsageResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

