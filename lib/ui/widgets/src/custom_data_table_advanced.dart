import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/app_color.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';

typedef SelectedCallBack = Function(String id, bool newSelectState);

class CustomDataTableAdvanced extends StatefulWidget {
  int rowsPerPage;
  Widget? header;
  AdvancedDataTableSource<dynamic> source;
  List<DataColumn> columns;
  List<Widget>? actions;

  CustomDataTableAdvanced({
    super.key,
    this.header,
    required this.source,
    required this.columns,
    this.actions,
    this.rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage,
  });

  @override
  State<CustomDataTableAdvanced> createState() => _CustomDataTableAdvancedState();
}

class _CustomDataTableAdvancedState extends State<CustomDataTableAdvanced> {
  @override
  Widget build(BuildContext context) {
    return AdvancedPaginatedDataTable(
      addEmptyRows: false,
      header: widget.header,
      source: widget.source,
      showHorizontalScrollbarAlways: true,
      showFirstLastButtons: false,
      rowsPerPage: widget.rowsPerPage,
      actions: widget.actions,
      availableRowsPerPage: const [10, 20, 30, 50],
      onRowsPerPageChanged: (newRowsPerPage) {
        if (newRowsPerPage != null) {
          setState(() {
            widget.rowsPerPage = newRowsPerPage;
          });
        }
      },

      columns: widget.columns,
      getFooterRowText: (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
        final localizations = MaterialLocalizations.of(context);
        var amountText = localizations.pageRowsInfoTitle(
          startRow,
          pageSize,
          totalFilter ?? totalRowsWithoutFilter,
          false,
        );

        if (totalFilter != null) {
          //Filtered data source show addtional information
          amountText += ' filtered from ($totalRowsWithoutFilter)';
        }

        return amountText;
      },
    );
  }
}

