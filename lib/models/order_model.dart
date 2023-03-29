// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/enum/order_status_enum.dart';
import 'package:jo_amman/models/user_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.id = '',
    this.user,
    required this.userId,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.status,
    required this.date,
    required this.isDeleted,
  });

  String id;
  UserModel? user;
  DocumentReference userId;
  double quantity;
  double price;
  double totalPrice;
  OrderStatusEnum status;
  DateTime date;
  bool isDeleted;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"] ?? "",
        userId: json["user_id"] ?? ReferenceFirebase.GET_USER('0'),
        quantity: json["quantity"]?.toDouble() ?? 0.0,
        price: json["price"]?.toDouble() ?? 0.0,
        totalPrice: json["total_price"]?.toDouble() ?? 0.0,
        status: OrderStatusEnum.values.firstWhereOrNull((element) => element.name == (json["status"] ?? '')) ?? OrderStatusEnum.pending,
        date: json["date"]?.toDate() ?? DateTime.now(),
        isDeleted: json["is_deleted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "quantity": quantity,
        "price": price,
        "total_price": totalPrice,
        "status": status.name,
        "date": date,
        "is_deleted": isDeleted,
      };
}
