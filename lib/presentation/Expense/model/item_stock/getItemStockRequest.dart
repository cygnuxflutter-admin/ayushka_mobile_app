import 'dart:convert';

GetItemStockRequest getItemStockRequestFromJson(String str) =>
    GetItemStockRequest.fromJson(json.decode(str));

String getItemStockRequestToJson(GetItemStockRequest data) =>
    json.encode(data.toJson());

class GetItemStockRequest {
  final String year;
  final String month;
  final String itemId;

  GetItemStockRequest({
    required this.year,
    required this.month,
    required this.itemId,
  });

  factory GetItemStockRequest.fromJson(Map<String, dynamic> json) =>
      GetItemStockRequest(
        year: json["year"],
        month: json["month"],
        itemId: json["item_id"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "item_id": itemId,
      };
}
