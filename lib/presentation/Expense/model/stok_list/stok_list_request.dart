import 'dart:convert';

StockListRequest stockListRequestFromJson(String str) => StockListRequest.fromJson(json.decode(str));

String stockListRequestToJson(StockListRequest data) => json.encode(data.toJson());

class StockListRequest {
  final String startDate;
  final String endDate;
  final List<String> expenceType;
  final List<String> itemId;

  StockListRequest({
    required this.startDate,
    required this.endDate,
    required this.expenceType,
    required this.itemId,
  });

  factory StockListRequest.fromJson(Map<String, dynamic> json) => StockListRequest(
    startDate: json["startDate"],
    endDate: json["endDate"],
    expenceType: List<String>.from(json["expence_type"].map((x) => x)),
    itemId: List<String>.from(json["item_id"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate,
    "endDate": endDate,
    "expence_type": List<dynamic>.from(expenceType.map((x) => x)),
    "item_id": List<dynamic>.from(itemId.map((x) => x)),
  };
}
