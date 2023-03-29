// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    required this.versionCode,
    required this.price,
    required this.phone,
  });

  int versionCode;
  double price;
  String phone;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        versionCode: json["version_code"] ?? 0,
        price: json["price"]?.toDouble() ?? 0,
        phone: json["phone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "version_code": versionCode,
        "price": price,
        "phone": phone,
      };
}
