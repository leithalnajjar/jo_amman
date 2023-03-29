import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/app_color.dart';
import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:jo_amman/models/slider_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';
import 'package:jo_amman/ui/screens/admin/sliders/admin_sliders_data_source.dart';
import 'package:uuid/uuid.dart';

class AdminSlidersController extends GetxController {
  static AdminSlidersController get to => Get.isRegistered<AdminSlidersController>() ? Get.find<AdminSlidersController>() : Get.put(AdminSlidersController());

  final TextEditingController controllerSearch = TextEditingController();

  late AdminSlidersDataSource taxisDataSource;
  final countTaxi = 0.obs;

  deleteSlider({required SliderModel model}) async {
    Utils.showLoadingDialog();
    await ReferenceFirebase.SLIDERS.doc(model.id).delete();
    taxisDataSource.setNextView();
    Utils.hideLoadingDialog();
  }

  addEditSlider() {
    SliderModel sliderModel = SliderModel(url: '', isDeleted: false);
    showBarModalBottomSheet<int>(
      backgroundColor: Colors.white,
      context: Get.context!,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text(
                        'Add Image'.tr,
                        style: kStyleTextTitle,
                      ),
                      SizedBox(height: 10.h),
                      InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(100.r)),
                        onTap: () async {
                          Utils.pickImages(allowMultiple: false).then((value) {
                            if (value.isNotEmpty) {
                              Utils.showLoadingDialog();
                              Reference ref = FirebaseStorage.instance.ref('sliders/${const Uuid().v1()}');
                              ref.putData(value.first.bytes!).whenComplete(() async {
                                var imageUrl = await ref.getDownloadURL();
                                sliderModel.url = imageUrl.toString();
                                Utils.hideLoadingDialog();
                                setState(() {});
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100.r)),
                            color: AppColor.darkGray,
                          ),
                          child: Icon(
                            FontAwesomeIcons.plus,
                            size: 60.sp,
                          ),
                        ),
                      ),
                      sliderModel.url.isEmpty
                          ? Container()
                          : CachedNetworkImage(
                              imageUrl: sliderModel.url,
                              width: 150.w,
                              fit: BoxFit.fitWidth,
                            ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    padding: const EdgeInsets.all(16),
                    child: Text('Save'.tr),
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await ReferenceFirebase.SLIDERS.add(sliderModel);
                      taxisDataSource.setNextView();
                      Get.back();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
