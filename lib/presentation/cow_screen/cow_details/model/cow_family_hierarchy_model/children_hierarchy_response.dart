import 'dart:convert';
import 'cow_Hierarchy_response.dart';

ChildrenHierarchyResponse childrenHierarchyFromJson(String str) =>
    ChildrenHierarchyResponse.fromJson(json.decode(str));

class ChildrenHierarchyResponse {
  final String status;
  final String message;
  final List<CowData> childrenData;

  ChildrenHierarchyResponse({
    required this.status,
    required this.message,
    required this.childrenData,
  });

  factory ChildrenHierarchyResponse.fromJson(Map<String, dynamic> json) =>
      ChildrenHierarchyResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        childrenData: json["data"] != null 
            ? List<CowData>.from((json["data"] as List).map((x) => CowData.fromJson(x))) 
            : [],
      );
}
