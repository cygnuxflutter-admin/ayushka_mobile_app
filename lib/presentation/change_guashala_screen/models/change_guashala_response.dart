import 'dart:convert';

ChangeGuashalaResponse changeGuashalaResponseFromJson(String str) => ChangeGuashalaResponse.fromJson(json.decode(str));

String changeGuashalaResponseToJson(ChangeGuashalaResponse data) => json.encode(data.toJson());

class ChangeGuashalaResponse {
  final String status;
  final String message;
  final ChangeGuashalaData changeGuashalaData;

  ChangeGuashalaResponse({
    required this.status,
    required this.message,
    required this.changeGuashalaData,
  });

  factory ChangeGuashalaResponse.fromJson(Map<String, dynamic> json) => ChangeGuashalaResponse(
    status: json["status"],
    message: json["message"],
    changeGuashalaData: ChangeGuashalaData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "changeGuashalaData": changeGuashalaData.toJson(),
  };
}

class ChangeGuashalaData {
  final String id;
  final String userId;
  final String password;
  final String gaushalaId;
  final int userType;
  final String email;
  final String mobileNo;
  final int loginRetryLimit;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final bool isActive;
  final int v;
  final String token;

  ChangeGuashalaData({
    required this.id,
    required this.userId,
    required this.password,
    required this.gaushalaId,
    required this.userType,
    required this.email,
    required this.mobileNo,
    required this.loginRetryLimit,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.isActive,
    required this.v,
    required this.token,
  });

  factory ChangeGuashalaData.fromJson(Map<String, dynamic> json) => ChangeGuashalaData(
    id: json["_id"],
    userId: json["user_id"],
    password: json["password"],
    gaushalaId: json["gaushala_id"],
    userType: json["userType"],
    email: json["email"],
    mobileNo: json["mobileNo"],
    loginRetryLimit: json["loginRetryLimit"],
    createdAt: json["createdAt"],
    updatedAt:json["updatedAt"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    v: json["__v"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId,
    "password": password,
    "gaushala_id": gaushalaId,
    "userType": userType,
    "email": email,
    "mobileNo": mobileNo,
    "loginRetryLimit": loginRetryLimit,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "__v": v,
    "token": token,
  };
}
