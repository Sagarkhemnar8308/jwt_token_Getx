// To parse this JSON data, do
//
//     final jwtTokenModel = jwtTokenModelFromJson(jsonString);

import 'dart:convert';

JwtTokenModel jwtTokenModelFromJson(String str) => JwtTokenModel.fromJson(json.decode(str));

String jwtTokenModelToJson(JwtTokenModel data) => json.encode(data.toJson());

class JwtTokenModel {
    int? userId;
    String? name;
    int? groupId;
    String? phoneNumber;
    Role? role;
    int? iat;
    int? exp;

    JwtTokenModel({
        this.userId,
        this.name,
        this.groupId,
        this.phoneNumber,
        this.role,
        this.iat,
        this.exp,
    });

    factory JwtTokenModel.fromJson(Map<String, dynamic> json) => JwtTokenModel(
        userId: json["userId"],
        name: json["name"],
        groupId: json["groupId"],
        phoneNumber: json["phoneNumber"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        iat: json["iat"],
        exp: json["exp"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "groupId": groupId,
        "phoneNumber": phoneNumber,
        "role": role?.toJson(),
        "iat": iat,
        "exp": exp,
    };
}

class Role {
    int? roleId;
    String? name;
    String? code;
    List<String>? permissions;

    Role({
        this.roleId,
        this.name,
        this.code,
        this.permissions,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        name: json["name"],
        code: json["code"],
        permissions: json["permissions"] == null ? [] : List<String>.from(json["permissions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "name": name,
        "code": code,
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
    };
}
