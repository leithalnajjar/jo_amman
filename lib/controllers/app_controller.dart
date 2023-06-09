import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/config/shared_prefs_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/models/config_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  static AppController get to => Get.isRegistered<AppController>() ? Get.find<AppController>() : Get.put(AppController());

  final config = ConfigModel.fromJson({}).obs;

  getConfig() async {
    Utils.showLoadingDialog();
    var result = await ReferenceFirebase.GET_CONFIG().get();
    config.value = result.docs.first.data();
    update();
    Utils.hideLoadingDialog();
  }

  init() {
    /// Version
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
    });

    ///Platform
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (sharedPrefsClient.isGMS) {
        platform = "android";
      } else {
        platform = "huawei";
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      platform = "ios";
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      platform = "windows";
    } else if (defaultTargetPlatform == TargetPlatform.fuchsia) {
      platform = "fuchsia";
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      platform = "macos";
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      platform = "linux";
    } else {
      platform = "web";
    }

    /// Language
    sharedPrefsClient.language = 'ar';
    // if (sharedPrefsClient.language == "") {
    //   if (Get.deviceLocale == null) {
    //     sharedPrefsClient.language = 'ar';
    //   } else {
    //     String language = Get.deviceLocale!.languageCode;
    //     if (language != 'en' && language != 'ar') {
    //       sharedPrefsClient.language = 'ar';
    //     } else {
    //       sharedPrefsClient.language = language;
    //     }
    //   }
    // }
  }
}
