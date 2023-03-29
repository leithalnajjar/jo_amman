import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  static AdminHomeController get to => Get.isRegistered<AdminHomeController>() ? Get.find<AdminHomeController>() : Get.put(AdminHomeController());

}
