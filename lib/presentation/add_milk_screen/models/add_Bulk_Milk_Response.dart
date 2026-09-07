// To parse this JSON data, do
//
//     final addBulkMilkResponse = addBulkMilkResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddBulkMilkResponse addBulkMilkResponseFromJson(String str) => AddBulkMilkResponse.fromJson(json.decode(str));

String addBulkMilkResponseToJson(AddBulkMilkResponse data) => json.encode(data.toJson());

class AddBulkMilkResponse {
  final String status;
  final String message;
  final BulkMilk bulkMilk;

  AddBulkMilkResponse({
    required this.status,
    required this.message,
    required this.bulkMilk,
  });

  factory AddBulkMilkResponse.fromJson(Map<String, dynamic> json) => AddBulkMilkResponse(
    status: json["status"],
    message: json["message"],
    bulkMilk: BulkMilk.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "BulkMilk": bulkMilk.toJson(),
  };
}

class BulkMilk {
  final int count;

  BulkMilk({
    required this.count,
  });

  factory BulkMilk.fromJson(Map<String, dynamic> json) => BulkMilk(
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
  };
}
