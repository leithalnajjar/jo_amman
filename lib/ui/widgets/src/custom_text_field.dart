import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final String? hintText;
  final String? helperText;
  final Widget? icon;
  final bool enabled;
  final bool readOnly;
  final Widget? label;
  final bool enableInteractiveSelection;
  bool obscureText;
  final bool isPass;
  final TextDirection? textDirection;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? onSaved;
  final String? Function(String? value)? onFieldSubmitted;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final double? borderRaduis;
  final double? borderWidth;
  final String? initialValue;
  final Widget? suffixIcon;

  CustomTextField({
    super.key,
    this.controller,
    this.suffixIcon,
    this.focusNode,
    this.borderRaduis,
    this.borderWidth,
    this.textColor,
    this.fillColor,
    this.keyboardType,
    this.maxLines,
    this.label,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.icon,
    this.hintText,
    this.helperText,
    this.contentPadding,
    this.enabled = true,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.obscureText = false,
    this.isPass = false,
    this.textDirection,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTap,
    this.margin,
    this.padding,
    this.inputFormatters,
    this.initialValue,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 8.h),
      padding: widget.padding,
      child: TextFormField(
        initialValue: widget.initialValue,
        // style: Theme.of(context).textTheme.bodyText2!.copyWith(color: widget.textColor),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign,

        // style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          fillColor: widget.fillColor ?? Colors.transparent,
          filled: true,
          hintText: widget.hintText,
          label: widget.label,
          helperText: widget.helperText,
          contentPadding: widget.contentPadding ?? (widget.icon != null ? EdgeInsets.zero : EdgeInsetsDirectional.only(start: 8.w, end: 20.w)),
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: widget.textColor),
          prefixIcon:  widget.icon,
          suffixIcon: widget.suffixIcon ??
              (widget.isPass
                  ? InkWell(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Icon(
                        _visiblePassword ? Icons.visibility : Icons.visibility_off,
                        size: 14.sp,
                      ),
                      onTap: () {
                        setState(() {
                          _visiblePassword = !_visiblePassword;
                          widget.obscureText = !widget.obscureText;
                        });
                      },
                    )
                  : null),
          counterStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
          errorMaxLines: 3,
        ),
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        focusNode: widget.focusNode ?? (widget.enableInteractiveSelection ? null : AlwaysDisabledFocusNode()),
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText,
        textDirection: widget.textDirection,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTap: widget.onTap,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
