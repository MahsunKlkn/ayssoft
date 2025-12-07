import 'package:ayssoft/app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryInfoCard extends StatelessWidget {
  final Color primaryColor;
  
  const DeliveryInfoCard({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8.w)],
      ),
      child: Row(
        children: [
          Icon(Icons.access_time_filled, color: AppColors.primary, size: 60.sp),
          SizedBox(width: 25.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hazırlık Süresi", style: TextStyle(fontSize: 36.sp, color: Colors.grey)),
              Text(
                "Ortalama 1 İş Günü",
                style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}