
import 'dart:convert';

CombinedCowShedResponse combinedCowShedResponseFromJson(String str) => CombinedCowShedResponse.fromJson(json.decode(str));

String combinedCowShedResponseToJson(CombinedCowShedResponse data) => json.encode(data.toJson());

class CombinedCowShedResponse {
  final String status;
  final String message;
  final Data data;

  CombinedCowShedResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CombinedCowShedResponse.fromJson(Map<String, dynamic> json) => CombinedCowShedResponse(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final CreatedShedTransferHistory createdShedTransferHistory;
  final CreatedCow createdCow;

  Data({
    required this.createdShedTransferHistory,
    required this.createdCow,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createdShedTransferHistory: CreatedShedTransferHistory.fromJson(json["createdShedTransferHistory"]),
    createdCow: CreatedCow.fromJson(json["createdCOW"]),
  );

  Map<String, dynamic> toJson() => {
    "createdShedTransferHistory": createdShedTransferHistory.toJson(),
    "createdCOW": createdCow.toJson(),
  };
}

class CreatedCow {
  final String breed;
  final String type;
  final String shedId;
  final String tagId;
  final String dob;
  final String calfName;
  final bool isFemale;
  final String addedBy;
  final int calfWeight;
  final String damId;
  final String damName;
  final String sairId;
  final String sairName;
  final String deliveryTime;
  final String sendDiedDate;
  final String purchaseDate;
  final String remark;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final String id;

  CreatedCow({
    required this.breed,
    required this.type,
    required this.shedId,
    required this.tagId,
    required this.dob,
    required this.calfName,
    required this.isFemale,
    required this.addedBy,
    required this.calfWeight,
    required this.damId,
    required this.damName,
    required this.sairId,
    required this.sairName,
    required this.deliveryTime,
    required this.sendDiedDate,
    required this.purchaseDate,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.id,
  });

  factory CreatedCow.fromJson(Map<String, dynamic> json) => CreatedCow(
    breed: json["breed"],
    type: json["type"],
    shedId: json["shed_id"],
    tagId: json["tag_id"].toString(),
    dob: json["dob"],
    calfName: json["calf_name"],
    isFemale: json["isFemale"],
    addedBy: json["addedBy"],
    calfWeight: json["calf_weight"],
    damId: json["dam_id"],
    damName: json["dam_name"],
    sairId: json["sair_id"],
    sairName: json["sair_name"],
    deliveryTime: json["delivery_time"],
    sendDiedDate: json["send_died_date"],
    purchaseDate: json["purchase_date"],
    remark: json["remark"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    isDeleted: json["isDeleted"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "breed": breed,
    "type": type,
    "shed_id": shedId,
    "tag_id": tagId,
    "dob": dob,
    "calf_name": calfName,
    "isFemale": isFemale,
    "addedBy": addedBy,
    "calf_weight": calfWeight,
    "dam_id": damId,
    "dam_name": damName,
    "sair_id": sairId,
    "sair_name": sairName,
    "delivery_time": deliveryTime,
    "send_died_date": sendDiedDate,
    "purchase_date": purchaseDate,
    "remark": remark,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "isDeleted": isDeleted,
    "id": id,
  };
}

class CreatedShedTransferHistory {
  final String userId;
  final String cowId;
  final String oldShed;
  final String newShed;
  final String description;
  final String dateTime;
  final bool isDeleted;
  final String id;

  CreatedShedTransferHistory({
    required this.userId,
    required this.cowId,
    required this.oldShed,
    required this.newShed,
    required this.description,
    required this.dateTime,
    required this.isDeleted,
    required this.id,
  });

  factory CreatedShedTransferHistory.fromJson(Map<String, dynamic> json) => CreatedShedTransferHistory(
    userId: json["userId"],
    cowId: json["cowId"],
    oldShed: json["oldShed"],
    newShed: json["newShed"],
    description: json["description"],
    dateTime: json["dateTime"],
    isDeleted: json["isDeleted"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "cowId": cowId,
    "oldShed": oldShed,
    "newShed": newShed,
    "description": description,
    "dateTime": dateTime,
    "isDeleted": isDeleted,
    "id": id,
  };
}
