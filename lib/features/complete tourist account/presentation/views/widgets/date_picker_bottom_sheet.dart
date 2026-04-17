import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';

class DatePickerBottomSheet extends StatefulWidget {
  final Function(DateTime from, DateTime to) onDateRangeSelected;

  const DatePickerBottomSheet({super.key, required this.onDateRangeSelected});

  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  DateTime? fromDate;
  DateTime? toDate;
  late DateTime displayedMonth;

  @override
  void initState() {
    super.initState();
    displayedMonth = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextSemiBold(
                          text: 'date_from'.tr(),
                          fontSize: 18.sp,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.grey),
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                size: 24.w,
                                color: AppColor.secondaryColor,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  fromDate != null
                                      ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(fromDate!)
                                      : 'dd/mm/yyyy',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color:
                                        fromDate != null
                                            ? Colors.black
                                            : Colors.grey[400],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (fromDate != null)
                                GestureDetector(
                                  onTap: () {
                                    setState(() => fromDate = null);
                                  },
                                  child: Container(
                                    width: 24.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                      color: AppColor.secondaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 14.w,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextSemiBold(
                          text: 'date_to'.tr(),
                          fontSize: 18.sp,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.grey),
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                size: 24.w,
                                color: AppColor.secondaryColor,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  toDate != null
                                      ? DateFormat('dd/MM/yyyy').format(toDate!)
                                      : 'dd/mm/yyyy',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color:
                                        toDate != null
                                            ? Colors.black
                                            : Colors.grey[400],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (toDate != null)
                                GestureDetector(
                                  onTap: () {
                                    setState(() => toDate = null);
                                  },
                                  child: Container(
                                    width: 24.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                      color: AppColor.secondaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 14.w,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.grey, width: 1),
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                  ),
                  child: _buildCustomCalendar(),
                ),
              ),

              SizedBox(height: 16.h),

              CustomButton(
                text: 'date_apply'.tr(),
                width: 240.w,
                onTap: () {
                  if (fromDate != null && toDate != null) {
                    widget.onDateRangeSelected(fromDate!, toDate!);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('date_select_both'.tr())),
                    );
                  }
                },
              ),

              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomCalendar() {
    final now = DateTime.now();
    final daysInMonth =
        DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
    final firstDayOfMonth =
        DateTime(displayedMonth.year, displayedMonth.month, 1).weekday;

    List<Widget> dayWidgets = [];

    // مسافات قبل اليوم الأول
    for (int i = 1; i < firstDayOfMonth; i++) {
      dayWidgets.add(const SizedBox());
    }

    // أيام الشهر
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(displayedMonth.year, displayedMonth.month, day);

      // منع اختيار أيام قبل اليوم الحالي
      final isPastDate = date.isBefore(DateTime(now.year, now.month, now.day));

      final isFromDate =
          fromDate != null &&
          date.year == fromDate!.year &&
          date.month == fromDate!.month &&
          date.day == fromDate!.day;
      final isToDate =
          toDate != null &&
          date.year == toDate!.year &&
          date.month == toDate!.month &&
          date.day == toDate!.day;
      final isInRange =
          fromDate != null &&
          toDate != null &&
          date.isAfter(fromDate!) &&
          date.isBefore(toDate!);

      dayWidgets.add(
        GestureDetector(
          onTap:
              isPastDate
                  ? null
                  : () {
                    setState(() {
                      if (fromDate == null) {
                        fromDate = date;
                      } else if (toDate == null) {
                        if (date.isBefore(fromDate!)) {
                          toDate = fromDate;
                          fromDate = date;
                        } else {
                          toDate = date;
                        }
                      } else {
                        fromDate = date;
                        toDate = null;
                      }
                    });
                  },
          child: Container(
            decoration: BoxDecoration(
              color:
                  isFromDate || isToDate
                      ? AppColor.secondaryColor
                      : isInRange
                      ? const Color(0xFFE0F2F1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      isFromDate || isToDate
                          ? FontWeight.bold
                          : FontWeight.w500,
                  color:
                      isPastDate
                          ? Colors.grey[300]
                          : isFromDate || isToDate
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    displayedMonth = DateTime(
                      displayedMonth.year,
                      displayedMonth.month - 1,
                    );
                  });
                },
                icon: const Icon(
                  Icons.keyboard_double_arrow_left,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Text(
                DateFormat('MMM yyyy').format(displayedMonth),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    displayedMonth = DateTime(
                      displayedMonth.year,
                      displayedMonth.month + 1,
                    );
                  });
                },
                icon: const Icon(
                  Icons.keyboard_double_arrow_right,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                [
                      'day_su',
                      'day_mo',
                      'day_tu',
                      'day_we',
                      'day_th',
                      'day_fr',
                      'day_sa',
                    ]
                    .map(
                      (day) => Expanded(
                        child: Center(
                          child: Text(
                            day.tr(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),

        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          childAspectRatio: 1.2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: dayWidgets,
        ),
      ],
    );
  }
}
