// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
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
    required this.phoneNumber,
    required this.price,
    required this.totalPrice,
    required this.status,
    required this.date,
    required this.isDeleted,
  });

  String id;
  UserModel? user;
  DocumentReference userId;
  String phoneNumber;
  double quantity;
  double price;
  double totalPrice;
  OrderStatusEnum status;
  DateTime? date;
  bool isDeleted;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"] ?? "",
        userId: json["user_id"] ?? ReferenceFirebase.GET_USER('0'),
        phoneNumber: json["phone_number"] ?? '',
        quantity: json["quantity"]?.toDouble() ?? 0.0,
        price: json["price"]?.toDouble() ?? 0.0,
        totalPrice: json["total_price"]?.toDouble() ?? 0.0,
        status: OrderStatusEnum.values.firstWhereOrNull((element) => element.name == (json["status"] ?? '')) ?? OrderStatusEnum.pending,
        date: json["date"]?.toDate(),
        isDeleted: json["is_deleted"] ?? false,
      );

  Map<String, dynamic> toJson() {
    List<String> searchOptions = [];
    String temp = "";
    searchOptions.add(temp);
    for (int i = 0; i < phoneNumber.length; i++) {
      temp = temp + phoneNumber[i].toLowerCase();
      searchOptions.add(temp);
    }
    if (date != null) {
      temp = "";
      String dateString = intl.DateFormat('dd/MM/yyyy').format(date!);
      for (int i = 0; i < dateString.length; i++) {
        temp = temp + dateString[i].toLowerCase();
        searchOptions.add(temp);
      }
    }
    return {
      "user_id": userId,
      "phone_number": phoneNumber,
      "quantity": quantity,
      "price": price,
      "total_price": totalPrice,
      "status": status.name,
      "date": date,
      "is_deleted": isDeleted,
      "search_option": searchOptions,
    };
  }
}
