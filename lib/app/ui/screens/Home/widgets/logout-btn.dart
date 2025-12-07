import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef LogoutCallback = void Function();

class LogoutButton extends StatelessWidget {
  final LogoutCallback onPressed;
  final String text;

  const LogoutButton({
    super.key,
    required this.onPressed,
    this.text = 'Çıkış Yap',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 32.w),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF003366),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.8.w, 
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w), 
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 36.w, 
            vertical: 16.h,   
          ), 
          backgroundColor: Colors.transparent, 
        ),
        child: Text(
          text, 
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 36.sp,
          ),
        ),
      ),
    );
  }
}