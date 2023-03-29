import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/config/shared_prefs_client.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/controllers/admin/admin_home_controller.dart';
import 'package:jo_amman/ui/screens/auth/sign_in_screen.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _controller = AdminHomeController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeController>(
      builder: (controller) => CustomWidget(
        alignment: Alignment.topCenter,
        child: CustomSingleChildScrollView(
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                color: Colors.grey.shade200,
                elevation: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5.r),
                  onTap: () {
                    // Get.to(() => const ScientificJournalsScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.newspaper,
                          size: 50.sp,
                        ),
                        Text(
                          'Journals'.tr,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: kStyleTextTitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                color: Colors.grey.shade200,
                elevation: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5.r),
                  onTap: () async{
                    var result = await Utils.showAreYouSureDialog(title: 'Sign Out'.tr);
                    if(result){
                      sharedPrefsClient.clearProfile();
                      Get.offAll(() => const SignInScreen());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          size: 50.sp,
                        ),
                        Text(
                          'Sign Out'.tr,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: kStyleTextTitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
