// import 'dart:convert';
//
// GetRfoDetailsResponse getRfoDetailsResponseFromJson(String str) => GetRfoDetailsResponse.fromJson(json.decode(str));
//
// String getRfoDetailsResponseToJson(GetRfoDetailsResponse data) => json.encode(data.toJson());
//
// class GetRfoDetailsResponse {
//   final String status;
//   final String message;
//   final List<GetRfoDetailsDatum> getRfoDetailsData;
//
//   GetRfoDetailsResponse({
//     required this.status,
//     required this.message,
//     required this.getRfoDetailsData,
//   });
//
//   factory GetRfoDetailsResponse.fromJson(Map<String, dynamic> json) => GetRfoDetailsResponse(
//     status: json["status"],
//     message: json["message"],
//     getRfoDetailsData: List<GetRfoDetailsDatum>.from(json["data"].map((x) => GetRfoDetailsDatum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "getRFODetailsData": List<dynamic>.from(getRfoDetailsData.map((x) => x.toJson())),
//   };
// }
//
// class GetRfoDetailsDatum {
//   final String id;
//   final String rfoNo;
//   final String gaushalaId;
//   final int rfoType;
//   final int paymentType;
//   final String vendorId;
//   final String vendorName;
//   final String date;
//   final String fromDate;
//   final String toDate;
//   final List<Item> items;
//
//   GetRfoDetailsDatum({
//     required this.id,
//     required this.rfoNo,
//     required this.gaushalaId,
//     required this.rfoType,
//     required this.paymentType,
//     required this.vendorId,
//     required this.vendorName,
//     required this.date,
//     required this.fromDate,
//     required this.toDate,
//     required this.items,
//   });
//
//   factory GetRfoDetailsDatum.fromJson(Map<String, dynamic> json) => GetRfoDetailsDatum(
//     id: json["_id"]??"",
//     rfoNo: json["RFO_no"]??"",
//     gaushalaId: json["gaushala_id"]??"",
//     rfoType: json["rfo_type"]??1,
//     paymentType: json["paymentType"]??1,
//     vendorId: json["vendor_id"]??"",
//     vendorName: json["vendorName"]??"",
//     date: json["date"]??"",
//     fromDate: json["fromDate"]??"",
//     toDate:json["toDate"]??"",
//     items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "RFO_no": rfoNo,
//     "gaushala_id": gaushalaId,
//     "rfo_type": rfoType,
//     "paymentType": paymentType,
//     "vendor_id": vendorId,
//     "vendorName": vendorName,
//     "date": date,
//     "fromDate": fromDate,
//     "toDate": toDate,
//     "items": List<dynamic>.from(items.map((x) => x.toJson())),
//   };
// }
//
// class Item {
//   final String id;
//   final String rfoNo;
//   final String gaushalaId;
//   final String vendorId;
//   final String billNo;
//   final String itemId;
//   final String expenceType;
//   final String qty;
//   final num kgPerUnit;
//   final num ratePerUnit;
//   final num totalWtOrQty;
//   final num totalAmount;
//   final String entryBy;
//   final String remark;
//   final bool isStock;
//   final String date;
//   final String createdAt;
//   final String updatedAt;
//   final bool isDeleted;
//   final int v;
//   final String billDate;
//
//   Item({
//     required this.id,
//     required this.rfoNo,
//     required this.gaushalaId,
//     required this.vendorId,
//     required this.billNo,
//     required this.itemId,
//     required this.expenceType,
//     required this.qty,
//     required this.kgPerUnit,
//     required this.ratePerUnit,
//     required this.totalWtOrQty,
//     required this.totalAmount,
//     required this.entryBy,
//     required this.remark,
//     required this.isStock,
//     required this.date,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isDeleted,
//     required this.v,
//     required this.billDate,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//     id: json["_id"]??"",
//     rfoNo: json["RFO_no"]??"",
//     gaushalaId: json["gaushala_id"]??"",
//     vendorId: json["vendor_id"]??"",
//     billNo: json["bill_no"??""],
//     itemId: json["item_id"]??"",
//     expenceType: json["expence_type"]??"",
//     qty: json["qty"]??"",
//     kgPerUnit: json["kg_per_unit"]??0,
//     ratePerUnit: json["rate_per_unit"]??0,
//     totalWtOrQty: json["totalWtOrQty"]??0,
//     totalAmount: json["total_amount"]??0,
//     entryBy: json["entry_by"]??"",
//     remark: json["remark"]??"",
//     isStock: json["isStock"]??"",
//     date: json["date"]??"",
//     createdAt: json["createdAt"]??"",
//     updatedAt: json["updatedAt"]??"",
//     isDeleted: json["isDeleted"]??false,
//     v: json["__v"]??0,
//     billDate: json["bill_date"]??"",
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "RFO_no": rfoNo,
//     "gaushala_id": gaushalaId,
//     "vendor_id": vendorId,
//     "bill_no": billNo,
//     "item_id": itemId,
//     "expence_type": expenceType,
//     "qty": qty,
//     "kg_per_unit": kgPerUnit,
//     "rate_per_unit": ratePerUnit,
//     "totalWtOrQty": totalWtOrQty,
//     "total_amount": totalAmount,
//     "entry_by": entryBy,
//     "remark": remark,
//     "isStock": isStock,
//     "date": date,
//     "createdAt": createdAt,
//     "updatedAt": updatedAt,
//     "isDeleted": isDeleted,
//     "__v": v,
//     "bill_date": billDate,
//   };
// }

// To parse this JSON data, do
//
//     final getRfoDetailsResponse = getRfoDetailsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetRfoDetailsResponse getRfoDetailsResponseFromJson(String str) => GetRfoDetailsResponse.fromJson(json.decode(str));

String getRfoDetailsResponseToJson(GetRfoDetailsResponse data) => json.encode(data.toJson());

class GetRfoDetailsResponse {
  final String status;
  final String message;
  final List<GetRfoDetailsDatum> getRfoDetailsData;

  GetRfoDetailsResponse({
    required this.status,
    required this.message,
    required this.getRfoDetailsData,
  });

  factory GetRfoDetailsResponse.fromJson(Map<String, dynamic> json) => GetRfoDetailsResponse(
    status: json["status"],
    message: json["message"],
    getRfoDetailsData: List<GetRfoDetailsDatum>.from(json["data"].map((x) => GetRfoDetailsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "GetRfoDetailsData": List<dynamic>.from(getRfoDetailsData.map((x) => x.toJson())),
  };
}

class GetRfoDetailsDatum {
  final String id;
  final String rfoNo;
  final String gaushalaId;
  final int rfoType;
  final int paymentType;
  final String vendorId;
  final String vendorName;
  final String date;
  final String fromDate;
  final String toDate;
  final List<Item> items;
  final String sgst;
  final String cgst;


  GetRfoDetailsDatum({
    required this.id,
    required this.rfoNo,
    required this.gaushalaId,
    required this.rfoType,
    required this.paymentType,
    required this.vendorId,
    required this.vendorName,
    required this.date,
    required this.fromDate,
    required this.toDate,
    required this.items,
    required this.sgst,
    required this.cgst,
  });

  factory GetRfoDetailsDatum.fromJson(Map<String, dynamic> json) => GetRfoDetailsDatum(
    id: json["_id"]??"",
    rfoNo: json["RFO_no"]??"",
    gaushalaId: json["gaushala_id"]??"",
    rfoType: json["rfo_type"]??1,
    paymentType: json["paymentType"]??1,
    vendorId: json["vendor_id"]??"",
    vendorName: json["vendorName"]??"",
    date: json["date"]??"",
    fromDate: json["fromDate"]??"",
    toDate:json["toDate"]??"",
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    cgst: json["cgst"]??'0',
    sgst: json["sgst"]??'0',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "RFO_no": rfoNo,
    "gaushala_id": gaushalaId,
    "rfo_type": rfoType,
    "paymentType": paymentType,
    "vendor_id": vendorId,
    "vendorName": vendorName,
    "date": date,
    "fromDate": fromDate,
    "toDate": toDate,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "sgst":sgst,
    "cgst":cgst,
  };
}

class Item {
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
  final String billDate;
  final String date;
  final List<String> billImage;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final int v;

  Item({
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
    required this.billDate,
    required this.date,
    required this.billImage,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.v,

  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["_id"]??"",
    rfoNo: json["RFO_no"]??"",
    gaushalaId: json["gaushala_id"]??"",
    vendorId: json["vendor_id"]??"",
    billNo: json["bill_no"??""],
    itemId: json["item_id"]??"",
    expenceType: json["expence_type"]??"",
    qty: json["qty"]??"",
    kgPerUnit: json["kg_per_unit"]??0.0,
    ratePerUnit: json["rate_per_unit"]??0.0,
    totalWtOrQty: json["totalWtOrQty"]??0.0,
    totalAmount: json["total_amount"]??0.0,
    entryBy: json["entry_by"]??"",
    remark: json["remark"]??"",
    isStock: json["isStock"]??"",
    date: json["date"]??"",
    createdAt: json["createdAt"]??"",
    updatedAt: json["updatedAt"]??"",
    isDeleted: json["isDeleted"]??false,
    v: json["__v"]??0,
    billDate: json["bill_date"]??"",
    billImage: List<String>.from(json["bill_image"].map((x) => x)??[]),

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
    "bill_date": billDate,
    "date": date,
    "bill_image": List<dynamic>.from(billImage.map((x) => x)),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isDeleted": isDeleted,
    "__v": v,

  };
}
