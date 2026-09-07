import 'dart:convert';

MilkInformationRequest milkInformationRequestFromJson(String str) => MilkInformationRequest.fromJson(json.decode(str));

String milkInformationRequestToJson(MilkInformationRequest data) => json.encode(data.toJson());

class MilkInformationRequest {
  final String tagId;

  MilkInformationRequest({
    required this.tagId,
  });

  factory MilkInformationRequest.fromJson(Map<String, dynamic> json) => MilkInformationRequest(
    tagId: json["tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "tag_id": tagId,
  };
}
