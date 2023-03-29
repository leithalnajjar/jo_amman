import 'package:jo_amman/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonIcon extends StatelessWidget {
  Widget label;
  Widget icon;
  Color? color;
  Color? backgroundColor;
  EdgeInsetsGeometry? padding;
  void Function()? onPressed;
  void Function()? onLongPress;
  EdgeInsetsGeometry? margin;
  double? width;
  bool? fixed;
  BorderSide? side;
  double? borderRadius;

  CustomButtonIcon({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.width,
    this.fixed = false,
    this.onPressed,
    this.side,
    this.onLongPress,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 8.h),
      width: fixed! ? width : double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          onPrimary: color ?? AppColor.primaryColor,
          primary: backgroundColor ?? Colors.transparent,
          backgroundColor: backgroundColor ?? Colors.transparent,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
            side: side ?? BorderSide(color: color ?? AppColor.primaryColor),
          ),
          elevation: 0.0,
          shadowColor: Colors.transparent,
          textStyle: TextStyle(fontSize: 18.sp, color: AppColor.primaryColor),
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
        icon: icon,
        label: label,
      ),
    );
  }
}
