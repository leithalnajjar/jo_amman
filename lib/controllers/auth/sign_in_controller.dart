import 'package:jo_amman/config/enum/otp_type_enum.dart';
import 'package:jo_amman/ui/screens/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.isRegistered<SignInController>() ? Get.find<SignInController>() : Get.put(SignInController());

  final keyForm = GlobalKey<FormState>();
  final controllerPhoneNumber = TextEditingController();
  final phoneNumber = ''.obs;


  signIn() async {
    if (keyForm.currentState!.validate()) {
      Get.to(() => OtpScreen(phoneNumber: phoneNumber.value, type: OtpTypeEnum.signIn));
    }
  }
}
