// To parse this JSON data, do
//
//     final salesTransactionHistoryResponse = salesTransactionHistoryResponseFromJson(jsonString);

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

SalesTransactionHistoryResponse salesTransactionHistoryResponseFromJson(String str) => SalesTransactionHistoryResponse.fromJson(json.decode(str));

String salesTransactionHistoryResponseToJson(SalesTransactionHistoryResponse data) => json.encode(data.toJson());

class SalesTransactionHistoryResponse {
  final String status;
  final String message;
  final SalesTransactionData salesTransactionData;

  SalesTransactionHistoryResponse({
    required this.status,
    required this.message,
    required this.salesTransactionData,
  });

  factory SalesTransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      SalesTransactionHistoryResponse(
        status: json["status"],
        message: json["message"],
        salesTransactionData: SalesTransactionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "SalesTransactionData": salesTransactionData.toJson(),
      };
}

class SalesTransactionData {
  final List<Datum> data;
  final Paginator paginator;

  SalesTransactionData({
    required this.data,
    required this.paginator,
  });

  factory SalesTransactionData.fromJson(Map<String, dynamic> json) =>
      SalesTransactionData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        paginator: Paginator.fromJson(json["paginator"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "paginator": paginator.toJson(),
      };
}

class Datum {
  final String gaushalaId;
  final String departmentId;
  final String departmentName;
  final String itemName;
  final double qty;
  final double rate;
  final double total;
  final String mobileNumber;
  final String vehicleNumber;
  final String driverName;
  final String date;
  final int sleepNumber;
  final String location;
  final String time;
  final bool isDeleted;
  final String id;
  GlobalKey historyGlobalKey;

  Datum({
    required this.gaushalaId,
    required this.departmentId,
    required this.departmentName,
    required this.itemName,
    required this.qty,
    required this.rate,
    required this.total,
    required this.mobileNumber,
    required this.vehicleNumber,
    required this.driverName,
    required this.date,
    required this.sleepNumber,
    required this.isDeleted,
    required this.id,
    required this.location,
    required this.time,
    required this.historyGlobalKey,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        gaushalaId: json["gaushala_id"] ?? "",
        departmentId: json["department_id"] ?? "",
        departmentName: json["department_name"] ?? "",
        itemName: json["item_name"] ?? "",
        qty: double.parse( json["qty"].toString().isEmpty ? '0.0' :  json["qty"].toString()),
        rate:double.parse(  json["rate"].toString().isEmpty?'0.0':json["rate"].toString()),
        total: double.parse( json["total"].toString().isEmpty?'0.0':json["total"].toString()),
        mobileNumber: json["mobile_number"] ?? "",
        vehicleNumber: json["vehicle_number"] ?? "",
        driverName: json["driver_name"] ?? "",
        date: json["date"] ?? "",
        sleepNumber: json["sleep_number"] ?? 0,
        isDeleted: json["isDeleted"] ?? false,
        id: json["id"] ?? "",
        historyGlobalKey: GlobalKey(),
        location: json["location"] ?? "",
        time: json["time"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "gaushala_id": gaushalaId,
        "department_id": departmentId,
        "department_name": departmentName,
        "item_name": itemName,
        "qty": qty,
        "rate": rate,
        "total": total,
        "mobile_number": mobileNumber,
        "vehicle_number": vehicleNumber,
        "driver_name": driverName,
        "date": date,
        "sleep_number": sleepNumber,
        "isDeleted": isDeleted,
        "id": id,
      };
}

class Paginator {
  final int itemCount;
  final int offset;
  final int perPage;
  final int pageCount;
  final int currentPage;
  final int slNo;
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
        itemCount: json["itemCount"],
        offset: json["offset"],
        perPage: json["perPage"],
        pageCount: json["pageCount"],
        currentPage: json["currentPage"],
        slNo: json["slNo"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prev: json["prev"],
        next: json["next"],
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
