import 'dart:convert';

MilkUsageRequest milkUsageRequestFromJson(String str) => MilkUsageRequest.fromJson(json.decode(str));

String milkUsageRequestToJson(MilkUsageRequest data) => json.encode(data.toJson());

class MilkUsageRequest {
  final String liter;
  final String usedIn;
  final String description;
  final String distributionPerson;
  final String? dayTime;

  MilkUsageRequest({
    required this.liter,
    required this.usedIn,
    required this.description,
    required this.distributionPerson,
    this.dayTime,
  });

  factory MilkUsageRequest.fromJson(Map<String, dynamic> json) => MilkUsageRequest(
    liter: json["liter"],
    usedIn: json["used_in"],
    description: json["description"],
    distributionPerson: json["distribution_person"],
    dayTime: json["day_time"],
  );

  Map<String, dynamic> toJson() => {
    "liter": liter,
    "used_in": usedIn,
    "description": description,
    "distribution_person": distributionPerson,
    "day_time": dayTime,
  };
}
