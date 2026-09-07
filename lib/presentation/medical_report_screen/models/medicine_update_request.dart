import 'package:meta/meta.dart';
import 'dart:convert';

MedicineUpdateRequest medicineUpdateRequestFromJson(String str) => MedicineUpdateRequest.fromJson(json.decode(str));

String medicineUpdateRequestToJson(MedicineUpdateRequest data) => json.encode(data.toJson());

class MedicineUpdateRequest {
  final List<int> medicalIds;
  final String gaushalaId;
  final String cowId;
  final String vacName;
  final int dose;
  final String nextDoseTime;
  final String date;
  final String remark;
  final String medicalLogRemark;
  final String medicalLogDate;
  final int gapInDay;
  final String status;
  final String addedBy;
  final String type;
  final String toDate;
  final int heatAttempt;
  final List<StockList> stockList;

  MedicineUpdateRequest({
    required this.medicalIds,
    required this.gaushalaId,
    required this.cowId,
    required this.vacName,
    required this.dose,
    required this.nextDoseTime,
    required this.date,
    required this.remark,
    required this.medicalLogRemark,
    required this.medicalLogDate,
    required this.gapInDay,
    required this.status,
    required this.addedBy,
    required this.type,
    required this.toDate,
    required this.heatAttempt,
    required this.stockList,
  });

  factory MedicineUpdateRequest.fromJson(Map<String, dynamic> json) => MedicineUpdateRequest(
    medicalIds: List<int>.from(json["medical_ids"].map((x) => x)),
    gaushalaId: json["gaushala_id"],
    cowId: json["cowId"],
    vacName: json["vac_name"],
    dose: json["dose"],
    nextDoseTime: json["next_dose_time"],
    date: json["date"],
    remark: json["remark"],
    medicalLogRemark: json["medical_log_remark"],
    medicalLogDate: json["medical_log_date"],
    gapInDay: json["gap_in_day"],
    status: json["status"],
    addedBy: json["added_by"],
    type: json["type"],
    toDate: json["to_date"],
    heatAttempt: json["heat_attempt"],
    stockList: List<StockList>.from(json["stockList"].map((x) => StockList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "medical_ids": List<dynamic>.from(medicalIds.map((x) => x)),
    "gaushala_id": gaushalaId,
    "cowId": cowId,
    "vac_name": vacName,
    "dose": dose,
    "next_dose_time": nextDoseTime,
    "date": date,
    "remark": remark,
    "medical_log_remark": medicalLogRemark,
    "medical_log_date": medicalLogDate,
    "gap_in_day": gapInDay,
    "status": status,
    "added_by": addedBy,
    "type": type,
    "to_date": toDate,
    "heat_attempt": heatAttempt,
    "stockList": List<dynamic>.from(stockList.map((x) => x.toJson())),
  };
}

class StockList {
  final String rfoNo;
  final String itemId;
  final String itemName;
  final String vendorId;
  final String billNo;
  final String expenceType;
  final String qty;
  final int kgPerUnit;
  final int ratePerUnit;
  final num totalWtOrQty;
  final int totalAmount;
  final bool isStock;

  StockList({
    required this.rfoNo,
    required this.itemId,
    required this.itemName,
    required this.vendorId,
    required this.billNo,
    required this.expenceType,
    required this.qty,
    required this.kgPerUnit,
    required this.ratePerUnit,
    required this.totalWtOrQty,
    required this.totalAmount,
    required this.isStock,
  });

  factory StockList.fromJson(Map<String, dynamic> json) => StockList(
    rfoNo: json["RFO_no"],
    itemId: json["item_id"],
    itemName: json["item_name"],
    vendorId: json["vendor_id"],
    billNo: json["bill_no"],
    expenceType: json["expence_type"],
    qty: json["qty"],
    kgPerUnit: json["kg_per_unit"],
    ratePerUnit: json["rate_per_unit"],
    totalWtOrQty: json["totalWtOrQty"],
    totalAmount: json["total_amount"],
    isStock: json["isStock"],
  );

  Map<String, dynamic> toJson() => {
    "RFO_no": rfoNo,
    "item_id": itemId,
    "item_name": itemName,
    "vendor_id": vendorId,
    "bill_no": billNo,
    "expence_type": expenceType,
    "qty": qty,
    "kg_per_unit": kgPerUnit,
    "rate_per_unit": ratePerUnit,
    "totalWtOrQty": totalWtOrQty,
    "total_amount": totalAmount,
    "isStock": isStock,
  };
}
