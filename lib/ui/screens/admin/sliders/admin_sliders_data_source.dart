import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/utils.dart';
import 'package:jo_amman/controllers/admin/admin_sliders_controller.dart';
import 'package:jo_amman/models/slider_model.dart';
import 'package:jo_amman/networks/reference_firebase.dart';
import 'package:jo_amman/ui/screens/image_screen.dart';

class AdminSlidersDataSource extends AdvancedDataTableSource<DocumentSnapshot<SliderModel>> {
  final AdminSlidersController _controller;

  AdminSlidersDataSource(this._controller);

  int selectedIndex = -1;
  var paginationList = [];

  @override
  int get selectedRowCount => selectedIndex == -1 ? 0 : 1;

  @override
  Future<RemoteDataSourceDetails<DocumentSnapshot<SliderModel>>> getNextPage(NextPageRequest pageRequest) async {
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
      ReferenceFirebase.GET_COUNT_SLIDERS().get(),
      ReferenceFirebase.GET_SLIDERS_PAGINATION(limit: pageRequest.pageSize, startAt: paginationList.firstWhereOrNull((element) => element['offset'] == pageRequest.offset)['startAt']).get(),
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
                Text(lastDetails!.rows[index].data()!.url.split('/').last.split('?').first),
              ),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: lastDetails!.rows[index].data()!.url.isEmpty
                          ? null
                          : () {
                              Get.to(() => ImageScreen(imageUrl: lastDetails!.rows[index].data()!.url));
                            },
                      icon: const Icon(FontAwesomeIcons.image),
                      splashRadius: 22,
                    ),
                    IconButton(
                      onPressed: () async {
                        var result = await Utils.showAreYouSureDialog(title: 'Delete'.tr);
                        if (result) {
                          _controller.deleteSlider(model: lastDetails!.rows[index].data()!);
                        }
                      },
                      icon: const Icon(FontAwesomeIcons.trash),
                      splashRadius: 22,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
