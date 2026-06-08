import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_booking_model.dart';
import 'package:flutter/material.dart';

class GuideNewRequestCard extends StatelessWidget {
  final GuideBookingModel booking;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const GuideNewRequestCard({
    super.key,
    required this.booking,
    this.onAccept,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final cardBorderColor =
        isDark ? const Color(0xFF2C3C4A) : const Color(0xFFD8E0E6);
    final metaColor =
        isDark ? const Color(0xFF9DB0BF) : const Color(0xFF6E7F8D);
    final declineBorderColor =
        isDark ? const Color(0xFF5B6E7D) : const Color(0xFFC7D1D9);

    final isPending = booking.status == 'PENDING';

    String statusLabel;
    Color statusColor;
    switch (booking.status) {
      case 'ACCEPTED':
        statusLabel = 'Accepted';
        statusColor = const Color(0xFF4CAF50);
      case 'REJECTED':
        statusLabel = 'Declined';
        statusColor = const Color(0xFFFF2A2A);
      default:
        statusLabel = 'New';
        statusColor = AppColor.secondaryColor;
    }

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
                backgroundImage: booking.touristPhoto != null &&
                        booking.touristPhoto!.isNotEmpty
                    ? NetworkImage(booking.touristPhoto!)
                    : null,
                backgroundColor: isDark
                    ? const Color(0xFF1C2732)
                    : const Color(0xFFE6EEF2),
                child: booking.touristPhoto == null ||
                        booking.touristPhoto!.isEmpty
                    ? Icon(Icons.person, size: 24.sp, color: AppColor.secondaryColor)
                    : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.touristName.isNotEmpty
                          ? booking.touristName
                          : booking.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    if (booking.title.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.trip_origin, size: 12.sp, color: metaColor),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              booking.title,
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
                    if (booking.startDate.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 12.8.sp,
                            color: metaColor,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              booking.startDate,
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
                    SizedBox(height: 5.h),
                    if (booking.touristCount != null && booking.touristCount! > 0)
                      Row(
                        children: [
                          Icon(
                            Icons.group_outlined,
                            size: 13.sp,
                            color: metaColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${booking.touristCount} Tourists',
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
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.6),
                    width: .8,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (isPending) ...[
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
                        backgroundColor: AppColor.secondaryColor,
                        disabledBackgroundColor: AppColor.secondaryColor,
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
        ],
      ),
    );
  }
}