import 'dart:convert';

MilkHistoryResponse milkHistoryResponseFromJson(String str) => MilkHistoryResponse.fromJson(json.decode(str));

String milkHistoryResponseToJson(MilkHistoryResponse data) => json.encode(data.toJson());

class MilkHistoryResponse {
  final String status;
  final String message;
  final MilkHistory milkHistory;

  MilkHistoryResponse({
    required this.status,
    required this.message,
    required this.milkHistory,
  });

  factory MilkHistoryResponse.fromJson(Map<String, dynamic> json) => MilkHistoryResponse(
    status: json["status"],
    message: json["message"],
    milkHistory: MilkHistory.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "milkHistory": milkHistory.toJson(),
  };
}

class MilkHistory {
  final List<Last7DayMilk> last7DayMilks;
  final PendingCows pendingCows;

  MilkHistory({
    required this.last7DayMilks,
    required this.pendingCows,
  });

  factory MilkHistory.fromJson(Map<String, dynamic> json) => MilkHistory(
    last7DayMilks: List<Last7DayMilk>.from(json["last7DayMilks"].map((x) => Last7DayMilk.fromJson(x))),
    pendingCows: PendingCows.fromJson(json["pendingCows"]),
  );

  Map<String, dynamic> toJson() => {
    "last7DayMilks": List<dynamic>.from(last7DayMilks.map((x) => x.toJson())),
    "pendingCows": pendingCows.toJson(),
  };
}

class Last7DayMilk {
  final String id;
  final String gaushalaId;
  final String date;
  final double morningMilk;
  final double eveningMilk;
  final int milkingCowsMorning;
  final int milkingCowsEvening;
  final double totalMilk;
  final String totalMilkingCows;
  final String totalGirCows;
  final int v;

  Last7DayMilk({
    required this.id,
    required this.gaushalaId,
    required this.date,
    required this.morningMilk,
    required this.eveningMilk,
    required this.milkingCowsMorning,
    required this.milkingCowsEvening,
    required this.totalMilk,
    required this.totalMilkingCows,
    required this.totalGirCows,
    required this.v,
  });

  factory Last7DayMilk.fromJson(Map<String, dynamic> json) => Last7DayMilk(
    id: json["_id"],
    gaushalaId: json["gaushala_id"],
    date: json["date"],
    morningMilk: json["morning_milk"]?.toDouble(),
    eveningMilk: json["evening_milk"]?.toDouble(),
    milkingCowsMorning: json["milking_cows_morning"],
    milkingCowsEvening: json["milking_cows_evening"],
    totalMilk: json["total_milk"]?.toDouble(),
    totalMilkingCows: json["total_milking_cows"],
    totalGirCows: json["totalGIRCows"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gaushala_id": gaushalaId,
    "date": date,
    "morning_milk": morningMilk,
    "evening_milk": eveningMilk,
    "milking_cows_morning": milkingCowsMorning,
    "milking_cows_evening": milkingCowsEvening,
    "total_milk": totalMilk,
    "total_milking_cows": totalMilkingCows,
    "totalGIRCows": totalGirCows,
    "__v": v,
  };
}

class PendingCows {
  final List<String> morning;
  final List<String> evening;

  PendingCows({
    required this.morning,
    required this.evening,
  });

  factory PendingCows.fromJson(Map<String, dynamic> json) => PendingCows(
    morning: List<String>.from(json["morning"].map((x) => x)),
    evening: List<String>.from(json["evening"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "morning": List<dynamic>.from(morning.map((x) => x)),
    "evening": List<dynamic>.from(evening.map((x) => x)),
  };
}
