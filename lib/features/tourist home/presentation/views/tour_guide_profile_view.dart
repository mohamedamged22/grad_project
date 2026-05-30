import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class TourGuideProfileView extends StatelessWidget {
  const TourGuideProfileView({super.key});

  static const _specialties = <String>[
    'History',
    'Culture',
    'Photography',
    'Food',
  ];

  static const _languages = <String>['English', 'Spanish'];

  static const _guideTrips = <_GuideTripCardData>[
    _GuideTripCardData(
      imagePath: 'assets/images/2th.jpg',
      title: 'Ancient Wonders Of Aswan',
      price: r'$ 300',
      dateText: '24 Feb- 30 Feb, 2026',
    ),
    _GuideTripCardData(
      imagePath: 'assets/images/3th.jpg',
      title: 'Ancient Wonders Of Giza',
      price: r'$ 210',
      dateText: '1 Feb- 15 Feb, 2026',
    ),
    _GuideTripCardData(
      imagePath: 'assets/images/2th.jpg',
      title: 'Ancient Wonders Of Aswan',
      price: r'$ 150',
      dateText: '1 Feb- 15 Feb, 2026',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = isDark ? const Color(0xFF0F1A24) : const Color(0xFFF1F4F6);

    return Scaffold(
      backgroundColor: pageBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 205.h,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r),
                    ),
                    child: SizedBox(
                      height: 160.h,
                      width: double.infinity,
                      child: Image.asset('assets/images/sky.png', fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 18.h,
                    left: 8.w,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(6.w),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF10222E) : Colors.white,
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: Image.asset(
                            'assets/images/2th.jpg',
                            width: 92.w,
                            height: 92.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                'Ahmed Sameh',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : AppColor.secondaryColor,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 15.sp,
                    color: const Color(0xFFF39A2C),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Cairo, Giza',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? const Color(0xFFA8B7C4)
                          : const Color(0xFF556C7B),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            Center(
              child: Text(
                'Member Since Jan 2026',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? const Color(0xFFA8B7C4)
                      : const Color(0xFF1B7E96),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: IntrinsicHeight(
                child: Row(
                  children: const [
                    Expanded(child: _TopStat(value: '120', label: 'Trips Led')),
                    _StatsDivider(),
                    Expanded(child: _TopStat(value: '3.6', label: 'Rating')),
                    _StatsDivider(),
                    Expanded(child: _TopStat(value: '< 1 hour', label: 'Response')),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 14.sp,
                  color: AppColor.secondaryColor,
                ),
                label: Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.secondaryColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(180.w, 40.h),
                  side: BorderSide(
                    color: AppColor.secondaryColor.withValues(alpha: .6),
                  ),
                  backgroundColor:
                      isDark ? const Color(0xFF173041) : const Color(0xFFF8FCFE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            const _SectionTitle(title: 'About'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: _RoundedCard(
                isDark: isDark,
                child: Text(
                  'Discover the magic of Egypt with a local guide. '
                  'I will show you hidden gems, history, and real culture. '
                  'Fun, safe, and memorable tours guaranteed. '
                  'Your journey starts here!',
                  style: TextStyle(
                    fontSize: 10.sp,
                    height: 1.5,
                    color: isDark
                        ? const Color(0xFFB2C0CC)
                        : const Color(0xFF607382),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            const _SectionTitle(title: 'Specialties'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final item in _specialties) _ProfileChip(label: item),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            const _SectionTitle(title: 'Languages'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final item in _languages) _ProfileChip(label: item),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            const _SectionTitle(title: 'Trips by Ahmed Sameh'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  for (final item in _guideTrips)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _GuideTripMiniCard(item: item),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsDivider extends StatelessWidget {
  const _StatsDivider();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 1,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      color: isDark ? const Color(0xFF375061) : const Color(0xFFBFD3DE),
    );
  }
}

class _TopStat extends StatelessWidget {
  final String value;
  final String label;

  const _TopStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: isDark ? Colors.white : const Color(0xFF121A22),
            height: .95,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE88412),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: AppColor.secondaryColor,
          height: 0.95,
        ),
      ),
    );
  }
}

class _RoundedCard extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const _RoundedCard({required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2833) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2F4A5A) : const Color(0xFF7DB3C6),
        ),
      ),
      child: child,
    );
  }
}

class _ProfileChip extends StatelessWidget {
  final String label;

  const _ProfileChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 82.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B313E) : const Color(0xFFDBE7EC),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: isDark ? const Color(0xFFB2C0CC) : AppColor.secondaryColor,
        ),
      ),
    );
  }
}

class _GuideTripMiniCard extends StatelessWidget {
  final _GuideTripCardData item;

  const _GuideTripMiniCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2D4350) : const Color(0xFF79AFC2),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r)),
            child: Image.asset(
              item.imagePath,
              width: 130.w,
              height: 108.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8.h, 8.w, 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppColor.primaryColor,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 13.sp,
                        color: AppColor.secondaryColor,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          item.dateText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isDark
                                ? const Color(0xFF9FB0BD)
                                : const Color(0xFF556C7B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.price} / person',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      SizedBox(
                        height: 30.h,
                        width: 88.w,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColor.secondaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideTripCardData {
  final String imagePath;
  final String title;
  final String price;
  final String dateText;

  const _GuideTripCardData({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.dateText,
  });
}
