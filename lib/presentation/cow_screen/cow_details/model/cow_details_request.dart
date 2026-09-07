import 'dart:convert';

CowDetailsRequest cowDetailsRequestFromJson(String str) => CowDetailsRequest.fromJson(json.decode(str));

String cowDetailsRequestToJson(CowDetailsRequest data) => json.encode(data.toJson());

class CowDetailsRequest {
  final String tagId;

  CowDetailsRequest({
    required this.tagId,
  });

  factory CowDetailsRequest.fromJson(Map<String, dynamic> json) => CowDetailsRequest(
    tagId: json["tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "tag_id": tagId,
  };
}
