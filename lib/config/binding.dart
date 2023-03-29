import 'package:jo_amman/controllers/admin/admin_config_controller.dart';
import 'package:jo_amman/controllers/admin/admin_home_controller.dart';
import 'package:jo_amman/controllers/admin/admin_orders_controller.dart';
import 'package:jo_amman/controllers/admin/admin_sliders_controller.dart';
import 'package:jo_amman/controllers/user/user_home_controller.dart';
import 'package:jo_amman/controllers/auth/otp_controller.dart';
import 'package:get/get.dart';
import 'package:jo_amman/controllers/auth/sign_in_controller.dart';
import 'package:jo_amman/controllers/app_controller.dart';
import 'package:jo_amman/controllers/user/user_order_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => OtpController());

    Get.lazyPut(() => UserHomeController());
    Get.lazyPut(() => UserOrderController());

    Get.lazyPut(() => AdminHomeController());
    Get.lazyPut(() => AdminConfigController());
    Get.lazyPut(() => AdminSlidersController());
    Get.lazyPut(() => AdminOrdersController());
  }
}
