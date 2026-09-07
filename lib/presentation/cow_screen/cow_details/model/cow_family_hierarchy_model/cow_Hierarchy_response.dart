import 'dart:convert';

CowHierarchyResponse cowHierarchyFromJson(String str) =>
    CowHierarchyResponse.fromJson(json.decode(str));

class CowHierarchyResponse {
  final String status;
  final String message;
  final CowData cowData;

  CowHierarchyResponse({
    required this.status,
    required this.message,
    required this.cowData,
  });

  factory CowHierarchyResponse.fromJson(Map<String, dynamic> json) =>
      CowHierarchyResponse(
        status: json["status"],
        message: json["message"],
        cowData: CowData.fromJson(json["data"] ?? []),
      );
}

class CowData {
  final dynamic cowId;
  final String calfName;
  final String gender;
  final String birthDate;
  final String motherId;
  final String fatherId;
  final String type;
  final String breed;
  final List<CowData> parentsList;

  CowData({
    required this.cowId,
    required this.calfName,
    required this.gender,
    required this.birthDate,
    required this.motherId,
    required this.fatherId,
    required this.parentsList,
    required this.type,
    required this.breed,
  });

  factory CowData.fromJson(Map<String, dynamic> json) => CowData(
        cowId: json["cowId"] ?? "",
        calfName: json["calfName"] ?? "",
        gender: json["gender"] ?? "",
        birthDate: json["birthDate"] ?? "",
        motherId: json["motherId"] ?? "",
        fatherId: json["fatherId"] ?? "",
        type: json["type"] ?? '',
        breed: json["breed"] ?? '',
        parentsList: (json['parents'] as List).map((data) => CowData.fromJson(data)).toList(),
      );
}
