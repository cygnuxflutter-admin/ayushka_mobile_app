import 'dart:convert';

CombinedCowShedRequest combinedCowShedRequestFromJson(String str) => CombinedCowShedRequest.fromJson(json.decode(str));

String combinedCowShedRequestToJson(CombinedCowShedRequest data) => json.encode(data.toJson());

class CombinedCowShedRequest {
  final Cow cow;
  final Shed shed;

  CombinedCowShedRequest({
    required this.cow,
    required this.shed,
  });

  factory CombinedCowShedRequest.fromJson(Map<String, dynamic> json) => CombinedCowShedRequest(
    cow: Cow.fromJson(json["cow"]),
    shed: Shed.fromJson(json["shed"]),
  );

  Map<String, dynamic> toJson() => {
    "cow": cow.toJson(),
    "shed": shed.toJson(),
  };
}

class Cow {
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
  final double calfWeight;

  Cow({
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
  });

  factory Cow.fromJson(Map<String, dynamic> json) => Cow(
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
  };
}

class Shed {
  final String userId;
  final String cowId;
  final String oldShed;
  final String dateTime;
  final String newShed;
  final String description;

  Shed({
    required this.userId,
    required this.cowId,
    required this.oldShed,
    required this.dateTime,
    required this.newShed,
    required this.description,
  });

  factory Shed.fromJson(Map<String, dynamic> json) => Shed(
    userId: json["userId"],
    cowId: json["cowId"],
    oldShed: json["oldShed"],
    dateTime: json["dateTime"],
    newShed: json["newShed"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "cowId": cowId,
    "oldShed": oldShed,
    "dateTime": dateTime,
    "newShed": newShed,
    "description": description,
  };
}

class Result {
  final int number;
  final String string;

  Result(this.number, this.string);
}