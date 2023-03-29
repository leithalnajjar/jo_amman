import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_amman/controllers/admin/admin_sliders_controller.dart';
import 'package:jo_amman/ui/screens/admin/sliders/admin_sliders_data_source.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';

class AdminSlidersScreen extends StatefulWidget {
  const AdminSlidersScreen({Key? key}) : super(key: key);

  @override
  State<AdminSlidersScreen> createState() => _AdminSlidersScreenState();
}

class _AdminSlidersScreenState extends State<AdminSlidersScreen> {
  final _controller = AdminSlidersController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.slidersDataSource = AdminSlidersDataSource(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminSlidersController>(
      builder: (controller) => CustomWidget(
        alignment: Alignment.topCenter,
        appBar: AppBar(
          title: Text('Sliders'.tr),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _controller.addEditSlider();
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _controller.slidersDataSource.setNextView();
              },
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(Get.context!).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: Get.width),
              child: CustomDataTableAdvanced(
                source: _controller.slidersDataSource,
                columns: [
                  DataColumn(
                    label: Text('Image'.tr),
                  ),
                  DataColumn(
                    label: Text('Actions'.tr),
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
