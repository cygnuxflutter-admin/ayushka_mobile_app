
import 'dart:convert';

AddMedicalResponse addMedicalResponseFromJson(String str) => AddMedicalResponse.fromJson(json.decode(str));

String addMedicalResponseToJson(AddMedicalResponse data) => json.encode(data.toJson());

class AddMedicalResponse {
  final String status;
  final String message;
  final List<AddMedicalDatum> addMedicalData;

  AddMedicalResponse({
    required this.status,
    required this.message,
    required this.addMedicalData,
  });

  factory AddMedicalResponse.fromJson(Map<String, dynamic> json) => AddMedicalResponse(
    status: json["status"],
    message: json["message"],
    addMedicalData: List<AddMedicalDatum>.from(json["data"].map((x) => AddMedicalDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "addMedicalData": List<dynamic>.from(addMedicalData.map((x) => x.toJson())),
  };
}

class AddMedicalDatum {
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
  final List<MedicineData> medicines;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final bool isActive;
  final String id;

  AddMedicalDatum({
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
    required this.id,
  });

  factory AddMedicalDatum.fromJson(Map<String, dynamic> json) => AddMedicalDatum(
    gaushalaId: json["gaushala_id"]??"",
    medicalId: json["medical_id"]??0,
    cowId: json["cowId"]??"",
    vacName: json["vac_name"]??"",
    dose: json["dose"]??0,
    nextDoseTime: json["next_dose_time"]??"",
    date: json["date"]??"",
    remark: json["remark"]??"",
    gapInDay: json["gap_in_day"]??0,
    status: json["status"]??"",
    addedBy: json["added_by"]??"",
    type: json["type"]??"",
    toDate: json["to_date"]??"",
    heatAttempt: json["heat_attempt"]??0,
    medicines: List<MedicineData>.from(json["medicines"].map((x) => MedicineData.fromJson(x))),
    createdAt: json["createdAt"]??"",
    updatedAt: json["updatedAt"]??"",
    isDeleted: json["isDeleted"]??false,
    isActive: json["isActive"]??false,
    id: json["id"]??"",
  );

  Map<String, dynamic> toJson() => {
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
    "id": id,
  };
}

class MedicineData {
  final String itemName;
  final String itemId;
  final num count;
  final String id;
  final String medicineId;

  MedicineData({
    required this.itemName,
    required this.itemId,
    required this.count,
    required this.id,
    required this.medicineId,
  });

  factory MedicineData.fromJson(Map<String, dynamic> json) => MedicineData(
    itemName: json["item_name"]??"",
    itemId: json["item_id"]??"",
    count: json["count"]??0.0,
    id: json["_id"]??"",
    medicineId: json["id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "item_name": itemName,
    "item_id": itemId,
    "count": count,
    "_id": id,
    "id": medicineId,
  };
}
