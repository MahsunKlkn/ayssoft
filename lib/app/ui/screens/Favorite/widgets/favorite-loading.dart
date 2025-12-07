import 'package:ayssoft/app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteLoadingWidget extends StatelessWidget {
  const FavoriteLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 40.h),
          Text(
            'Favoriler yükleniyor...',
            style: TextStyle(fontSize: 42.sp), 
          ),
        ],
      ),
    );
  }
}