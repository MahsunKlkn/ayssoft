import 'package:ayssoft/app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepperConnector extends StatelessWidget {
  final bool isActive;
  final Color primaryColor;

  const StepperConnector({required this.isActive, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 5.h,
        color: isActive ? AppColors.primary : AppColors.primary.withOpacity(0.5),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
      ),
    );
  }
}
