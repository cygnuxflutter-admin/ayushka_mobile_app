import 'dart:convert';

PendingVaccineRequest pendingVaccineRequestFromJson(String str) => PendingVaccineRequest.fromJson(json.decode(str));

String pendingVaccineRequestToJson(PendingVaccineRequest data) => json.encode(data.toJson());

class PendingVaccineRequest {
  final String vacName;
  final String shedId;
  final String cowType;

  PendingVaccineRequest({
    required this.vacName,
    required this.shedId,
    required this.cowType,
  });

  factory PendingVaccineRequest.fromJson(Map<String, dynamic> json) => PendingVaccineRequest(
    vacName: json["vac_name"],
    shedId: json["shed_id"],
    cowType: json["cow_type"],
  );

  Map<String, dynamic> toJson() => {
    "vac_name": vacName,
    "shed_id": shedId,
    "cow_type": cowType,
  };
}
