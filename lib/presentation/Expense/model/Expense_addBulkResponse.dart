import 'dart:convert';

ExpenseAddBulkResponse expenseAddBulkResponseFromJson(String str) => ExpenseAddBulkResponse.fromJson(json.decode(str));

String expenseAddBulkResponseToJson(ExpenseAddBulkResponse data) => json.encode(data.toJson());

class ExpenseAddBulkResponse {
  final String status;
  final String message;
  final Data data;

  ExpenseAddBulkResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExpenseAddBulkResponse.fromJson(Map<String, dynamic> json) => ExpenseAddBulkResponse(
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
  final int count;

  Data({
    required this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
  };
}
