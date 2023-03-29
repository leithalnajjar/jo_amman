// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:jo_amman/config/enum/user_role_enum.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id = '',
    required this.phoneNumber,
    required this.role,
    required this.isDeleted,
  });

  String id;
  String phoneNumber;
  UserRoleEnum role;
  bool isDeleted;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        isDeleted: json["is_deleted"] ?? false,
        role: UserRoleEnum.values.firstWhereOrNull((element) => element.name == (json["role"] ?? "")) ?? UserRoleEnum.unknown,
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "role": role.name,
        "is_deleted": isDeleted,
      };
}
