import 'dart:convert';

CowHierarchyRequest cowHierarchyRequestFromJson(String str) => CowHierarchyRequest.fromJson(json.decode(str));

String cowHierarchyRequestToJson(CowHierarchyRequest data) => json.encode(data.toJson());

class CowHierarchyRequest {
  final String tagId;

  CowHierarchyRequest({
    required this.tagId,
  });

  factory CowHierarchyRequest.fromJson(Map<String, dynamic> json) => CowHierarchyRequest(
    tagId: json["tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "tag_id": tagId,
  };
}
