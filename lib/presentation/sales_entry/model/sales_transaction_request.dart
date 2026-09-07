// To parse this JSON data, do
//
//     final salesTransactionRequest = salesTransactionRequestFromJson(jsonString);

import 'dart:convert';

SalesTransactionRequest salesTransactionRequestFromJson(String str) => SalesTransactionRequest.fromJson(json.decode(str));

String salesTransactionRequestToJson(SalesTransactionRequest data) => json.encode(data.toJson());

class SalesTransactionRequest {
  final String gaushalaId;
  final String departmentId;
  final String departmentName;
  final String itemName;
  final double qty;
  final int rate;
  final int total;
  final String mobileNumber;
  final String email;
  final String vehicleNumber;
  final String driverName;
  final String date;
  final String time;
  final String location;

  SalesTransactionRequest({
    required this.gaushalaId,
    required this.departmentId,
    required this.departmentName,
    required this.itemName,
    required this.qty,
    required this.rate,
    required this.total,
    required this.mobileNumber,
    required this.email,
    required this.vehicleNumber,
    required this.driverName,
    required this.date,
    required this.time,
    required this.location,
  });

  factory SalesTransactionRequest.fromJson(Map<String, dynamic> json) =>
      SalesTransactionRequest(
        gaushalaId: json["gaushala_id"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
        itemName: json["item_name"],
        qty: json["qty"],
        rate: json["rate"],
        total: json["total"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        vehicleNumber: json["vehicle_number"],
        driverName: json["driver_name"],
        date: json["date"],
        time: json["time"],
        location: json["location"],
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
        "email": email,
        "vehicle_number": vehicleNumber,
        "driver_name": driverName,
        "date": date,
        "time": time,
        "location": location,
      };
}
