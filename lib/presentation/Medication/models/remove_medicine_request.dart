import 'dart:convert';

RemoveMedicineRequest removeMedicineRequestFromJson(String str) => RemoveMedicineRequest.fromJson(json.decode(str));

String removeMedicineRequestToJson(RemoveMedicineRequest data) => json.encode(data.toJson());

class RemoveMedicineRequest {
  final int medicalId;
  final String itemId;

  RemoveMedicineRequest({
    required this.medicalId,
    required this.itemId,
  });

  factory RemoveMedicineRequest.fromJson(Map<String, dynamic> json) => RemoveMedicineRequest(
    medicalId: json["medical_id"],
    itemId: json["item_id"],
  );

  Map<String, dynamic> toJson() => {
    "medical_id": medicalId,
    "item_id": itemId,
  };
}
