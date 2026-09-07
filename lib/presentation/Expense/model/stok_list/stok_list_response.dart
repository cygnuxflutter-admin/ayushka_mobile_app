import 'package:meta/meta.dart';
import 'dart:convert';

StockListResponse stockListResponseFromJson(String str) => StockListResponse.fromJson(json.decode(str));

String stockListResponseToJson(StockListResponse data) => json.encode(data.toJson());

class StockListResponse {
  final String status;
  final String message;
  final List<StockDatum> stockData;

  StockListResponse({
    required this.status,
    required this.message,
    required this.stockData,
  });

  factory StockListResponse.fromJson(Map<String, dynamic> json) => StockListResponse(
    status: json["status"],
    message: json["message"],
    stockData: List<StockDatum>.from(json["data"].map((x) => StockDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(stockData.map((x) => x.toJson())),
  };
}

class StockDatum {
  final String id;
  final String rfoNo;
  final String gaushalaId;
  final String vendorId;
  final String billNo;
  final String itemId;
  final String expenceType;
  final String qty;
  final num kgPerUnit;
  final num ratePerUnit;
  final num totalWtOrQty;
  final num totalAmount;
  final String entryBy;
  final String remark;
  final bool isStock;
  final String date;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final int v;
  final String itemName;
  final String cgst;
  final String sgst;

  StockDatum({
    required this.id,
    required this.rfoNo,
    required this.gaushalaId,
    required this.vendorId,
    required this.billNo,
    required this.itemId,
    required this.expenceType,
    required this.qty,
    required this.kgPerUnit,
    required this.ratePerUnit,
    required this.totalWtOrQty,
    required this.totalAmount,
    required this.entryBy,
    required this.remark,
    required this.isStock,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.v,
    required this.itemName,
    required this.cgst,
    required this.sgst,
  });

  factory StockDatum.fromJson(Map<String, dynamic> json) => StockDatum(
    id: json["_id"]??'',
    rfoNo: json["RFO_no"]??'',
    gaushalaId: json["gaushala_id"]??'',
    vendorId: json["vendor_id"]??'',
    billNo: json["bill_no"]??'',
    itemId: json["item_id"]??'',
    expenceType: json["expence_type"]??'',
    qty: json["qty"]??'',
    kgPerUnit: json["kg_per_unit"]?.toDouble(),
    ratePerUnit: json["rate_per_unit"]?.toDouble(),
    totalWtOrQty: json["totalWtOrQty"]?.toDouble(),
    totalAmount: json["total_amount"]?.toDouble(),
    entryBy: json["entry_by"]??'',
    remark: json["remark"]??'',
    isStock: json["isStock"]??false,
    date: json["date"]??'',
    createdAt: json["createdAt"]??'',
    updatedAt: json["updatedAt"]??'',
    isDeleted: json["isDeleted"]??'',
    v: json["__v"]??0,
    itemName: json["itemName"]??'',
    cgst: json["cgst"]??'0',
    sgst: json["sgst"]??'0',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "RFO_no": rfoNo,
    "gaushala_id": gaushalaId,
    "vendor_id": vendorId,
    "bill_no": billNo,
    "item_id": itemId,
    "expence_type": expenceType,
    "qty": qty,
    "kg_per_unit": kgPerUnit,
    "rate_per_unit": ratePerUnit,
    "totalWtOrQty": totalWtOrQty,
    "total_amount": totalAmount,
    "entry_by": entryBy,
    "remark": remark,
    "isStock": isStock,
    "date": date,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isDeleted": isDeleted,
    "__v": v,
    "itemName": itemName,
    "cgst": cgst,
    "sgst": sgst,
  };
}




