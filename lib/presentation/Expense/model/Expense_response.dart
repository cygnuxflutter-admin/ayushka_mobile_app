// import 'dart:convert';
//
// ExpenseResponse expenseResponseFromJson(String str) =>
//     ExpenseResponse.fromJson(json.decode(str));
//
// String expenseResponseToJson(ExpenseResponse data) =>
//     json.encode(data.toJson());
//
// class ExpenseResponse {
//   final String status;
//   final String message;
//   final ExpenseData expenseData;
//
//   ExpenseResponse({
//     required this.status,
//     required this.message,
//     required this.expenseData,
//   });
//
//   factory ExpenseResponse.fromJson(Map<String, dynamic> json) =>
//       ExpenseResponse(
//         status: json["status"],
//         message: json["message"],
//         expenseData: ExpenseData.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "ExpenseData": expenseData.toJson(),
//       };
// }
//
// class ExpenseData {
//   final String rfoNo;
//   final String gaushalaId;
//   final String vendorId;
//   final String billNo;
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
//   final String createdAt;
//   final String updatedAt;
//   final bool isDeleted;
//   final String id;
//
//   ExpenseData({
//     required this.rfoNo,
//     required this.gaushalaId,
//     required this.vendorId,
//     required this.billNo,
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
//     required this.id,
//   });
//
//   factory ExpenseData.fromJson(Map<String, dynamic> json) => ExpenseData(
//         rfoNo: json["RFO_no"] ?? '',
//         gaushalaId: json["gaushala_id"] ?? '',
//         vendorId: json["vendor_id"] ?? '',
//         billNo: json["bill_no"] ?? '',
//         expenceType: json["expence_type"] ?? '',
//         qty: json["qty"] ?? '',
//         kgPerUnit: json["kg_per_unit"]?.toDouble(),
//         ratePerUnit: json["rate_per_unit"]?.toDouble(),
//         totalWtOrQty: json["totalWtOrQty"]?.toDouble(),
//         totalAmount: json["total_amount"]?.toDouble(),
//         entryBy: json["entry_by"] ?? '',
//         remark: json["remark"] ?? '',
//         isStock: json["isStock"] ?? false,
//         date: json["date"] ?? '',
//         createdAt: json["createdAt"] ?? '',
//         updatedAt: json["updatedAt"] ?? '',
//         isDeleted: json["isDeleted"] ?? false,
//         id: json["id"] ?? '',
//       );
//
//   Map<String, dynamic> toJson() => {
//         "RFO_no": rfoNo,
//         "gaushala_id": gaushalaId,
//         "vendor_id": vendorId,
//         "bill_no": billNo,
//         "expence_type": expenceType,
//         "qty": qty,
//         "kg_per_unit": kgPerUnit,
//         "rate_per_unit": ratePerUnit,
//         "totalWtOrQty": totalWtOrQty,
//         "total_amount": totalAmount,
//         "entry_by": entryBy,
//         "remark": remark,
//         "isStock": isStock,
//         "date": date,
//         "createdAt": createdAt,
//         "updatedAt": updatedAt,
//         "isDeleted": isDeleted,
//         "id": id,
//       };
// }
