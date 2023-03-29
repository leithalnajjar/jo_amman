import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/config/shared_prefs_client.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/config/validation.dart';
import 'package:jo_amman/controllers/auth/sign_in_controller.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _controller = SignInController.to;

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      child: CustomSingleChildScrollView(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            child: Form(
              key: _controller.keyForm,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InternationalPhoneNumberInput(
                    onInputChanged: (number) {
                      _controller.phoneNumber.value = number.phoneNumber!;
                    },
                    onInputValidated: (bool value) {},
                    errorMessage: 'Invalid phone number'.tr,
                    hintText: 'Phone Number'.tr,
                    labelText: 'Phone Number'.tr,
                    keyboardType: TextInputType.phone,
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                      showFlags: false,
                    ),
                    locale: sharedPrefsClient.language,
                    ignoreBlank: false,
                    enableOTP: false,
                    isEnabled: true,
                    autoValidateMode: AutovalidateMode.disabled,
                    // selectorTextStyle: const TextStyle(color: Colors.black),
                    textFieldController: _controller.controllerPhoneNumber,
                  ),
                  SizedBox(height: 5.h),
                  CustomButton(
                    child: Text('Sign In'.tr),
                    onPressed: () {
                      _controller.signIn();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
