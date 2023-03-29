import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jo_amman/config/enum/user_role_enum.dart';
import 'package:jo_amman/config/shared_prefs_client.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_amman/models/user_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';
import 'package:jo_amman/ui/screens/admin/admin_home_screen.dart';
import 'package:jo_amman/ui/screens/user/user_home_screen.dart';

class OtpController extends GetxController {
  static OtpController get to => Get.isRegistered<OtpController>() ? Get.find<OtpController>() : Get.put(OtpController());

  final keyForm = GlobalKey<FormState>();
  final controllerOtp = TextEditingController();
  final verificationId = ''.obs;
  final start = 61.obs;
  Timer? timer;

  Future<void> sendOTP(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        log('SendOTP - verificationCompleted');
        verifyCode(phoneNumber: phoneNumber, credential: credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('SendOTP - verificationFailed');
        Utils.showSnackbar('Please try again'.tr, '${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        log('SendOTP - codeSent');
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('SendOTP - codeAutoRetrievalTimeout');
        this.verificationId.value = verificationId;
      },
    );
  }

  verifyCode({required String phoneNumber, required AuthCredential credential}) async {
    if (keyForm.currentState!.validate()) {
      try {
        Utils.showLoadingDialog();
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
            log('user logged in');
            var result = await ReferenceFirebase.GET_USERS(phoneNumber).get();
            if (result.docs.isEmpty) {
              var resultAdd = await ReferenceFirebase.USERS.add(UserModel(phoneNumber: phoneNumber, role: UserRoleEnum.user, isDeleted: false));
              sharedPrefsClient.id = resultAdd.id;
              sharedPrefsClient.phoneNumber = phoneNumber;
              sharedPrefsClient.isLogin = true;
              sharedPrefsClient.userRole = UserRoleEnum.user;
              Get.offAll(() => const UserHomeScreen());
            } else {
              sharedPrefsClient.id = result.docs.first.data().id;
              sharedPrefsClient.phoneNumber = phoneNumber;
              sharedPrefsClient.isLogin = true;
              sharedPrefsClient.userRole = result.docs.first.data().role;
              if (result.docs.first.data().role == UserRoleEnum.user) {
                Get.offAll(() => const UserHomeScreen());
              } else if (result.docs.first.data().role == UserRoleEnum.admin) {
                Get.offAll(() => const AdminHomeScreen());
              }
            }
          } else {
            Utils.showSnackbar('Please try again'.tr, '');
          }
        });
      } catch (e) {
        Utils.showSnackbar('Please try again'.tr, 'Invalid verification code'.tr);
      }
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          start.value = 61;
        } else {
          start.value--;
        }
        update();
      },
    );
  }
}
