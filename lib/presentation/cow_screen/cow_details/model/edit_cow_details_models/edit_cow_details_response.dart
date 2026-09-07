// To parse this JSON data, do
//
//     final editCowDetailsResponse = editCowDetailsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EditCowDetailsResponse editCowDetailsResponseFromJson(String str) => EditCowDetailsResponse.fromJson(json.decode(str));

String editCowDetailsResponseToJson(EditCowDetailsResponse data) => json.encode(data.toJson());

class EditCowDetailsResponse {
  final String status;
  final String message;
  final EditCowDetailsData editCowDetailsData;

  EditCowDetailsResponse({
    required this.status,
    required this.message,
    required this.editCowDetailsData,
  });

  factory EditCowDetailsResponse.fromJson(Map<String, dynamic> json) => EditCowDetailsResponse(
    status: json["status"],
    message: json["message"],
    editCowDetailsData: EditCowDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "editCowDetailsData": editCowDetailsData.toJson(),
  };
}

class EditCowDetailsData {
  final String avatarUrl;
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
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final String gaushalaId;
  final String updatedBy;
  final String id;

  EditCowDetailsData({
    required this.avatarUrl,
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
    required this.gaushalaId,
    required this.updatedBy,
    required this.id,
  });

  factory EditCowDetailsData.fromJson(Map<String, dynamic> json) => EditCowDetailsData(
    avatarUrl: json["avatarUrl"]??"",
    breed: json["breed"]??"",
    type: json["type"]??"",
    shedId: json["shed_id"]??"",
    tagId: json["tag_id"]??"",
    dob: json["dob"]??"",
    calfName: json["calf_name"]??"",
    isFemale: json["isFemale"]??false,
    addedBy: json["addedBy"]??"",
    calfWeight: json["calf_weight"]??0,
    damId: json["dam_id"]??"",
    damName: json["dam_name"]??"",
    sairId: json["sair_id"]??"",
    sairName: json["sair_name"]??"",
    deliveryTime: json["delivery_time"]??"",
    sendDiedDate: json["send_died_date"]??"",
    purchaseDate: json["purchase_date"]??"",
    remark: json["remark"]??"",
    createdAt: json["createdAt"]??"",
    updatedAt: json["updatedAt"]??"",
    isDeleted: json["isDeleted"]??false,
    gaushalaId: json["gaushala_id"]??"",
    updatedBy: json["updatedBy"]??"",
    id: json["id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "avatarUrl": avatarUrl,
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
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isDeleted": isDeleted,
    "gaushala_id": gaushalaId,
    "updatedBy": updatedBy,
    "id": id,
  };
}
