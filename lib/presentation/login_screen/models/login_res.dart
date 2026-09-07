
import 'dart:convert';

LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
  final String status;
  final String message;
  final Data data;

  LoginRes({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
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
  final String userId;
  final int userType;
  final String email;
  final String mobileNo;
  final int loginRetryLimit;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool isActive;
  final dynamic loginReactiveTime;
  final String gaushalaId;
  final String id;
  final String token;

  Data({
    required this.userId,
    required this.userType,
    required this.email,
    required this.mobileNo,
    required this.loginRetryLimit,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.isActive,
    required this.loginReactiveTime,
    required this.gaushalaId,
    required this.id,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    userType: json["userType"],
    email: json["email"],
    mobileNo: json["mobileNo"],
    loginRetryLimit: json["loginRetryLimit"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    loginReactiveTime: json["loginReactiveTime"] ?? null,
    gaushalaId: json["gaushala_id"] ?? "01",
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "userType": userType,
    "email": email,
    "mobileNo": mobileNo,
    "loginRetryLimit": loginRetryLimit,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "isDeleted": isDeleted,
    "isActive": isActive,
    "loginReactiveTime": loginReactiveTime,
    "gaushala_id": gaushalaId,
    "id": id,
    "token": token,
  };
}
