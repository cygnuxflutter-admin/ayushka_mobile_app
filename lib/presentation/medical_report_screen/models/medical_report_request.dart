import 'dart:convert';

List<AddMedicalRequest> addMedicalRequestFromJson(String str) => List<AddMedicalRequest>.from(json.decode(str).map((x) => AddMedicalRequest.fromJson(x)));

String addMedicalRequestToJson(List<AddMedicalRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddMedicalRequest {
  final String gaushalaId;
  final String cowId;
  final String date;
  final String remark;
  final String status;
  final String addedBy;
  final String type;
  final List<VaccineItem> vaccines;

  AddMedicalRequest({
    required this.gaushalaId,
    required this.cowId,
    required this.date,
    required this.remark,
    required this.status,
    required this.addedBy,
    required this.type,
    required this.vaccines,
  });

  factory AddMedicalRequest.fromJson(Map<String, dynamic> json) => AddMedicalRequest(
    gaushalaId: json["gaushala_id"],
    cowId: json["cowId"],
    date: json["date"],
    remark: json["remark"],
    status: json["status"],
    addedBy: json["added_by"],
    type: json["type"],
    vaccines: List<VaccineItem>.from(json["vaccines"].map((x) => VaccineItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gaushala_id": gaushalaId,
    "cowId": cowId,
    "date": date,
    "remark": remark,
    "status": status,
    "added_by": addedBy,
    "type": type,
    "vaccines": List<dynamic>.from(vaccines.map((x) => x.toJson())),
  };
}

class VaccineItem {
  final String vacName;
  final int dose;
  final String nextDoseTime;
  final int gapInDay;
  final String toDate;
  final int heatAttempt;
  final List<Medicine> medicines;

  VaccineItem({
    required this.vacName,
    required this.dose,
    required this.nextDoseTime,
    required this.gapInDay,
    required this.toDate,
    required this.heatAttempt,
    required this.medicines,
  });

  factory VaccineItem.fromJson(Map<String, dynamic> json) => VaccineItem(
    vacName: json["vac_name"] ?? "",
    dose: json["dose"] ?? 0,
    nextDoseTime: json["next_dose_time"] ?? "",
    gapInDay: json["gap_in_day"] ?? 0,
    toDate: json["to_date"] ?? "",
    heatAttempt: json["heat_attempt"] ?? 0,
    medicines: json["medicines"] != null ? List<Medicine>.from(json["medicines"].map((x) => Medicine.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "vac_name": vacName,
      "dose": dose,
      "next_dose_time": nextDoseTime,
      "gap_in_day": gapInDay,
      "to_date": toDate,
      "medicines": List<dynamic>.from(medicines.map((x) => x.toJson())),
    };
    if (heatAttempt > 0) {
        data["heat_attempt"] = heatAttempt;
    }
    return data;
  }
}

class Medicine {
  final String itemId;
  final String itemName;
  final double count;

  Medicine({
    required this.itemId,
    required this.itemName,
    required this.count,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    itemId: json["item_id"],
    itemName: json["item_name"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_name": itemName,
    "count": count,
  };
}
