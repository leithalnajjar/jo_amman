// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    this.id = '',
    required this.url,
    required this.isDeleted,
  });

  String id;
  String url;
  bool isDeleted;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["id"] ?? '',
        url: json["url"] ?? '',
        isDeleted: json["is_deleted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "is_deleted": isDeleted,
      };
}
