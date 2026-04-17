import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_requests_cubit/guide_requests_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_filter_chip.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_new_request_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  void _showAcceptConfirmation(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.28),
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final dialogBg = Theme.of(context).cardColor;
        final titleColor = isDark ? Colors.white : AppColor.primaryColor;
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          backgroundColor: dialogBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 12.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 20,
                          spreadRadius: 1,
                          offset: Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Color(0x14047185),
                          blurRadius: 22,
                          spreadRadius: 2,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.task_alt_rounded,
                      size: 36.sp,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'guide_requests_confirmation'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'guide_requests_trip_confirmed'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: 110.w,
                    height: 34.h,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColor.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        'guide_done'.tr(),
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeclineConfirmation(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.28),
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final dialogBg = Theme.of(context).cardColor;
        final titleColor = isDark ? Colors.white : Colors.black;
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          backgroundColor: dialogBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 12.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22FF5B6E),
                          blurRadius: 22,
                          spreadRadius: 1,
                          offset: Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Color(0x18FF2A2A),
                          blurRadius: 24,
                          spreadRadius: 2,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 34.sp,
                      color: const Color(0xFFFF2A2A),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'guide_requests_are_you_sure'.tr(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 34.h,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFFC6CDD3),
                                width: .8,
                              ),
                              foregroundColor: const Color(0xFF8C97A1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: Text(
                              'guide_cancel'.tr(),
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: SizedBox(
                          height: 34.h,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xFFFF2A2A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: Text(
                              'guide_decline'.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return BlocBuilder<GuideRequestsCubit, GuideRequestsState>(
      builder: (context, state) {
        return SafeArea(
          child: ColoredBox(
            color: pageBg,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Center(
                    child: Text(
                      'guide_requests_title'.tr(),
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: GuideFilterChip(
                          label: 'guide_filter_new'.tr(),
                          isSelected: state.selectedFilter == 'New',
                          backgroundColor: cardBg,
                          textColor: primaryText,
                          onTap:
                              () => context
                                  .read<GuideRequestsCubit>()
                                  .selectFilter('New'),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: GuideFilterChip(
                          label: 'guide_filter_accepted'.tr(),
                          isSelected: state.selectedFilter == 'Accepted',
                          backgroundColor: cardBg,
                          textColor: primaryText,
                          onTap:
                              () => context
                                  .read<GuideRequestsCubit>()
                                  .selectFilter('Accepted'),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: GuideFilterChip(
                          label: 'guide_filter_declined'.tr(),
                          isSelected: state.selectedFilter == 'Declined',
                          backgroundColor: cardBg,
                          textColor: primaryText,
                          onTap:
                              () => context
                                  .read<GuideRequestsCubit>()
                                  .selectFilter('Declined'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ListView.separated(
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder:
                        (_, __) => GuideNewRequestCard(
                          onAccept: () => _showAcceptConfirmation(context),
                          onDecline: () => _showDeclineConfirmation(context),
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
