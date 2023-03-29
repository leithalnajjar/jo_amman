import 'dart:developer';

import 'package:get/get.dart';
import 'package:jo_amman/config/enum/order_status_enum.dart';
import 'package:jo_amman/config/shared_prefs_client.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/models/order_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';

class UserOrderController extends GetxController {
  static UserOrderController get to => Get.isRegistered<UserOrderController>() ? Get.find<UserOrderController>() : Get.put(UserOrderController());

  final quantity = (200.0).obs;
  final totalPrice = (0.0).obs;

  calculateTotalPrice({required double price}) {
    totalPrice.value = quantity.value * price;
    update();
  }

  createOrder({required double price}) async {
    Utils.showLoadingDialog();
    await ReferenceFirebase.ORDERS.add(OrderModel(
      userId: ReferenceFirebase.GET_USER(sharedPrefsClient.id),
      quantity: quantity.value,
      price: price,
      totalPrice: totalPrice.value,
      status: OrderStatusEnum.pending,
      date: DateTime.now(),
      isDeleted: false,
    ));
    Utils.hideLoadingDialog();
    Get.back();
  }
}
