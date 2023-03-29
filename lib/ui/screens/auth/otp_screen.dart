import 'package:jo_amman/config/app_color.dart';
import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/config/enum/otp_type_enum.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/controllers/auth/otp_controller.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final OtpTypeEnum type;

  const OtpScreen({Key? key, required this.phoneNumber, required this.type}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controller = OtpController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.sendOTP(widget.phoneNumber);
  }

  @override
  void dispose() {
    if (_controller.timer != null) {
      _controller.timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      child: GetBuilder<OtpController>(
        builder: (controller) => Stack(
          children: [
            CustomSingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                height: Utils.height,
                width: Utils.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Form(
                  key: _controller.keyForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        "Enter your OTP code number".tr,
                        style: kStyleTextSubTitle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          controller: _controller.controllerOtp,
                          length: 6,
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                            decoration: BoxDecoration(
                              color: AppColor.gray2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (Utils.isEmpty(value) || value!.length < 6) {
                              return 'Please enter your OTP code number'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                        child: Text('Verify'.tr),
                        onPressed: () async {
                          _controller.verifyCode(phoneNumber: widget.phoneNumber, credential: PhoneAuthProvider.credential(verificationId: _controller.verificationId.value, smsCode: _controller.controllerOtp.text));
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Didn't you receive any code ?".tr,
                        style: kStyleTextDefault.copyWith(color: Colors.black38),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      TextButton(
                        onPressed: _controller.start.value != 61
                            ? null
                            : () {
                                _controller.startTimer();
                                _controller.sendOTP(widget.phoneNumber);
                                _controller.controllerOtp.text = '';
                              },
                        child: Text(
                          "Resend new code".tr,
                          style: kStyleTextDefault,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (_controller.start.value != 61)
                        Text(
                          '${_controller.start.value} ${'sec'.tr}',
                          style: kStyleTextDefault,
                        ),
                    ],
                  ),
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
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
