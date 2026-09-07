import 'dart:convert';

GetItemStockResponse getItemStockResponseFromJson(String str) =>
    GetItemStockResponse.fromJson(json.decode(str));

String getItemStockResponseToJson(GetItemStockResponse data) =>
    json.encode(data.toJson());

class GetItemStockResponse {
  final String status;
  final String message;
  final ItemStock data;

  GetItemStockResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetItemStockResponse.fromJson(Map<String, dynamic> json) =>
      GetItemStockResponse(
        status: json["status"],
        message: json["message"],
        data: ItemStock.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ItemStock {
  final double closingQtyOfItem;

  ItemStock({
    required this.closingQtyOfItem,
  });

  factory ItemStock.fromJson(Map<String, dynamic> json) => ItemStock(
        closingQtyOfItem: json["closing_qty_of_item"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "closing_qty_of_item": closingQtyOfItem,
      };
}
