// ignore_for_file: file_names

import 'dart:convert';

MedicalDataResponse medicalDataResponseFromJson(String str) => MedicalDataResponse.fromJson(json.decode(str));

String medicalDataResponseToJson(MedicalDataResponse data) => json.encode(data.toJson());

class MedicalDataResponse {
  final String status;
  final String message;
  final List<MedicalData> data;

  MedicalDataResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MedicalDataResponse.fromJson(Map<String, dynamic> json) =>
      MedicalDataResponse(
        status: json["status"],
        message: json["message"],
        data: List<MedicalData>.from(
            json["data"].map((x) => MedicalData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MedicalData {
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool isActive;
  final String id;

  MedicalData({
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
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.isActive,
    required this.id,
  });

  factory MedicalData.fromJson(Map<String, dynamic> json) => MedicalData(
    gaushalaId: json["gaushala_id"],
    medicalId: json["medical_id"],
    cowId: json["cowId"],
    vacName: json["vac_name"],
    dose: json["dose"],
    nextDoseTime: json["next_dose_time"],
    date: json["date"],
    remark: json["remark"],
    gapInDay: json["gap_in_day"],
    status: json["status"],
    addedBy: json["added_by"],
    type: json["type"],
    toDate: json["to_date"],
    heatAttempt: json["heat_attempt"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "isDeleted": isDeleted,
    "isActive": isActive,
    "id": id,
  };
}
