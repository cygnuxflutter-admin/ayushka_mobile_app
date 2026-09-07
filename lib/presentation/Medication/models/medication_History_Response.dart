
import 'dart:convert';

MedicationHistoryResponse medicationHistoryResponseFromJson(String str) => MedicationHistoryResponse.fromJson(json.decode(str));

String medicationHistoryResponseToJson(MedicationHistoryResponse data) => json.encode(data.toJson());

class MedicationHistoryResponse {
  final String status;
  final String message;
  final List<MedicationHistoryDatum> medicationHistoryData;

  MedicationHistoryResponse({
    required this.status,
    required this.message,
    required this.medicationHistoryData,
  });

  factory MedicationHistoryResponse.fromJson(Map<String, dynamic> json) => MedicationHistoryResponse(
    status: json["status"],
    message: json["message"],
    medicationHistoryData: List<MedicationHistoryDatum>.from(json["data"].map((x) => MedicationHistoryDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "MedicationHistoryData": List<dynamic>.from(medicationHistoryData.map((x) => x.toJson())),
  };
}

class MedicationHistoryDatum {
  final int medicalLogId;
  final String date;
  final int medicalId;
  final String remark;
  final List<Item> items;

  MedicationHistoryDatum({
    required this.medicalLogId,
    required this.date,
    required this.medicalId,
    required this.remark,
    required this.items,
  });

  factory MedicationHistoryDatum.fromJson(Map<String, dynamic> json) => MedicationHistoryDatum(
    medicalLogId: (json["medical_log_id"] as num?)?.toInt() ?? 0,
    date: json["date"]?.toString() ?? "",
    medicalId: (json["medical_id"] as num?)?.toInt() ?? 0,
    remark: json["remark"]?.toString() ?? "",
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "medical_log_id": medicalLogId,
    "date": date,
    "medical_id": medicalId,
    "remark": remark,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  final String itemId;
  final String itemName;
  final int totalWtOrQty;

  Item({
    required this.itemId,
    required this.itemName,
    required this.totalWtOrQty,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["item_id"]?.toString() ?? "",
    itemName: json["item_name"]?.toString() ?? "",
    totalWtOrQty: (json["totalWtOrQty"] as num?)?.toInt() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_name": itemName,
    "totalWtOrQty": totalWtOrQty,
  };
}
