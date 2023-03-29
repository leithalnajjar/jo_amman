import 'dart:developer';

import 'package:get/get.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/networks/reference_firebase.dart';

class UserHomeController extends GetxController {
  static UserHomeController get to => Get.isRegistered<UserHomeController>() ? Get.find<UserHomeController>() : Get.put(UserHomeController());

  final sliders = <String>[].obs;
  final currentSlider = 0.obs;

  getSliders() async {
    Utils.showLoadingDialog();
    var result = await ReferenceFirebase.GET_SLIDERS().get();
    sliders.value = result.docs.map((e) => e.data().url).toList();
    update();
    Utils.hideLoadingDialog();
  }
}
