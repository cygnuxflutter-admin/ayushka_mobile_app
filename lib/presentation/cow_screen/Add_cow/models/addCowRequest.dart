
import 'dart:convert';

AddCowRequest addCowRequestFromJson(String str) => AddCowRequest.fromJson(json.decode(str));

String addCowRequestToJson(AddCowRequest data) => json.encode(data.toJson());

class AddCowRequest {
  final String breed;
  final String tagId;
  final String dob;
  final String calfName;
  final bool isFemale;
  final String damId;
  final String damName;
  final String sairId;
  final String sairName;
  final String deliveryTime;
  final String sendDiedDate;
  final String purchaseDate;
  final String remark;
  final String type;
  final String shedId;
  final String gaushalaId;
  final double calfWeight;

  AddCowRequest({
    required this.breed,
    required this.tagId,
    required this.dob,
    required this.calfName,
    required this.isFemale,
    required this.damId,
    required this.damName,
    required this.sairId,
    required this.sairName,
    required this.deliveryTime,
    required this.sendDiedDate,
    required this.purchaseDate,
    required this.remark,
    required this.type,
    required this.shedId,
    required this.calfWeight,
    required this.gaushalaId,
  });

  factory AddCowRequest.fromJson(Map<String, dynamic> json) => AddCowRequest(
    breed: json["breed"],
    tagId: json["tag_id"],
    dob: json["dob"],
    calfName: json["calf_name"],
    isFemale: json["isFemale"],
    damId: json["dam_id"],
    damName: json["dam_name"],
    sairId: json["sair_id"],
    sairName: json["sair_name"],
    deliveryTime: json["delivery_time"],
    sendDiedDate: json["send_died_date"],
    purchaseDate: json["purchase_date"],
    remark: json["remark"],
    type: json["type"],
    shedId: json["shed_id"],
    calfWeight: json["calf_weight"],
    gaushalaId: json["gaushalaId"],
  );

  Map<String, dynamic> toJson() => {
    "breed": breed,
    "tag_id": tagId,
    "dob": dob,
    "calf_name": calfName,
    "isFemale": isFemale,
    "dam_id": damId,
    "dam_name": damName,
    "sair_id": sairId,
    "sair_name": sairName,
    "delivery_time": deliveryTime,
    "send_died_date": sendDiedDate,
    "purchase_date": purchaseDate,
    "remark": remark,
    "type": type,
    "shed_id": shedId,
    "calf_weight": calfWeight,
    "gaushalaId": gaushalaId,
  };
}
