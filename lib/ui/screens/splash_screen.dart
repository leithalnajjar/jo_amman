import 'package:jo_amman/config/enum/user_role_enum.dart';
import 'package:jo_amman/config/shared_prefs_client.dart';
import 'package:jo_amman/ui/screens/admin/admin_home_screen.dart';
import 'package:jo_amman/ui/screens/user/user_home_screen.dart';
import 'package:jo_amman/ui/screens/auth/sign_in_screen.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:jo_amman/controllers/app_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppController _controllerApp = AppController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      sharedPrefsClient.clearProfile();
      if (sharedPrefsClient.isLogin) {
        if (sharedPrefsClient.userRole == UserRoleEnum.user) {
          Get.offAll(() => const UserHomeScreen());
        } else if (sharedPrefsClient.userRole == UserRoleEnum.admin) {
          Get.offAll(() => const AdminHomeScreen());
        }
      } else {
        Get.offAll(() => const SignInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      child: Image.asset(
        "assets/images/splash.png",
        height: Get.height,
        width: Get.width,
        fit: BoxFit.fill,
      ),
    );
  }
}
