import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_booking_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TouristHistoryCard extends StatelessWidget {
  final GuideBookingModel booking;

  const TouristHistoryCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final cardBorderColor =
        isDark ? const Color(0xFF2C3C4A) : const Color(0xFFD8E0E6);
    final metaColor =
        isDark ? const Color(0xFF9DB0BF) : const Color(0xFF6E7F8D);

    String statusLabel;
    Color statusColor;
    switch (booking.status) {
      case 'ACCEPTED':
        statusLabel = 'trip_status_accepted'.tr();
        statusColor = const Color(0xFF4CAF50);
      case 'REJECTED':
        statusLabel = 'trip_status_rejected'.tr();
        statusColor = const Color(0xFFFF2A2A);
      default:
        statusLabel = 'trip_status_pending'.tr();
        statusColor = const Color(0xFFF39A2C);
    }

    // Determine display name: guide name or title
    final displayName =
        booking.guideName.isNotEmpty
            ? booking.guideName
            : booking.title.isNotEmpty
            ? booking.title
            : 'tourist_trip_history_empty'.tr();

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
                radius: 28.r,
                backgroundImage:
                    booking.guidePhoto != null && booking.guidePhoto!.isNotEmpty
                        ? NetworkImage(booking.guidePhoto!)
                        : null,
                backgroundColor:
                    isDark ? const Color(0xFF1C2732) : const Color(0xFFE6EEF2),
                child:
                    booking.guidePhoto == null || booking.guidePhoto!.isEmpty
                        ? Icon(
                          Icons.person,
                          size: 22.sp,
                          color: AppColor.secondaryColor,
                        )
                        : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Guide name
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Request time
                    if (booking.formattedCreatedAt.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 12.sp,
                            color: metaColor,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              booking.formattedCreatedAt,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w500,
                                color: metaColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 4.h),
                    // Trip title (if different from guide name)
                    if (booking.title.isNotEmpty &&
                        booking.guideName.isNotEmpty &&
                        booking.title != booking.guideName)
                      Row(
                        children: [
                          Icon(
                            Icons.trip_origin,
                            size: 11.sp,
                            color: metaColor,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              booking.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: metaColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 4.h),
                    // Date
                    if (booking.startDate.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 12.sp,
                            color: metaColor,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              _formatDateRange(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w500,
                                color: metaColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 4.h),
                    // Tourists count
                    if (booking.touristCount != null &&
                        booking.touristCount! > 0)
                      Row(
                        children: [
                          Icon(
                            Icons.group_outlined,
                            size: 12.sp,
                            color: metaColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${booking.touristCount} ${'tourists'.tr()}',
                            style: TextStyle(
                              fontSize: 10.5.sp,
                              color: metaColor,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 4.h),
                    // Price
                    if (booking.price != null)
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            size: 12.sp,
                            color: metaColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${booking.formattedPrice}${'price_per_person_suffix'.tr()}',
                            style: TextStyle(
                              fontSize: 10.5.sp,
                              color: metaColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Status badge
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
          // Description (if available)
          // if (booking.description.isNotEmpty) ...[
          //   SizedBox(height: 8.h),
          //   Text(
          //     booking.description,
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //       fontSize: 10.5.sp,
          //       color: metaColor,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }

  String _formatDateRange() {
    if (booking.startDate.isEmpty) return '';
    if (booking.endDate.isNotEmpty && booking.startDate != booking.endDate) {
      return '${booking.startDate} → ${booking.endDate}';
    }
    return booking.startDate;
  }
}
