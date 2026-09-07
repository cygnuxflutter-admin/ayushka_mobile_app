
import 'dart:convert';

LoginReq loginReqFromJson(String str) => LoginReq.fromJson(json.decode(str));

String loginReqToJson(LoginReq data) => json.encode(data.toJson());

class LoginReq {
  final String username;
  final String password;

  LoginReq({
    required this.username,
    required this.password,
  });

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
