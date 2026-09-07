import 'dart:convert';

import 'package:get/get.dart';

GetPendingMedicineResponse getPendingMedicineResponseFromJson(String str) => GetPendingMedicineResponse.fromJson(json.decode(str));

String getPendingMedicineResponseToJson(GetPendingMedicineResponse data) => json.encode(data.toJson());

class GetPendingMedicineResponse {
  final String status;
  final String message;
  final List<GetPendingMedicineDatum> getPendingMedicineData;

  GetPendingMedicineResponse({
    required this.status,
    required this.message,
    required this.getPendingMedicineData,
  });

  factory GetPendingMedicineResponse.fromJson(Map<String, dynamic> json) => GetPendingMedicineResponse(
    status: json["status"],
    message: json["message"],
    getPendingMedicineData: List<GetPendingMedicineDatum>.from(json["data"].map((x) => GetPendingMedicineDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "getPendingMedicineData": List<dynamic>.from(getPendingMedicineData.map((x) => x.toJson())),
  };
}

class GetPendingMedicineDatum {
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
  final List<MedicineListData> medicines;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final bool isActive;
  final int v;
  final String shedId;
  final String cowType;
  RxBool isSelectCow = false.obs;


  GetPendingMedicineDatum({
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
    required this.shedId,
    required this.cowType,
    required this.isSelectCow,
  });

  factory GetPendingMedicineDatum.fromJson(Map<String, dynamic> json) => GetPendingMedicineDatum(
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
        : List<MedicineListData>.from(
            json["medicines"].map((x) => MedicineListData.fromJson(x))),
    createdAt: json["createdAt"]?.toString() ?? "",
    updatedAt: json["updatedAt"]?.toString() ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? false,
    v: (json["__v"] as num?)?.toInt() ?? 0,
    shedId: json["shed_id"]?.toString() ?? "",
    cowType: json["cow_type"]?.toString() ?? "",
    isSelectCow: RxBool(json['isSelectCow'] ?? false),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gaushala_id": gaushalaId,
    "medical_id": medicalId,
    "cowId": cowId,
    "vac_name": vacName,
    "dose": dose,
    "next_dose_time":nextDoseTime,
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
    "shed_id": shedId,
    "cow_type": cowType,
  };
}


class MedicineListData {
  final String itemName;
  final String itemId;
  final num count;
  final String id;

  MedicineListData({
    required this.itemName,
    required this.itemId,
    required this.count,
    required this.id,
  });

  factory MedicineListData.fromJson(Map<String, dynamic> json) => MedicineListData(
    itemName: json["item_name"]?.toString() ?? '',
    itemId: json["item_id"]?.toString() ?? '',
    count: json["count"] ?? 0,
    id: json["_id"]?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    "item_name": itemName,
    "item_id": itemId,
    "count": count,
    "_id": id,
  };
}
