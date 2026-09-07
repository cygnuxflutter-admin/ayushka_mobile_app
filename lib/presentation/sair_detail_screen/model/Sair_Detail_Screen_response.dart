// To parse this JSON data, do
//
//     final sairDetailResponse = sairDetailResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SairDetailResponse sairDetailResponseFromJson(String str) => SairDetailResponse.fromJson(json.decode(str));

String sairDetailResponseToJson(SairDetailResponse data) => json.encode(data.toJson());

class SairDetailResponse {
  final String status;
  final String message;
  final List<SairDetailDatum> sairDetailData;

  SairDetailResponse({
    required this.status,
    required this.message,
    required this.sairDetailData,
  });

  factory SairDetailResponse.fromJson(Map<String, dynamic> json) => SairDetailResponse(
    status: json["status"],
    message: json["message"],
    sairDetailData: List<SairDetailDatum>.from(json["data"].map((x) => SairDetailDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "SairDetailData": List<dynamic>.from(sairDetailData.map((x) => x.toJson())),
  };
}

class SairDetailDatum {
  final String type;
  final String tagId;
  final String calfName;
  final bool isFemale;
  final String id;

  SairDetailDatum({
    required this.type,
    required this.tagId,
    required this.calfName,
    required this.isFemale,
    required this.id,
  });

  factory SairDetailDatum.fromJson(Map<String, dynamic> json) => SairDetailDatum(
    type: json["type"],
    tagId: json["tag_id"],
    calfName: json["calf_name"],
    isFemale: json["isFemale"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "tag_id": tagId,
    "calf_name": calfName,
    "isFemale": isFemale,
    "id": id,
  };
}
