import 'package:meta/meta.dart';
import 'dart:convert';

MedicineUpdateResponse medicineUpdateResponseFromJson(String str) => MedicineUpdateResponse.fromJson(json.decode(str));

String medicineUpdateResponseToJson(MedicineUpdateResponse data) => json.encode(data.toJson());

class MedicineUpdateResponse {
  final String status;
  final String message;
  final MedicineData medicineData;

  MedicineUpdateResponse({
    required this.status,
    required this.message,
    required this.medicineData,
  });

  factory MedicineUpdateResponse.fromJson(Map<String, dynamic> json) => MedicineUpdateResponse(
    status: json["status"],
    message: json["message"],
    medicineData: MedicineData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "MedicineData": medicineData.toJson(),
  };
}

class MedicineData {
  final List<int> successMedicalIds;
  final List<dynamic> errorMedicalIds;

  MedicineData({
    required this.successMedicalIds,
    required this.errorMedicalIds,
  });

  factory MedicineData.fromJson(Map<String, dynamic> json) => MedicineData(
    successMedicalIds: List<int>.from(json["successMedical_ids"].map((x) => x)),
    errorMedicalIds: List<dynamic>.from(json["errorMedical_ids"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "successMedical_ids": List<dynamic>.from(successMedicalIds.map((x) => x)),
    "errorMedical_ids": List<dynamic>.from(errorMedicalIds.map((x) => x)),
  };
}
