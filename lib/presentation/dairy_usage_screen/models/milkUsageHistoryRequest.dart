// To parse this JSON data, do
//
//     final milkUsageHistoryRequest = milkUsageHistoryRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MilkUsageHistoryRequest milkUsageHistoryRequestFromJson(String str) => MilkUsageHistoryRequest.fromJson(json.decode(str));

String milkUsageHistoryRequestToJson(MilkUsageHistoryRequest data) => json.encode(data.toJson());

class MilkUsageHistoryRequest {
  final String startDate;
  final String endDate;
  final String? dayTime;

  MilkUsageHistoryRequest({
    required this.startDate,
    required this.endDate,
    this.dayTime,
  });

  factory MilkUsageHistoryRequest.fromJson(Map<String, dynamic> json) => MilkUsageHistoryRequest(
    startDate: json["startDate"],
    endDate: json["endDate"],
    dayTime: json["day_time"],
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate,
    "endDate": endDate,
    "day_time": dayTime,
  };
}
