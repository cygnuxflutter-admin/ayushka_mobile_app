import 'dart:convert';

VaccineReminderResponse vaccineReminderResponseFromJson(String str) => VaccineReminderResponse.fromJson(json.decode(str));

String vaccineReminderResponseToJson(VaccineReminderResponse data) => json.encode(data.toJson());

class VaccineReminderResponse {
  VaccineReminderResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  VaccineReminderData? data;

  factory VaccineReminderResponse.fromJson(Map<String, dynamic> json) => VaccineReminderResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] != null ? VaccineReminderData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class VaccineReminderData {
  VaccineReminderData({
    required this.data,
    required this.paginator,
  });

  List<CowReminder> data;
  Paginator? paginator;

  factory VaccineReminderData.fromJson(Map<String, dynamic> json) => VaccineReminderData(
        data: json["data"] != null ? List<CowReminder>.from(json["data"].map((x) => CowReminder.fromJson(x))) : [],
        paginator: json["paginator"] != null ? Paginator.fromJson(json["paginator"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paginator": paginator?.toJson(),
      };
}

class CowReminder {
  CowReminder({
    required this.id,
    required this.tagId,
    required this.breed,
    required this.type,
    this.dob,
    required this.isFemale,
    required this.ageInMonths,
    required this.pendingVaccines,
    required this.vaccinationHistory,
  });

  String id;
  String tagId;
  String breed;
  String type;
  String? dob;
  bool isFemale;
  int ageInMonths;
  List<PendingVaccine> pendingVaccines;
  List<dynamic> vaccinationHistory;

  factory CowReminder.fromJson(Map<String, dynamic> json) => CowReminder(
        id: json["id"] ?? "",
        tagId: json["tag_id"] ?? "",
        breed: json["breed"] ?? "",
        type: json["type"] ?? "",
        dob: json["dob"],
        isFemale: json["isFemale"] ?? false,
        ageInMonths: json["ageInMonths"] ?? 0,
        pendingVaccines: json["pendingVaccines"] != null ? List<PendingVaccine>.from(json["pendingVaccines"].map((x) => PendingVaccine.fromJson(x))) : [],
        vaccinationHistory: json["vaccinationHistory"] != null ? List<dynamic>.from(json["vaccinationHistory"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag_id": tagId,
        "breed": breed,
        "type": type,
        "dob": dob,
        "isFemale": isFemale,
        "ageInMonths": ageInMonths,
        "pendingVaccines": List<dynamic>.from(pendingVaccines.map((x) => x.toJson())),
        "vaccinationHistory": List<dynamic>.from(vaccinationHistory.map((x) => x)),
      };
}

class PendingVaccine {
  PendingVaccine({
    required this.vaccineName,
    required this.dueDate,
    this.lastGivenDate,
    required this.status,
  });

  String vaccineName;
  String dueDate;
  String? lastGivenDate;
  String status;

  factory PendingVaccine.fromJson(Map<String, dynamic> json) => PendingVaccine(
        vaccineName: json["vaccineName"] ?? "",
        dueDate: json["dueDate"] ?? "",
        lastGivenDate: json["lastGivenDate"],
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "vaccineName": vaccineName,
        "dueDate": dueDate,
        "lastGivenDate": lastGivenDate,
        "status": status,
      };
}

class Paginator {
  Paginator({
    required this.itemCount,
    required this.perPage,
    required this.currentPage,
    required this.pageCount,
    required this.slNo,
    required this.hasPrevPage,
    required this.hasNextPage,
    this.prev,
    this.next,
  });

  int itemCount;
  int perPage;
  int currentPage;
  int pageCount;
  int slNo;
  bool hasPrevPage;
  bool hasNextPage;
  dynamic prev;
  dynamic next;

  factory Paginator.fromJson(Map<String, dynamic> json) => Paginator(
        itemCount: json["itemCount"] ?? 0,
        perPage: json["perPage"] ?? 0,
        currentPage: json["currentPage"] ?? 0,
        pageCount: json["pageCount"] ?? 0,
        slNo: json["slNo"] ?? 0,
        hasPrevPage: json["hasPrevPage"] ?? false,
        hasNextPage: json["hasNextPage"] ?? false,
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "itemCount": itemCount,
        "perPage": perPage,
        "currentPage": currentPage,
        "pageCount": pageCount,
        "slNo": slNo,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prev": prev,
        "next": next,
      };
}
