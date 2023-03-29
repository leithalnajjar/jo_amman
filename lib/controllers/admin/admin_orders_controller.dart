import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/enum/order_status_enum.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/models/order_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';
import 'package:jo_amman/ui/screens/admin/orders/admin_orders_data_source.dart';

class AdminOrdersController extends GetxController {
  static AdminOrdersController get to => Get.isRegistered<AdminOrdersController>() ? Get.find<AdminOrdersController>() : Get.put(AdminOrdersController());

  final TextEditingController controllerSearch = TextEditingController();

  late AdminOrdersDataSource ordersDataSource;

  finishOrder({required OrderModel model}) async {
    Utils.showLoadingDialog();
    model.status = OrderStatusEnum.finished;
    await ReferenceFirebase.ORDERS.doc(model.id).update(model.toJson());
    ordersDataSource.setNextView();
    Utils.hideLoadingDialog();
  }

}
