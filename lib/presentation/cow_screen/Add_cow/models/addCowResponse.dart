
import 'dart:convert';

AddCowResponse addCowResponseFromJson(String str) => AddCowResponse.fromJson(json.decode(str));

String addCowResponseToJson(AddCowResponse data) => json.encode(data.toJson());

class AddCowResponse {
  final String status;
  final String message;
  final Data data;

  AddCowResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddCowResponse.fromJson(Map<String, dynamic> json) => AddCowResponse(
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    breed: json["breed"],
    type: json["type"],
    shedId: json["shed_id"],
    tagId: json["tag_id"],
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
