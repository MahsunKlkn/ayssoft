import 'package:ayssoft/app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepperItem extends StatelessWidget {
  final String label;
  final int stepNumber;
  final bool isActive;
  final Color primaryColor;
  final Color textColor;

  const StepperItem({
    required this.label,
    required this.stepNumber,
    required this.isActive,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isActive ? Colors.white : Colors.white70;

    return Column(
      children: [
        Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : AppColors.primary,
            border: Border.all(color: borderColor, width: 3.w),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            stepNumber.toString(),
            style: TextStyle(
              color: isActive ? AppColors.primary : Colors.white70,
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(label, style: TextStyle(fontSize: 36.sp, color: textColor)),
      ],
    );
  }
}