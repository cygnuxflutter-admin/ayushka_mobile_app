import 'dart:convert';

List<ExpenseAddBulkRequest> expenseAddBulkRequestFromJson(String str) =>
    List<ExpenseAddBulkRequest>.from(
        json.decode(str).map((x) => ExpenseAddBulkRequest.fromJson(x)));

String expenseAddBulkRequestToJson(List<ExpenseAddBulkRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseAddBulkRequest {
  final String rfoNo;
  final String gaushalaId;
  final String vendorId;
  final String billNo;
  final String itemId;
  final String expenceType;
  final String qty;
  final double kgPerUnit;
  final double ratePerUnit;
  final double totalWtOrQty;
  final double totalAmount;
  final String entryBy;
  final String remark;
  final bool isStock;
  final String date;
  final int rfo_type;
  final int paymentType;
  final String vendorName;
  final String fromDate;
  final String toDate;
  final String bill_date;
  final String sgst;
  final String cgst;

  ExpenseAddBulkRequest({
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
    required this.rfo_type,
    required this.paymentType,
    required this.vendorName,
    required this.fromDate,
    required this.toDate,
    required this.bill_date,
    required this.sgst,
    required this.cgst,
  });

  factory ExpenseAddBulkRequest.fromJson(Map<String, dynamic> json) =>
      ExpenseAddBulkRequest(
        rfoNo: json["RFO_no"],
        gaushalaId: json["gaushala_id"],
        vendorId: json["vendor_id"],
        billNo: json["bill_no"],
        itemId: json["item_id"],
        expenceType: json["expence_type"],
        qty: json["qty"],
        kgPerUnit: json["kg_per_unit"],
        ratePerUnit: json["rate_per_unit"],
        totalWtOrQty: json["totalWtOrQty"],
        totalAmount: json["total_amount"],
        entryBy: json["entry_by"],
        remark: json["remark"],
        isStock: json["isStock"],
        date: json["date"],
        rfo_type: json["rfo_type"],
        paymentType:   json["paymentType"],
        vendorName: json["vendorName"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
        bill_date: json["bill_date"],
        sgst: json["sgst"],
        cgst: json["cgst"],
      );

  Map<String, dynamic> toJson() =>
      {
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
        "rfo_type": rfo_type,
        "paymentType": paymentType,
        "vendorName":vendorName,
        "fromDate":fromDate,
        "toDate":toDate,
        "bill_date":bill_date,
        "sgst":sgst,
        "cgst":cgst,
      };
}
