import 'dart:convert';

AddNewMedicineResponse addNewMedicineResponseFromJson(String str) => AddNewMedicineResponse.fromJson(json.decode(str));

String addNewMedicineResponseToJson(AddNewMedicineResponse data) => json.encode(data.toJson());

class AddNewMedicineResponse {
  final String status;
  final String message;
  final AddNewMedicineData addNewMedicineData;

  AddNewMedicineResponse({
    required this.status,
    required this.message,
    required this.addNewMedicineData,
  });

  factory AddNewMedicineResponse.fromJson(Map<String, dynamic> json) => AddNewMedicineResponse(
    status: json["status"],
    message: json["message"],
    addNewMedicineData: AddNewMedicineData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "AddNewMedicineData": addNewMedicineData.toJson(),
  };
}

class AddNewMedicineData {
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
  final List<Medicine> medicines;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final bool isActive;
  final String id;

  AddNewMedicineData({
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

  factory AddNewMedicineData.fromJson(Map<String, dynamic> json) => AddNewMedicineData(
    gaushalaId: json["gaushala_id"],
    medicalId: json["medical_id"],
    cowId: json["cowId"],
    vacName: json["vac_name"],
    dose: json["dose"],
    nextDoseTime:json["next_dose_time"],
    date: json["date"],
    remark: json["remark"],
    gapInDay: json["gap_in_day"],
    status: json["status"],
    addedBy: json["added_by"],
    type: json["type"],
    toDate:json["to_date"],
    heatAttempt: json["heat_attempt"],
    medicines: List<Medicine>.from(json["medicines"].map((x) => Medicine.fromJson(x))),
    createdAt: json["createdAt"],
    updatedAt:json["updatedAt"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    id: json["id"],
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
    "updatedAt": updatedAt ,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "id": id,
  };
}

class Medicine {
  final String itemId;
  final String itemName;
  final num count;
  final String id;
  final String medicineId;

  Medicine({
    required this.itemId,
    required this.itemName,
    required this.count,
    required this.id,
    required this.medicineId,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    itemId: json["item_id"],
    itemName: json["item_name"],
    count: json["count"],
    id: json["_id"],
    medicineId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_name": itemName,
    "count": count,
    "_id": id,
    "id": medicineId,
  };
}
