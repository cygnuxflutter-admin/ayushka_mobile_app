import 'dart:convert';

SalesTransactionResponse salesTransactionResponseFromJson(String str) => SalesTransactionResponse.fromJson(json.decode(str));

String salesTransactionResponseToJson(SalesTransactionResponse data) => json.encode(data.toJson());

class SalesTransactionResponse {
  final String status;
  final String message;
  final SalesData salesData;

  SalesTransactionResponse({
    required this.status,
    required this.message,
    required this.salesData,
  });

  factory SalesTransactionResponse.fromJson(Map<String, dynamic> json) => SalesTransactionResponse(
    status: json["status"],
    message: json["message"],
    salesData: SalesData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "SalesData": salesData.toJson(),
  };
}

class SalesData {
  final String gaushalaId;
  final String departmentId;
  final String departmentName;
  final String itemName;
  final double qty;
  final double rate;
  final int total;
  final String mobileNumber;
  final String email;
  final String vehicleNumber;
  final String driverName;
  final String date;
  final int sleepNumber;
  final String time;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final String id;

  SalesData({
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
    required this.sleepNumber,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.id,
  });

  factory SalesData.fromJson(Map<String, dynamic> json) => SalesData(
    gaushalaId: json["gaushala_id"]??'',
    departmentId: json["department_id"]??'',
    departmentName: json["department_name"]??'',
    itemName: json["item_name"]??'',
    qty: json["qty"].toDouble(),
    rate: json["rate"].toDouble(),
    total: json["total"]??0,
    mobileNumber: json["mobile_number"]??"",
    email: json["email"]??'',
    vehicleNumber: json["vehicle_number"]??'',
    driverName: json["driver_name"]??'',
    date: json["date"]??'',
    sleepNumber: json["sleep_number"]??0,
    time: json["time"]??'',
    createdAt: json["createdAt"]??'',
    updatedAt: json["updatedAt"]??'',
    isDeleted: json["isDeleted"]??false,
    id: json["id"]??'',
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
    "sleep_number": sleepNumber,
    "time": time,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isDeleted": isDeleted,
    "id": id,
  };
}
