import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${currentStep - 1} ',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.green,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'steps_completed'.tr(namedArgs: {'total': totalSteps.toString()}),
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: List.generate(totalSteps * 2 - 1, (index) {
            if (index.isEven) {
              int stepNumber = (index ~/ 2) + 1;
              bool isCompleted = stepNumber < currentStep;
              bool isCurrent = stepNumber == currentStep;

              return _buildStepCircle(
                stepNumber: stepNumber,
                isCompleted: isCompleted,
                isCurrent: isCurrent,
              );
            } else {
              return _buildConnectingDots();
            }
          }),
        ),
      ],
    );
  }

  Widget _buildStepCircle({
    required int stepNumber,
    required bool isCompleted,
    required bool isCurrent,
  }) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isCompleted || isCurrent ? Colors.green : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Center(
        child:
            isCompleted
                ? Icon(Icons.check, size: 16.w, color: Colors.white)
                : Text(
                  '$stepNumber',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isCurrent ? Colors.green : Colors.grey.shade400,
                  ),
                ),
      ),
    );
  }

  Widget _buildConnectingDots() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return Container(
            width: 5.w,
            height: 5.w,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
