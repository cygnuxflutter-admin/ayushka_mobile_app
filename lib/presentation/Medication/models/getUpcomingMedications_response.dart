import 'dart:convert';

GetUpcomingMedicationsResponse getUpcomingMedicationsResponseFromJson(String str) => GetUpcomingMedicationsResponse.fromJson(json.decode(str));

String getUpcomingMedicationsResponseToJson(GetUpcomingMedicationsResponse data) => json.encode(data.toJson());

class GetUpcomingMedicationsResponse {
  final String status;
  final String message;
  final List<UpcomingMedicationsDatum> upcomingMedicationsData;

  GetUpcomingMedicationsResponse({
    required this.status,
    required this.message,
    required this.upcomingMedicationsData,
  });

  factory GetUpcomingMedicationsResponse.fromJson(Map<String, dynamic> json) => GetUpcomingMedicationsResponse(
    status: json["status"],
    message: json["message"],
    upcomingMedicationsData: List<UpcomingMedicationsDatum>.from(json["data"].map((x) => UpcomingMedicationsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "UpcomingMedicationsData": List<dynamic>.from(upcomingMedicationsData.map((x) => x.toJson())),
  };
}

class UpcomingMedicationsDatum {
  final String id;
  final String gaushalaId;
  final int medicalId;
  final String cowId;
  final String vacName;
  final int dose;
  final String nextDoseTime;
  final String date;
  final String remark;
  final int gapInDay;
  final String status;
  final String addedBy;
  final String type;
  final String toDate;
  final int heatAttempt;
  final List<upcomingMedicine> medicines;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final bool isActive;
  final int v;
  final String calfName;
  final String shedId;
  final String cowType;

  UpcomingMedicationsDatum({
    required this.id,
    required this.gaushalaId,
    required this.medicalId,
    required this.cowId,
    required this.vacName,
    required this.dose,
    required this.nextDoseTime,
    required this.date,
    required this.remark,
    required this.gapInDay,
    required this.status,
    required this.addedBy,
    required this.type,
    required this.toDate,
    required this.heatAttempt,
    required this.medicines,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.isActive,
    required this.v,
    required this.calfName,
    required this.shedId,
    required this.cowType,
  });

  factory UpcomingMedicationsDatum.fromJson(Map<String, dynamic> json) => UpcomingMedicationsDatum(
    id: json["_id"]?.toString() ?? "",
    gaushalaId: json["gaushala_id"]?.toString() ?? "",
    medicalId: (json["medical_id"] as num?)?.toInt() ?? 0,
    cowId: json["cowId"]?.toString() ?? "",
    vacName: json["vac_name"]?.toString() ?? "",
    dose: (json["dose"] as num?)?.toInt() ?? 0,
    nextDoseTime: json["next_dose_time"]?.toString() ?? "",
    date: json["date"]?.toString() ?? "",
    remark: json["remark"]?.toString() ?? "",
    gapInDay: (json["gap_in_day"] as num?)?.toInt() ?? 0,
    status: json["status"]?.toString() ?? "",
    addedBy: json["added_by"]?.toString() ?? "",
    type: json["type"]?.toString() ?? "",
    toDate: json["to_date"]?.toString() ?? "",
    heatAttempt: (json["heat_attempt"] as num?)?.toInt() ?? 0,
    medicines: json["medicines"] == null
        ? []
        : List<upcomingMedicine>.from(
            json["medicines"].map((x) => upcomingMedicine.fromJson(x))),
    createdAt: json["createdAt"]?.toString() ?? "",
    updatedAt: json["updatedAt"]?.toString() ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? false,
    v: (json["__v"] as num?)?.toInt() ?? 0,
    calfName: json["calf_name"]?.toString() ?? "",
    shedId: json["shed_id"]?.toString() ?? "",
    cowType: json["cow_type"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gaushala_id": gaushalaId,
    "medical_id": medicalId,
    "cowId": cowId,
    "vac_name": vacName,
    "dose": dose,
    "next_dose_time": nextDoseTime,
    "date": date,
    "remark": remark,
    "gap_in_day": gapInDay,
    "status": status,
    "added_by": addedBy,
    "type": type,
    "to_date": toDate,
    "heat_attempt": heatAttempt,
    "medicines": List<dynamic>.from(medicines.map((x) => x.toJson())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "__v": v,
    "calf_name": calfName,
    "shed_id": shedId,
    "cow_type": cowType,
  };
}

class upcomingMedicine {
  final String itemId;
  final String itemName;
  final num count;
  final String id;

  upcomingMedicine({
    required this.itemId,
    required this.itemName,
    required this.count,
    required this.id,
  });

  factory upcomingMedicine.fromJson(Map<String, dynamic> json) => upcomingMedicine(
    itemId: json["item_id"]?.toString() ?? "",
    itemName: json["item_name"]?.toString() ?? "",
    count: json["count"] ?? 0,
    id: json["_id"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_name": itemName,
    "count": count,
    "_id": id,
  };
}
