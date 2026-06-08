import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/loading_overlay.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/widgets/date_picker_bottom_sheet.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_booking_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TouristCreateRequestView extends StatefulWidget {
  final int? guideId;
  final String? guideName;

  const TouristCreateRequestView({
    super.key,
    this.guideId,
    this.guideName,
  });

  @override
  State<TouristCreateRequestView> createState() =>
      _TouristCreateRequestViewState();
}

class _TouristCreateRequestViewState extends State<TouristCreateRequestView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  DateTimeRange? _dateRange;
  bool _isSubmitting = false;

  final _bookingRepo = sl<TouristBookingRepo>();

  @override
  void initState() {
    super.initState();
    titleController.addListener(_onTextChanged);
    descriptionController.addListener(_onTextChanged);
    priceController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    titleController.removeListener(_onTextChanged);
    descriptionController.removeListener(_onTextChanged);
    priceController.removeListener(_onTextChanged);
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      titleController.text.trim().isNotEmpty &&
      descriptionController.text.trim().isNotEmpty &&
      priceController.text.trim().isNotEmpty &&
      _dateRange != null &&
      widget.guideId != null &&
      !_isSubmitting;

  Future<void> _submitRequest() async {
    if (!_canSubmit) return;

    setState(() => _isSubmitting = true);
    showLoadingOverlay(context);

    try {
      await _bookingRepo.createGuideBookingRequest(
        guideId: widget.guideId!,
        title: titleController.text.trim(),
        startDate:
            '${_dateRange!.start.year}-${_dateRange!.start.month.toString().padLeft(2, '0')}-${_dateRange!.start.day.toString().padLeft(2, '0')}',
        endDate:
            '${_dateRange!.end.year}-${_dateRange!.end.month.toString().padLeft(2, '0')}-${_dateRange!.end.day.toString().padLeft(2, '0')}',
        description: descriptionController.text.trim(),
        price: num.tryParse(priceController.text.trim()) ?? 0,
      );

      if (mounted) {
        hideLoadingOverlay(context);
        showSnackBar(
          context,
          'create_request_success'.tr(),
          isSuccess: true,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        hideLoadingOverlay(context);
        showSnackBar(
          context,
          e.toString(),
          isSuccess: false,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    final rangeText =
        _dateRange == null
            ? 'create_request_select_date'.tr()
            : '${DateFormat('dd/MM/yyyy').format(_dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_dateRange!.end)}';

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: pageBg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: AppColor.secondaryColor,
          ),
        ),
        title: Text(
          'create_request_title'.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),

              // Guide name if available
              if (widget.guideName != null) ...[
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color:
                          isDark
                              ? const Color(0xFF2F4A5A)
                              : const Color(0xFF9EC5D7),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 22.sp,
                        color: AppColor.secondaryColor,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          widget.guideName!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],

              // Title
              CustomTextSemiBold(
                text: 'create_request_title_label'.tr(),
                fontSize: 15.sp,
              ),
              SizedBox(height: 6.h),
              CustomTextField(
                controller: titleController,
                hintText: 'create_request_title_hint'.tr(),
              ),

              SizedBox(height: 16.h),

              // Date Range (using DatePickerBottomSheet)
              CustomTextSemiBold(
                text: 'create_request_date_range'.tr(),
                fontSize: 15.sp,
              ),
              SizedBox(height: 6.h),
              InkWell(
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder:
                        (context) => DatePickerBottomSheet(
                          onDateRangeSelected: (from, to) {
                            setState(() {
                              _dateRange = DateTimeRange(
                                start: from,
                                end: to,
                              );
                            });
                          },
                        ),
                  );
                },
                borderRadius: BorderRadius.circular(24.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color:
                          isDark
                              ? const Color(0xFF3A4A58)
                              : AppColor.primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          rangeText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color:
                                _dateRange == null
                                    ? const Color(0xFF929292)
                                    : primaryText,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today_outlined,
                        color: AppColor.secondaryColor,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 14.h),

              // Description (multiline like guide_create_trip_time_view)
              CustomTextSemiBold(
                text: 'create_request_description'.tr(),
                fontSize: 15.sp,
              ),
              SizedBox(height: 6.h),
              TextFormField(
                controller: descriptionController,
                minLines: 4,
                maxLines: 4,
                style: TextStyle(
                  color: primaryText,
                  fontSize: 12.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'create_request_description_hint'.tr(),
                  hintStyle: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF929292),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(
                      color:
                          isDark
                              ? const Color(0xFF3A4A58)
                              : AppColor.primaryColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(
                      color:
                          isDark
                              ? const Color(0xFF5A6A78)
                              : AppColor.primaryColor,
                      width: 1.4,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 14.h),

              // Price
              CustomTextSemiBold(
                text: 'create_request_price'.tr(),
                fontSize: 15.sp,
              ),
              SizedBox(height: 6.h),
              CustomTextField(
                controller: priceController,
                hintText: 'create_request_price_hint'.tr(),
                prefixIcon: Icon(
                  Icons.attach_money_rounded,
                  color: AppColor.secondaryColor,
                ),
              ),

              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
          child: CustomButton(
            text: 'create_request_submit'.tr(),
            onTap: _canSubmit ? _submitRequest : null,
          ),
        ),
      ),
    );
  }
}