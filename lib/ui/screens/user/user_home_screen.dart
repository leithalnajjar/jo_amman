import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jo_amman/config/app_color.dart';
import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/controllers/app_controller.dart';
import 'package:jo_amman/controllers/user/user_home_controller.dart';
import 'package:jo_amman/ui/screens/user/user_order_screen.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final _controller = UserHomeController.to;
  final _controllerApp = AppController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getSliders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      child: GetBuilder<UserHomeController>(
        builder: (controller) => CustomSingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Container(
            height: Utils.height,
            width: Utils.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 180.h),
                AspectRatio(
                  aspectRatio: 2.5,
                  child: CarouselSlider(
                    items: _controller.sliders
                        .map((item) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(item),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        _controller.currentSlider.value = index;
                        _controller.update();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (_controller.sliders.isNotEmpty)
                  DotsIndicator(
                    dotsCount: _controller.sliders.length,
                    position: _controller.currentSlider.value.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: Colors.amber,
                      color: Colors.blueAccent.withOpacity(0.5),
                      size: Size.square(9.0.sp),
                      activeSize: Size(18.w, 9.h),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0.r)),
                    ),
                  ),
                SizedBox(height: 60.h),
                CustomButton(
                  margin: EdgeInsets.all(16.sp),
                  backgroundColor: AppColor.red,
                  child: Text(
                    'الكمية',
                    style: kStyleTextTitle,
                  ),
                  onPressed: () {
                    Get.to(() => const UserOrderScreen());
                  },
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await launch('tel:${_controllerApp.config.value.phone}');
                      },
                      icon: const Icon(Icons.phone),
                      iconSize: 40.sp,
                    ),
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          "رنيت الديزل صار بالبيت",
                          style: kStyleTextTitle.copyWith(fontWeight: FontWeight.w100, color: const Color(0xff377C0F)),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await launch('https://api.whatsapp.com/send?phone=${_controllerApp.config.value.phone}');
                      },
                      icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                      iconSize: 40.sp,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
