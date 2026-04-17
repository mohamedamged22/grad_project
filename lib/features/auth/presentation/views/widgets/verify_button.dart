import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  final bool enabled;
  final Function()? onTap;
  const VerifyButton({super.key, this.enabled = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: SizedBox(
          width: 260.w,
          height: 50.h,
          child: GestureDetector(
            onTap: enabled ? () {} : null,
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: enabled ? AppColor.primaryColor : AppColor.grey,
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Center(
                child: Text(
                  'verify'.tr(),
                  style: TextStyle(
                    color: enabled ? Colors.white : AppColor.primaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
