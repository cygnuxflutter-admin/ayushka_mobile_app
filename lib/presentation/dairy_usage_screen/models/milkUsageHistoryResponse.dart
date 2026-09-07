import 'dart:convert';

MilkUsageHistoryResponse milkUsageHistoryResponseFromJson(String str) => MilkUsageHistoryResponse.fromJson(json.decode(str));

String milkUsageHistoryResponseToJson(MilkUsageHistoryResponse data) => json.encode(data.toJson());

class MilkUsageHistoryResponse {
  final String status;
  final String message;
  final List<MilkUsageHistoryDatum> milkUsageHistoryData;

  MilkUsageHistoryResponse({
    required this.status,
    required this.message,
    required this.milkUsageHistoryData,
  });

  factory MilkUsageHistoryResponse.fromJson(Map<String, dynamic> json) => MilkUsageHistoryResponse(
    status: json["status"],
    message: json["message"],
    milkUsageHistoryData: json["data"] != null ? List<MilkUsageHistoryDatum>.from(json["data"].map((x) => MilkUsageHistoryDatum.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "milkUsageHistoryData": List<dynamic>.from(milkUsageHistoryData.map((x) => x.toJson())),
  };
}

class MilkUsageHistoryDatum {
  final String liter;
  final String usedIn;
  final String distributionPerson;
  final String description;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final bool isActive;
  final String gaushalaId;
  final String id;
  final String date;

  MilkUsageHistoryDatum({
    required this.liter,
    required this.usedIn,
    required this.distributionPerson,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.isActive,
    required this.gaushalaId,
    required this.id,
    required this.date,
  });

  factory MilkUsageHistoryDatum.fromJson(Map<String, dynamic> json) => MilkUsageHistoryDatum(
    liter: json["liter"]??"",
    usedIn: json["used_in"]??"",
    distributionPerson: json["distribution_person"]??"",
    description: json["description"]??"",
    createdAt: json["createdAt"]??"",
    updatedAt: json["updatedAt"]??"",
    isDeleted: json["isDeleted"]??false,
    isActive: json["isActive"]??false,
    gaushalaId: json["gaushala_id"]??"",
    id: json["id"]??"",
    date: json["date"]??"",
  );

  Map<String, dynamic> toJson() => {
    "liter": liter,
    "used_in": usedIn,
    "distribution_person":distributionPerson,
    "description": description,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "gaushala_id": gaushalaId,
    "id": id,
    "date": date,
  };
}


