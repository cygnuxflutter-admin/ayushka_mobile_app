import 'dart:convert';

CowListRes cowListResFromJson(String str) => CowListRes.fromJson(json.decode(str));

String cowListResToJson(CowListRes data) => json.encode(data.toJson());

class CowListRes {
  final String status;
  final String message;
  final Data data;

  CowListRes({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CowListRes.fromJson(Map<String, dynamic> json) => CowListRes(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final List<Datum> data;
  final Paginator paginator;

  Data({
    required this.data,
    required this.paginator,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        paginator: Paginator.fromJson(json["paginator"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paginator": paginator.toJson(),
      };
}

class Datum {
  final String breed;
  final String type;
  final String shedId;
  final String tagId;
  final String calfName;
  final bool isFemale;
  final String id;

  Datum({
    required this.breed,
    required this.type,
    required this.shedId,
    required this.tagId,
    required this.calfName,
    required this.id,
    required this.isFemale,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        breed: json["breed"] ?? '',
        type: json["type"] ?? '',
        shedId: json["shed_id"] ?? '',
        tagId: json["tag_id"].toString(),
        calfName: json["calf_name"] ?? '',
        id: json["id"] ?? '',
        isFemale: json["isFemale"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "breed": breed,
        "type": type,
        "shed_id": shedId,
        "tag_id": tagId.toString(),
        "calf_name": calfName,
        "id": id,
        "isFemale": isFemale,
      };
}

class Paginator {
  final String itemCount;
  final String offset;
  final String perPage;
  final String pageCount;
  final String currentPage;
  final String slNo;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prev;
  final dynamic next;

  Paginator({
    required this.itemCount,
    required this.offset,
    required this.perPage,
    required this.pageCount,
    required this.currentPage,
    required this.slNo,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prev,
    required this.next,
  });

  factory Paginator.fromJson(Map<String, dynamic> json) => Paginator(
        itemCount: json["itemCount"].toString(),
        offset: json["offset"].toString(),
        perPage: json["perPage"].toString(),
        pageCount: json["pageCount"].toString(),
        currentPage: json["currentPage"].toString(),
        slNo: json["slNo"].toString(),
        hasPrevPage: json["hasPrevPage"] ?? false,
        hasNextPage: json["hasNextPage"] ?? false,
        prev: json["prev"] ?? '',
        next: json["next"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "itemCount": itemCount,
        "offset": offset,
        "perPage": perPage,
        "pageCount": pageCount,
        "currentPage": currentPage,
        "slNo": slNo,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prev": prev,
        "next": next,
      };
}
