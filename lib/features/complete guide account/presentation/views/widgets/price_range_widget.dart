import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceRangeWidget extends StatefulWidget {
  final Function(int min, int max)? onPriceChanged;

  const PriceRangeWidget({super.key, this.onPriceChanged});

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  final TextEditingController minController = TextEditingController(
    text: '100',
  );
  final TextEditingController maxController = TextEditingController(
    text: '600',
  );
  int totalPrice = 700;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    int min = int.tryParse(minController.text) ?? 0;
    int max = int.tryParse(maxController.text) ?? 0;
    setState(() {
      totalPrice = min + max;
    });

    if (widget.onPriceChanged != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onPriceChanged!(min, max);
      });
    }
  }

  void _incrementTotal() {
    setState(() {
      totalPrice += 50;
    });
  }

  void _decrementTotal() {
    if (totalPrice > 0) {
      setState(() {
        totalPrice -= 50;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Min Field
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'pricing_min'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              _buildPriceField(controller: minController),
            ],
          ),
        ),

        SizedBox(width: 12.w),

        // Max Field
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'pricing_max'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              _buildPriceField(controller: maxController),
            ],
          ),
        ),

        SizedBox(width: 12.w),

        // Total Field
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'pricing_total'.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              _buildTotalField(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceField({required TextEditingController controller}) {
    return Container(
      height: 30.h,
      width: 75.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.primaryColor, width: 1),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.secondaryColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
            suffixText: ' \$',
            suffixStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.secondaryColor,
            ),
          ),
          onChanged: (value) => _calculateTotal(),
        ),
      ),
    );
  }

  Widget _buildTotalField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // زر الناقص
        InkWell(
          onTap: _decrementTotal,
          child: Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Icon(
              Icons.remove,
              color: AppColor.secondaryColor,
              size: 14.w,
            ),
          ),
        ),

        // القيمة
        Container(
          height: 30.h,
          width: 75.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.primaryColor, width: 1),
          ),

          child: Center(
            child: Text(
              '$totalPrice \$',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.secondaryColor,
              ),
            ),
          ),
        ),

        // زر الزائد
        InkWell(
          onTap: _incrementTotal,
          child: Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Icon(Icons.add, color: AppColor.secondaryColor, size: 14.w),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }
}
