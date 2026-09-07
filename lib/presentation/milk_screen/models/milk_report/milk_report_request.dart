import 'dart:convert';

MilkReportRequest milkReportRequestFromJson(String str) => MilkReportRequest.fromJson(json.decode(str));

String milkReportRequestToJson(MilkReportRequest data) => json.encode(data.toJson());

class MilkReportRequest {
  final String startDate;
  final String endDate;
  final String cowTagId;

  MilkReportRequest({
    required this.startDate,
    required this.endDate,
    required this.cowTagId,
  });

  factory MilkReportRequest.fromJson(Map<String, dynamic> json) => MilkReportRequest(
    startDate: json["startDate"],
    endDate: json["endDate"],
    cowTagId: json["cow_tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate,
    "endDate": endDate,
    "cow_tag_id": cowTagId,
  };
}
