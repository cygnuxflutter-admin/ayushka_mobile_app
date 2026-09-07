
import 'dart:convert';

MedicineHistoryByCowIdRequest medicineHistoryByCowIdRequestFromJson(String str) => MedicineHistoryByCowIdRequest.fromJson(json.decode(str));

String medicineHistoryByCowIdRequestToJson(MedicineHistoryByCowIdRequest data) => json.encode(data.toJson());

class MedicineHistoryByCowIdRequest {
  final String cowId;

  MedicineHistoryByCowIdRequest({
    required this.cowId,
  });

  factory MedicineHistoryByCowIdRequest.fromJson(Map<String, dynamic> json) => MedicineHistoryByCowIdRequest(
    cowId: json["cowId"],
  );

  Map<String, dynamic> toJson() => {
    "cowId": cowId,
  };
}
