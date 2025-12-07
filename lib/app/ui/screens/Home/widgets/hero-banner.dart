import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.w),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            SizedBox(
              height: 700.h,
              width: double.infinity,
              child: Image.asset(
                'lib/app/public/assets/dummyHome.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 700.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(36.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "DummyJson",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Aradığın Her Şey Burada!",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 36.sp
                    ),
                  ),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                    ),
                    child: const Text("Ürünleri Keşfet"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}