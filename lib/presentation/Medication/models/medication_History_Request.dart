import 'package:meta/meta.dart';
import 'dart:convert';

MedicationHistoryRequest medicationHistoryRequestFromJson(String str) => MedicationHistoryRequest.fromJson(json.decode(str));

String medicationHistoryRequestToJson(MedicationHistoryRequest data) => json.encode(data.toJson());

class MedicationHistoryRequest {
  final int medicalId;

  MedicationHistoryRequest({
    required this.medicalId,
  });

  factory MedicationHistoryRequest.fromJson(Map<String, dynamic> json) => MedicationHistoryRequest(
    medicalId: json["medical_id"],
  );

  Map<String, dynamic> toJson() => {
    "medical_id": medicalId,
  };
}
