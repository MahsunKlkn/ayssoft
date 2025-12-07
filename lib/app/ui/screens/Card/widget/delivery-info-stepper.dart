import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/ui/screens/Card/widget/stepper-connector.dart';
import 'package:ayssoft/app/ui/screens/Card/widget/stepper-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryInfoStepper extends StatelessWidget {
  final String step1Label;
  final String step2Label;
  final String step3Label;
  final Color primaryColor;

  const DeliveryInfoStepper({
    required this.step1Label, 
    required this.step2Label, 
    required this.step3Label, 
    required this.primaryColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StepperItem(label: step1Label, stepNumber: 1, isActive: true, primaryColor: AppColors.primary, textColor: Colors.white),
          StepperConnector(isActive: true, primaryColor: Colors.white),
          StepperItem(label: step2Label, stepNumber: 2, isActive: false, primaryColor: AppColors.primary, textColor: Colors.white),
          StepperConnector(isActive: false, primaryColor: Colors.white),
          StepperItem(label: step3Label, stepNumber: 3, isActive: false, primaryColor: AppColors.primary, textColor: Colors.white),
        ],
      ),
    );
  }
}
