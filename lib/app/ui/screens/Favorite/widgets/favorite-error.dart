import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteErrorWidget extends StatelessWidget {
  final String error;

  const FavoriteErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 60.w,
          vertical: 60.h,
        ),
        child: Text(
          'Hata: $error',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontSize: 42.sp,
          ),
        ),
      ),
    );
  }
}