import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.controller,
    this.isPassword = false,
    this.hintText,
    this.isPhone = false,
    this.suffixIcon,
    this.enabled = true,
  });

  final bool isPhone;
  final bool enabled;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  final bool isPassword;
  final String? hintText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    if (!widget.isPassword) {
      _obscureText = false;
    }
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fieldBg = isDark ? const Color(0xFF19232D) : Colors.white;
    final textColor = isDark ? Colors.white : AppColor.primaryColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow:
            _isFocused
                ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : [],
      ),
      child: TextFormField(
        focusNode: _focusNode,
        cursorColor: AppColor.secondaryColor,
        controller: widget.controller,
        style: TextStyle(color: textColor),
        obscureText: _obscureText,
        enabled: widget.enabled,
        keyboardType: widget.isPhone ? TextInputType.phone : TextInputType.text,
        inputFormatters:
            widget.isPhone
                ? [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  LengthLimitingTextInputFormatter(13),
                ]
                : [],
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'field_required'.tr(
              namedArgs: {'field': widget.hintText ?? ''},
            );
          }
          if (widget.isPhone) {
            final withoutCode = value.trim().replaceFirst('+20', '');
            if (withoutCode.isEmpty) {
              return 'phone_enter_number'.tr();
            }
            if (withoutCode.startsWith('0')) {
              return 'phone_remove_leading_zero'.tr();
            }
            if (withoutCode.length != 10) {
              return 'phone_valid_digits'.tr();
            }
            if (!RegExp(r'^[0-9]+$').hasMatch(withoutCode)) {
              return 'phone_numbers_only'.tr();
            }
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: fieldBg,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFF8FA0AE) : null,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.secondaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                  : widget.suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 9.h),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.r)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }
}
