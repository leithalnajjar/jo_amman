import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/config/text_input_formatters.dart';
import 'package:jo_amman/config/validation.dart';
import 'package:jo_amman/controllers/admin/admin_config_controller.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';

class AdminConfigScreen extends StatefulWidget {
  const AdminConfigScreen({Key? key}) : super(key: key);

  @override
  State<AdminConfigScreen> createState() => _AdminConfigScreenState();
}

class _AdminConfigScreenState extends State<AdminConfigScreen> {
  final _controller = AdminConfigController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _controller.getConfig();
      _controller.controllerPhone.text = _controller.config.value.phone;
      _controller.controllerPrice.text = _controller.config.value.price.toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      alignment: Alignment.topCenter,
      appBar: AppBar(
        title: Text(
          'Config'.tr,
          style: kStyleTextTitle.copyWith(color: Colors.black),
        ),
      ),
      child: GetBuilder<AdminConfigController>(
        builder: (controller) => CustomSingleChildScrollView(
          child: Form(
            key: _controller.keyForm,
            child: Column(
              children: [
                SizedBox(height: 5.h),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomTextField(
                    label: Text("Phone".tr),
                    controller: _controller.controllerPhone,
                    validator: (value) => Validation.isRequired(value),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomTextField(
                    label: Text("Price".tr),
                    controller: _controller.controllerPrice,
                    maxLines: 1,
                    inputFormatters: [
                      EnglishDigitsTextInputFormatter(decimal: true),
                    ],
                    keyboardType: const TextInputType.numberWithOptions(),
                    validator: (value) => Validation.isRequired(value),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  child: Text('Submit'.tr),
                  onPressed: () {
                    _controller.changeConfig();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
