import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jo_amman/config/app_color.dart';
import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/controllers/app_controller.dart';
import 'package:jo_amman/controllers/user/user_order_controller.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({Key? key}) : super(key: key);

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  final _controller = UserOrderController.to;
  final _controllerApp = AppController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _controllerApp.getConfig();
      _controller.calculateTotalPrice(price: _controllerApp.config.value.price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      child: GetBuilder<AppController>(
        builder: (controller) => GetBuilder<UserOrderController>(
          builder: (controller) => Stack(
            children: [
              CustomSingleChildScrollView(
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
                      Text(
                        'كم تحتاج من اللترات',
                        style: kStyleTextTitle,
                      ),
                      Text(
                        _controller.quantity.value.toStringAsFixed(0),
                        style: TextStyle(fontSize: 30.sp),
                      ),
                      Slider(
                        min: 200,
                        max: 10000,
                        value: _controller.quantity.value,
                        onChanged: (newValue) {
                          _controller.quantity.value = newValue;
                          _controller.calculateTotalPrice(price: _controllerApp.config.value.price);
                        },

                        // autofocus: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: FloatingActionButton(
                              heroTag: 'remove',
                              onPressed: () {
                                _controller.quantity.value = _controller.quantity.value - 50;
                                if (_controller.quantity.value <= 200) {
                                  _controller.quantity.value = 200;
                                }
                                _controller.calculateTotalPrice(price: _controllerApp.config.value.price);
                              },
                              child: const Icon(Icons.remove),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: FloatingActionButton(
                              heroTag: 'add',
                              onPressed: () {
                                _controller.quantity.value = _controller.quantity.value + 50;
                                if (_controller.quantity.value >= 10000) {
                                  _controller.quantity.value = 10000;
                                }
                                _controller.calculateTotalPrice(price: _controllerApp.config.value.price);
                              },
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'سعر الديزل : ${_controllerApp.config.value.price.toStringAsFixed(3)}',
                        style: kStyleTextTitle,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "السعر : ${_controller.totalPrice.value.toStringAsFixed(3)}",
                        style: kStyleTextTitle,
                      ),
                      CustomButton(
                        margin: EdgeInsets.all(16.sp),
                        backgroundColor: AppColor.red,
                        child: Text(
                          'الحساب',
                          style: kStyleTextTitle,
                        ),
                        onPressed: () {
                          _controller.createOrder(price: _controllerApp.config.value.price);
                        },
                      ),
                      SizedBox(height: 10.h),
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
              Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
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
