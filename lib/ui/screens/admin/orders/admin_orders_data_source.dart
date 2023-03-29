import 'dart:developer';

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:jo_amman/config/enum/order_status_enum.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/controllers/admin/admin_orders_controller.dart';
import 'package:jo_amman/models/order_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';

class AdminOrdersDataSource extends AdvancedDataTableSource<DocumentSnapshot<OrderModel>> {
  final AdminOrdersController _controller;

  AdminOrdersDataSource(this._controller);

  int selectedIndex = -1;
  var paginationList = [];

  @override
  int get selectedRowCount => selectedIndex == -1 ? 0 : 1;

  @override
  Future<RemoteDataSourceDetails<DocumentSnapshot<OrderModel>>> getNextPage(NextPageRequest pageRequest) async {
    var paginationIndex = paginationList.indexWhere((element) => element['offset'] == pageRequest.offset);
    if (paginationIndex == -1 && lastDetails != null) {
      paginationList.add({
        'offset': pageRequest.offset,
        'startAt': lastDetails!.rows.last,
      });
    } else if (paginationIndex == -1 && pageRequest.offset == 0) {
      paginationList.add({
        'offset': pageRequest.offset,
        'startAt': null,
      });
    }
    List<dynamic> result = await Future.wait([
      ReferenceFirebase.GET_COUNT_ORDERS(search: _controller.controllerSearch.text).get(),
      ReferenceFirebase.GET_ORDERS_PAGINATION(search: _controller.controllerSearch.text, limit: pageRequest.pageSize, startAt: paginationList.firstWhereOrNull((element) => element['offset'] == pageRequest.offset)['startAt']).get(),
    ]);
    return RemoteDataSourceDetails(
      result[0].count,
      result[1].docs,
    );
  }

  @override
  DataRow? getRow(int index) {
    return lastDetails == null
        ? null
        : DataRow(
            cells: [
              DataCell(
                Text(
                  lastDetails!.rows[index].data()!.phoneNumber,
                  textDirection: TextDirection.ltr,
                ),
              ),
              DataCell(
                Text(lastDetails!.rows[index].data()!.status.name.tr),
              ),
              DataCell(
                Text(lastDetails!.rows[index].data()!.quantity.toStringAsFixed(3)),
              ),
              DataCell(
                Text(lastDetails!.rows[index].data()!.price.toStringAsFixed(3)),
              ),
              DataCell(
                Text(lastDetails!.rows[index].data()!.totalPrice.toStringAsFixed(3)),
              ),
              DataCell(
                Text(lastDetails!.rows[index].data()!.date == null ? '' : intl.DateFormat('dd/MM/yyyy').format(lastDetails!.rows[index].data()!.date!)),
              ),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: lastDetails!.rows[index].data()!.status == OrderStatusEnum.finished
                          ? null
                          : () async {
                              var result = await Utils.showAreYouSureDialog(title: 'Finish'.tr);
                              if (result) {
                                _controller.finishOrder(model: lastDetails!.rows[index].data()!);
                              }
                            },
                      icon: const Icon(FontAwesomeIcons.check),
                      splashRadius: 22,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
