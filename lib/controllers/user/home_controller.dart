import 'dart:developer';

import 'package:get/get.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/networks/reference_firebase.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.isRegistered<HomeController>() ? Get.find<HomeController>() : Get.put(HomeController());

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
