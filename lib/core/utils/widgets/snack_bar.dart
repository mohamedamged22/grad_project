import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  bool isSuccess = true,
}) {
  final color = isSuccess ? Colors.green : Colors.red;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),

      backgroundColor: color.withOpacity(0.9),
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
