import 'dart:convert';

TodayMilkUsageResponse todayMilkUsageResponseFromJson(String str) => TodayMilkUsageResponse.fromJson(json.decode(str));

String todayMilkUsageResponseToJson(TodayMilkUsageResponse data) => json.encode(data.toJson());

class TodayMilkUsageResponse {
  final String status;
  final String message;
  final HistoryData data;

  TodayMilkUsageResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TodayMilkUsageResponse.fromJson(Map<String, dynamic> json) => TodayMilkUsageResponse(
    status: json["status"],
    message: json["message"],
    data: HistoryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class HistoryData {
  final List<TodayMilkUsedIn> todayMilkUsedInCurd;
  final List<TodayMilkUsedIn> todayMilkUsedInMilkPowder;
  final List<TodayMilkUsedIn> todayMilkUsedInMilkCounter;
  final List<TodayMilkUsedIn> todayMilkUsedInTajaMilk;
  final List<TodayMilkUsedIn> todayMilkUsedInDistributionFree;
  final List<TodayMilkUsedIn> todayMilkUsedInSweet;

  HistoryData({
    required this.todayMilkUsedInCurd,
    required this.todayMilkUsedInMilkPowder,
    required this.todayMilkUsedInMilkCounter,
    required this.todayMilkUsedInTajaMilk,
    required this.todayMilkUsedInDistributionFree,
    required this.todayMilkUsedInSweet,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
    todayMilkUsedInCurd: List<TodayMilkUsedIn>.from(json["todayMilkUsedInCurd"].map((x) => TodayMilkUsedIn.fromJson(x))),
    todayMilkUsedInMilkPowder: List<TodayMilkUsedIn>.from(json["todayMilkUsedInMilkPowder"].map((x) => TodayMilkUsedIn.fromJson(x))),
    todayMilkUsedInMilkCounter: List<TodayMilkUsedIn>.from(json["todayMilkUsedInMilkCounter"].map((x) => TodayMilkUsedIn.fromJson(x))),
    todayMilkUsedInTajaMilk: List<TodayMilkUsedIn>.from(json["todayMilkUsedInTajaMilk"].map((x) => TodayMilkUsedIn.fromJson(x))),
    todayMilkUsedInDistributionFree: List<TodayMilkUsedIn>.from(json["todayMilkUsedInDistributionFree"].map((x) => TodayMilkUsedIn.fromJson(x))),
    todayMilkUsedInSweet: List<TodayMilkUsedIn>.from(json["todayMilkUsedInSweet"].map((x) => TodayMilkUsedIn.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "todayMilkUsedInCurd": List<dynamic>.from(todayMilkUsedInCurd.map((x) => x.toJson())),
    "todayMilkUsedInMilkPowder": List<dynamic>.from(todayMilkUsedInMilkPowder.map((x) => x.toJson())),
    "todayMilkUsedInMilkCounter": List<dynamic>.from(todayMilkUsedInMilkCounter.map((x) => x.toJson())),
    "todayMilkUsedInTajaMilk": List<dynamic>.from(todayMilkUsedInTajaMilk.map((x) => x.toJson())),
    "todayMilkUsedInDistributionFree": List<dynamic>.from(todayMilkUsedInDistributionFree.map((x) => x.toJson())),
    "todayMilkUsedInSweet": List<dynamic>.from(todayMilkUsedInSweet.map((x) => x.toJson())),
  };
}

class TodayMilkUsedIn {
  final String liter;
  final String usedIn;
  final String description;

  TodayMilkUsedIn({
    required this.liter,
    required this.usedIn,
    required this.description,
  });

  factory TodayMilkUsedIn.fromJson(Map<String, dynamic> json) => TodayMilkUsedIn(
    liter: json["liter"],
    usedIn: json["used_in"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "liter": liter,
    "used_in": usedIn,
    "description": description,
  };
}
