import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/models/config_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';

class AdminConfigController extends GetxController {
  static AdminConfigController get to => Get.isRegistered<AdminConfigController>() ? Get.find<AdminConfigController>() : Get.put(AdminConfigController());

  final keyForm = GlobalKey<FormState>();
  final controllerPhone = TextEditingController();
  final controllerPrice = TextEditingController();
  final config = ConfigModel.fromJson({}).obs;

  getConfig() async {
    Utils.showLoadingDialog();
    var result = await ReferenceFirebase.GET_CONFIG().get();
    config.value = result.docs.first.data();
    update();
    Utils.hideLoadingDialog();
  }

  changeConfig() async {
    Utils.showLoadingDialog();
    config.value.price = double.parse(controllerPrice.text);
    config.value.phone = controllerPhone.text;
    await ReferenceFirebase.CHANGE_CONFIG(config.value.id).update(config.value.toJson());
    Utils.hideLoadingDialog();
    Get.back();
  }
}
