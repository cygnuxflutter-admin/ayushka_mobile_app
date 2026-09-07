//
//
// import 'dart:convert';
//
// ExpenseRequest expenseRequestFromJson(String str) => ExpenseRequest.fromJson(json.decode(str));
//
// String expenseRequestToJson(ExpenseRequest data) => json.encode(data.toJson());
//
// class ExpenseRequest {
//   final String rfoNo;
//   final String gaushalaId;
//   final String vendorId;
//   final String billNo;
//   final String itemId;
//   final String expenceType;
//   final String qty;
//   final double kgPerUnit;
//   final double ratePerUnit;
//   final double totalWtOrQty;
//   final double totalAmount;
//   final String entryBy;
//   final String remark;
//   final bool isStock;
//   final String date;
//
//   ExpenseRequest({
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
//   });
//
//   factory ExpenseRequest.fromJson(Map<String, dynamic> json) => ExpenseRequest(
//     rfoNo: json["RFO_no"],
//     gaushalaId: json["gaushala_id"],
//     vendorId: json["vendor_id"],
//     billNo: json["bill_no"],
//     itemId: json["item_id"],
//     expenceType: json["expence_type"],
//     qty: json["qty"],
//     kgPerUnit: json["kg_per_unit"],
//     ratePerUnit: json["rate_per_unit"]?.toDouble(),
//     totalWtOrQty: json["totalWtOrQty"]?.toDouble(),
//     totalAmount: json["total_amount"],
//     entryBy: json["entry_by"],
//     remark: json["remark"],
//     isStock: json["isStock"],
//     date: json["date"],
//   );
//
//   Map<String, dynamic> toJson() => {
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
//   };
// }

// To parse this JSON data, do
//
//     final expenseRequest = expenseRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ExpenseRequest> expenseRequestFromJson(String str) => List<ExpenseRequest>.from(json.decode(str).map((x) => ExpenseRequest.fromJson(x)));

String expenseRequestToJson(List<ExpenseRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseRequest {
  final String itemId;
  final String expenceType;
  final num totalWtOrQty;
  final String entryBy;
  final String remark;
  final bool isStock;
  final String date;

  ExpenseRequest({
    required this.itemId,
    required this.expenceType,
    required this.totalWtOrQty,
    required this.entryBy,
    required this.remark,
    required this.isStock,
    required this.date,
  });

  factory ExpenseRequest.fromJson(Map<String, dynamic> json) => ExpenseRequest(
    itemId: json["item_id"],
    expenceType: json["expence_type"],
    totalWtOrQty: json["totalWtOrQty"],
    entryBy: json["entry_by"],
    remark: json["remark"],
    isStock: json["isStock"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "expence_type": expenceType,
    "totalWtOrQty": totalWtOrQty,
    "entry_by": entryBy,
    "remark": remark,
    "isStock": isStock,
    "date": date,
  };
}
