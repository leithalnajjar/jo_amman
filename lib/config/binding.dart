import 'package:jo_amman/controllers/admin/admin_home_controller.dart';
import 'package:jo_amman/controllers/user/home_controller.dart';
import 'package:jo_amman/controllers/auth/otp_controller.dart';
import 'package:get/get.dart';
import 'package:jo_amman/controllers/auth/sign_in_controller.dart';
import 'package:jo_amman/controllers/app_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => OtpController());

    Get.lazyPut(() => HomeController());

    Get.lazyPut(() => AdminHomeController());
  }
}
