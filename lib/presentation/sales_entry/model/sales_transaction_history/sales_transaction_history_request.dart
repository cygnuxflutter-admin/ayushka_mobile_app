
import 'dart:convert';

SalesTransactionHistoryRequest salesTransactionHistoryRequestFromJson(String str) => SalesTransactionHistoryRequest.fromJson(json.decode(str));

String salesTransactionHistoryRequestToJson(SalesTransactionHistoryRequest data) => json.encode(data.toJson());

class SalesTransactionHistoryRequest {
  final String startDate;
  final String endDate;
  final List<dynamic> itemName;

  SalesTransactionHistoryRequest({
    required this.startDate,
    required this.endDate,
    required this.itemName,
  });

  factory SalesTransactionHistoryRequest.fromJson(Map<String, dynamic> json) => SalesTransactionHistoryRequest(
    startDate: json["startDate"],
    endDate: json["endDate"],
    itemName: List<dynamic>.from(json["item_name"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate,
    "endDate": endDate,
    "item_name": List<dynamic>.from(itemName.map((x) => x)),
  };
}
