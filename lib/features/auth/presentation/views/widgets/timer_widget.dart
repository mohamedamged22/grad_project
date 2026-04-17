import 'dart:async';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class OtpTimer extends StatefulWidget {
  const OtpTimer({super.key});

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  static const int _startTime = 45;
  late int _seconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _seconds = _startTime;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _timerBadge();
  }

  Widget _timerBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        '0:${_seconds.toString().padLeft(2, '0')}',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}
