// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.username,
        required this.email,
        required this.uid,
        required this.online,
    });

    String username;
    String email;
    String uid;
    bool online;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        email: json["email"],
        uid: json["_uid"],
        online: json["online"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "_uid": uid,
        "online": online,
    };
}
