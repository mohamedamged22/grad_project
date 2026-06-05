import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TouristTripHistoryView extends StatelessWidget {
  const TouristTripHistoryView({super.key});

  static const _history = <_HistoryItemData>[
    _HistoryItemData(
      imagePath: 'assets/images/2th.jpg',
      title: 'Ancient Wonder of Aswan',
      guide: 'Ahmed Sameh',
      dateText: '1 Feb - 15 Feb, 2026',
      price: r'$ 150',
      rating: '3.8',
      status: 'trip_status_completed',
    ),
    _HistoryItemData(
      imagePath: 'assets/images/3th.jpg',
      title: 'Ancient Wonder of Giza',
      guide: 'Mariam Sol',
      dateText: '1 Feb - 15 Feb, 2026',
      price: r'$ 150',
      rating: '4.6',
      status: 'trip_status_cancelled',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: AppColor.secondaryColor,
          ),
        ),
        title: Text(
          'trip_history'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 2.h, 10.w, 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'tourist_trip_history_status_title'.tr(),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: primaryText,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  _StatusStat(
                    value: '2',
                    label: 'trip_status_completed'.tr(),
                    color: const Color(0xFF1BAA5A),
                  ),
                  _StatusStat(
                    value: '1',
                    label: 'trip_status_cancelled'.tr(),
                    color: const Color(0xFFD64545),
                  ),
                  _StatusStat(
                    value: '5',
                    label: 'trip_status_spent'.tr(),
                    color: const Color(0xFFF39A2C),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.separated(
                  itemCount: _history.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (_, index) => _HistoryCard(item: _history[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatusStat({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: color),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: TextStyle(fontSize: 9.sp, color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final _HistoryItemData item;

  const _HistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor =
      item.status == 'trip_status_completed'
        ? const Color(0xFF1BAA5A)
        : const Color(0xFFD64545);

    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2D4350) : const Color(0xFFD9E4EA),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              height: 95.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item.imagePath, fit: BoxFit.cover),
                  Positioned(
                    right: 6.w,
                    top: 6.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: .9),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        item.status.tr(),
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 7.h),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColor.primaryColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            item.dateText,
            style: TextStyle(
              fontSize: 8.sp,
              color: isDark ? const Color(0xFF9FB0BD) : const Color(0xFF78909E),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              CircleAvatar(
                radius: 10.r,
                backgroundImage: const AssetImage('assets/images/2th.jpg'),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.guide,
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 10.sp,
                          color: const Color(0xFFF8B64C),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          item.rating,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: const Color(0xFFF8B64C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                item.price,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryColor,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'price_per_person_suffix'.tr(),
                style: TextStyle(
                  fontSize: 8.sp,
                  color: isDark ? const Color(0xFF9FB0BD) : const Color(0xFF78909E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryItemData {
  final String imagePath;
  final String title;
  final String guide;
  final String dateText;
  final String price;
  final String rating;
  final String status;

  const _HistoryItemData({
    required this.imagePath,
    required this.title,
    required this.guide,
    required this.dateText,
    required this.price,
    required this.rating,
    required this.status,
  });
}
