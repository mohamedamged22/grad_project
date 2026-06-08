import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_trip_history_cubit/tourist_trip_history_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/widgets/tourist_history_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristTripHistoryView extends StatelessWidget {
  const TouristTripHistoryView({super.key});

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
          'my_requests'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TouristTripHistoryCubit, TouristTripHistoryState>(
          builder: (context, state) {
            if (state.status == TouristTripHistoryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == TouristTripHistoryStatus.failure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.errorMessage ?? 'tourist_trip_history_failed'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextButton(
                      onPressed:
                          () =>
                              context
                                  .read<TouristTripHistoryCubit>()
                                  .fetchBookings(),
                      child: Text(
                        'action_retry'.tr(),
                        style: TextStyle(color: AppColor.secondaryColor),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(10.w, 2.h, 10.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _StatusStat(
                        value: '${state.acceptedCount}',
                        label: 'trip_status_accepted'.tr(),
                        color: const Color(0xFF4CAF50),
                      ),
                      _StatusStat(
                        value: '${state.rejectedCount}',
                        label: 'trip_status_rejected'.tr(),
                        color: const Color(0xFFFF2A2A),
                      ),
                      _StatusStat(
                        value: '${state.pendingCount}',
                        label: 'trip_status_pending'.tr(),
                        color: const Color(0xFFF39A2C),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  if (state.bookings.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          'tourist_trip_history_empty'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color:
                                isDark
                                    ? const Color(0xFF9DB0BF)
                                    : const Color(0xFF6E7F8D),
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: RefreshIndicator(
                        color: AppColor.secondaryColor,
                        onRefresh:
                            () =>
                                context
                                    .read<TouristTripHistoryCubit>()
                                    .fetchBookings(),
                        child: ListView.separated(
                          itemCount: state.bookings.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder:
                              (_, index) => TouristHistoryCard(
                                booking: state.bookings[index],
                              ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
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
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.sp,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
