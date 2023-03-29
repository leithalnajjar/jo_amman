// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    this.id = '',
    required this.price,
    required this.phone,
  });

  String id;
  double price;
  String phone;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        id: json["id"] ?? '',
        price: json["price"]?.toDouble() ?? 0,
        phone: json["phone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "phone": phone,
      };
}
