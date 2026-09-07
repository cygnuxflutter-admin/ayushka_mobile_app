import 'dart:convert';

AddNewMedicineRequest addNewMedicineRequestFromJson(String str) => AddNewMedicineRequest.fromJson(json.decode(str));

String addNewMedicineRequestToJson(AddNewMedicineRequest data) => json.encode(data.toJson());

class AddNewMedicineRequest {
  final int medicalId;
  final String itemId;
  final String itemName;
  final num count;

  AddNewMedicineRequest({
    required this.medicalId,
    required this.itemId,
    required this.itemName,
    required this.count,
  });

  factory AddNewMedicineRequest.fromJson(Map<String, dynamic> json) => AddNewMedicineRequest(
    medicalId: json["medical_id"],
    itemId: json["item_id"],
    itemName: json["item_name"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "medical_id": medicalId,
    "item_id": itemId,
    "item_name": itemName,
    "count": count,
  };
}
