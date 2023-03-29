import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  final String pdfUrl;

  const PdfScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      appBar: AppBar(
        title: Text(
          'PDF'.tr,
          style: kStyleTextTitle.copyWith(color: Colors.black),
        ),
      ),
      child: SfPdfViewer.network(widget.pdfUrl),
    );
  }
}
