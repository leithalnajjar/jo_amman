import 'package:cached_network_image/cached_network_image.dart';
import 'package:jo_amman/config/constant.dart';
import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageScreen extends StatefulWidget {
  final String imageUrl;

  const ImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      appBar: AppBar(
        title: Text(
          'Image'.tr,
          style: kStyleTextTitle.copyWith(color: Colors.black),
        ),
      ),
      child: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20),
          minScale: 0.1,
          maxScale: 3.0,
          child: CachedNetworkImage(imageUrl: widget.imageUrl),
        ),
      ),
    );
  }
}
