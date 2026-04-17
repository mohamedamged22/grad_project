import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPPicker extends StatelessWidget {
  const OTPPicker({
    super.key,
    this.enabled = true,
    required this.controller,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.hasError = false, // ⭐ جديد
  });

  final bool enabled;
  final TextEditingController controller;
  final void Function(String value)? onCompleted;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final bool hasError; // ⭐ جديد

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        key: key,
        length: 4,
        enabled: enabled,
        controller: controller,
        forceErrorState: hasError, // ⭐ جديد
        closeKeyboardWhenCompleted: true,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        showCursor: false,
        onCompleted: onCompleted,
        defaultPinTheme: PinTheme(
          constraints: BoxConstraints.expand(height: 50.h, width: 50.w),
          textStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: const Color(0xffD3D3D3)),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        focusedPinTheme: PinTheme(
          constraints: BoxConstraints.expand(height: 50.h, width: 50.w),
          textStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        disabledPinTheme: PinTheme(
          constraints: BoxConstraints.expand(height: 50.h, width: 50.w),
          textStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        errorPinTheme: PinTheme(
          constraints: BoxConstraints.expand(height: 50.h, width: 50.w),
          textStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.red, width: 2),
          ),
        ),
        hapticFeedbackType: HapticFeedbackType.mediumImpact,
        onChanged:
            onChanged ??
            (value) => otpOnChanged(value: value, otpController: controller),
        pinAnimationType: PinAnimationType.scale,
        validator:
            validator ??
            (value) {
              return otpValidator(context, value);
            },
      ),
    );
  }
}

void otpOnChanged({
  required String value,
  required TextEditingController otpController,
}) {
  if (RegExp(r'^[0-9]*$').hasMatch(value) == false) {
    otpController.text = value.replaceAll(RegExp(r'[^0-9]'), '');
    otpController.selection = TextSelection.fromPosition(
      TextPosition(offset: otpController.selection.baseOffset),
    );
  }
  if (value.length > 4) {
    otpController.text = value.substring(0, 4); // ⭐ كان 6، عدلته لـ 4
    otpController.selection = TextSelection.fromPosition(
      TextPosition(offset: otpController.selection.baseOffset),
    );
  }
}

String? otpValidator(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return 'Required';
  }
  if (!RegExp(r'^[0-9]*$').hasMatch(value.trim())) {
    return "OTP must contain digits only";
  }
  if (value.length < 4) {
    return "Please enter a valid OTP";
  }
  return null;
}
