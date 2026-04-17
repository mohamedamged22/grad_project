import 'package:flutter/material.dart';
import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';

class TravelersCounter extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;
  final int min;
  final int max;

  const TravelersCounter({
    super.key,
    this.initialValue = 1,
    this.onChanged,
    this.min = 1,
    this.max = 99,
  });

  @override
  State<TravelersCounter> createState() => _TravelersCounterState();
}

class _TravelersCounterState extends State<TravelersCounter> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(widget.min, widget.max);
  }

  void _update(int newValue) {
    newValue = newValue.clamp(widget.min, widget.max);
    if (newValue == _value) return;
    setState(() => _value = newValue);
    widget.onChanged?.call(_value);
  }

  Widget _iconButton({
    required IconData icon,
    required VoidCallback? onTap,
    required bool enabled,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: enabled ? AppColor.secondaryColor : Colors.black,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          size: 18.w,
          color: enabled ? AppColor.secondaryColor : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _iconButton(
            icon: Icons.remove,
            enabled: _value > widget.min,
            onTap: () => _update(_value - 1),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 75.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.black, width: 1.2),
            ),
            child: Center(
              child: Text(
                '$_value',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          _iconButton(
            icon: Icons.add,
            enabled: _value < widget.max,
            onTap: () => _update(_value + 1),
          ),
        ],
      ),
    );
  }
}
