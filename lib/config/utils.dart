import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:jo_amman/config/app_color.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';

class Utils {
  static double height = Get.height - MediaQuery.of(Get.context!).padding.top - MediaQuery.of(Get.context!).padding.bottom;
  static double width = Get.width;

  static bool isNotEmpty(String? s) => s != null && s.isNotEmpty;

  static bool isEmpty(String? s) => s == null || s.isEmpty;

  static showLoadingDialog([String? text]) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    if (!Get.isDialogOpen!) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async => true,
          child: CustomLoadingDialog(
            title: text ?? 'Loading ...',
          ),
        ),
        barrierDismissible: false,
        useSafeArea: false,
      );
    }
  }

  static showSnackbar(String title, String message) {
    hideLoadingDialog();
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 4),
      backgroundColor: AppColor.gray.withOpacity(0.5),
      margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
    );
  }

  static void hideLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static Future<bool> showAreYouSureDialog({required String title}) async {
    var result = await Get.defaultDialog(
      title: title,
      content: Text('Are you sure?'.tr),
      textCancel: 'Cancel'.tr,
      textConfirm: 'Confirm'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(result: true);
      },
      barrierDismissible: true,
    );
    return result ?? false;
  }

  static Future<bool> checkGPS() async {
    bool serviceEnabled;
    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
      if (serviceEnabled) {
        await Future.delayed(const Duration(milliseconds: 200));
        return checkGPS();
      } else {
        return false;
      }
    } else {
      geolocator.LocationPermission permission;
      permission = await geolocator.Geolocator.checkPermission();
      if (permission == geolocator.LocationPermission.denied) {
        permission = await geolocator.Geolocator.requestPermission();
        if (permission == geolocator.LocationPermission.always || permission == geolocator.LocationPermission.whileInUse) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    }
  }

  static Future<List<PlatformFile>> pickImages({bool allowMultiple = true, FileType type = FileType.image, List<String>? allowedExtensions}) async {
    try {
      var pickFiles = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        type: type,
        allowedExtensions: allowedExtensions,
        withData: true,
        onFileLoading: (FilePickerStatus status) => log(status.toString()),
      );
      return pickFiles?.files ?? [];
    } on PlatformException catch (e) {
      log('Unsupported operation $e');
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
