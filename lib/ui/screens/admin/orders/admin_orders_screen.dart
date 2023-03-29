import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jo_amman/controllers/admin/admin_orders_controller.dart';
import 'package:jo_amman/ui/screens/admin/orders/admin_orders_data_source.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final _controller = AdminOrdersController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.ordersDataSource = AdminOrdersDataSource(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminOrdersController>(
      builder: (controller) => CustomWidget(
        alignment: Alignment.topCenter,
        appBar: AppBar(
          title: Text('Orders'.tr),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _controller.ordersDataSource.setNextView();
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
                source: _controller.ordersDataSource,
                header: CustomSearchFeild(
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  controller: _controller.controllerSearch,
                  onChanged: (value) async {
                    _controller.ordersDataSource.setNextView();
                  },
                ),
                columns: [
                  DataColumn(
                    label: Text('Phone Number'.tr),
                  ),
                  DataColumn(
                    label: Text('Status'.tr),
                  ),
                  DataColumn(
                    label: Text('Quantity'.tr),
                  ),
                  DataColumn(
                    label: Text('Price'.tr),
                  ),
                  DataColumn(
                    label: Text('Total Price'.tr),
                  ),
                  DataColumn(
                    label: Text('Date'.tr),
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
