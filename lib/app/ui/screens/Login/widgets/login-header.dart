import 'package:ayssoft/app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hoş Geldiniz!',
          style: TextStyle(
            fontSize: 80.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Hesabınıza giriş yapın',
          style: TextStyle(
            fontSize: 45.sp,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 100.h),
      ],
    );
  }
}