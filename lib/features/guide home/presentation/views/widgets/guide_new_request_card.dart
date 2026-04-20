import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideNewRequestCard extends StatelessWidget {
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const GuideNewRequestCard({super.key, this.onAccept, this.onDecline});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final acceptButtonColor = AppColor.secondaryColor;
    final cardBorderColor =
        isDark ? const Color(0xFF2C3C4A) : const Color(0xFFD8E0E6);
    final metaColor =
        isDark ? const Color(0xFF9DB0BF) : const Color(0xFF6E7F8D);
    final declineBorderColor =
        isDark ? const Color(0xFF5B6E7D) : const Color(0xFFC7D1D9);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: cardBg,
        border: Border.all(color: cardBorderColor, width: .9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundImage: const AssetImage('assets/images/7th.jpg'),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Michael Brown',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.settings, size: 12.8.sp, color: metaColor),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            'Culture/Food',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w600,
                              color: metaColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 12.8.sp,
                                color: metaColor,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  'Wen 09 Feb ,2026',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: metaColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.alarm, size: 12.8.sp, color: metaColor),
                        SizedBox(width: 4.w),
                        Text(
                          '8:00 Pm',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: metaColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Icon(
                          Icons.group_outlined,
                          size: 13.sp,
                          color: metaColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '3 Tourists',
                          style: TextStyle(fontSize: 11.5.sp, color: metaColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F1720) : Colors.white,
                  border: Border.all(color: const Color(0xFF9CCFDB), width: .8),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  'New',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColor.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              SizedBox(width: 60.w),
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: ElevatedButton(
                    onPressed: onAccept ?? () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: acceptButtonColor,
                      disabledBackgroundColor: acceptButtonColor,
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Text(
                      'Accept',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: OutlinedButton(
                    onPressed: onDecline ?? () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: declineBorderColor, width: 1),
                      foregroundColor: metaColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Text(
                      'Decline',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
