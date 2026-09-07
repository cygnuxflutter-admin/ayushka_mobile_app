import 'dart:convert';

import 'package:get/get.dart';

PendingVaccineCowResponse pendingVaccineCowResponseFromJson(String str) => PendingVaccineCowResponse.fromJson(json.decode(str));

String pendingVaccineCowResponseToJson(PendingVaccineCowResponse data) => json.encode(data.toJson());

class PendingVaccineCowResponse {
  final String status;
  final String message;
  final List<PendingVaccineCowDatum> pendingVaccineCowData;

  PendingVaccineCowResponse({
    required this.status,
    required this.message,
    required this.pendingVaccineCowData,
  });

  factory PendingVaccineCowResponse.fromJson(Map<String, dynamic> json) => PendingVaccineCowResponse(
    status: json["status"],
    message: json["message"],
    pendingVaccineCowData: List<PendingVaccineCowDatum>.from(json["data"].map((x) => PendingVaccineCowDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "PendingVaccineCowData": List<dynamic>.from(pendingVaccineCowData.map((x) => x.toJson())),
  };
}

class PendingVaccineCowDatum {
  final String type;
  final String shedId;
  final String tagId;
  final String calfName;
  final String id;
  RxBool isSelectCow = false.obs;


  PendingVaccineCowDatum({
    required this.type,
    required this.shedId,
    required this.tagId,
    required this.calfName,
    required this.id,
    required this.isSelectCow,
  });

  factory PendingVaccineCowDatum.fromJson(Map<String, dynamic> json) => PendingVaccineCowDatum(
    type: json["type"]??'',
    shedId: json["shed_id"]??"",
    tagId: json["tag_id"]??"",
    calfName: json["calf_name"]??"",
    id: json["id"]??"",
    isSelectCow:  RxBool(json['isSelectCow'] ?? false),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "shed_id":shedId,
    "tag_id": tagId,
    "calf_name": calfName,
    "id": id,
  };
}
