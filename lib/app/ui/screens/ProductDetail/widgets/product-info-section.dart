import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoSection extends StatelessWidget {
  final Product product;
  const ProductInfoSection({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final originalPrice = product.price;
    final discountPercentage = product.discountPercentage;
    final discountedPrice =
        originalPrice * (1 - discountPercentage / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${product.category.toUpperCase()} | ${product.brand}',
          style: TextStyle(
              fontSize: 40.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        Text(
          product.title,
          style: TextStyle(
              fontSize: 70.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 20.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${discountedPrice.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 80.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple),
            ),
            SizedBox(width: 15.w),
            Text(
              '\$${originalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 50.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: 15.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                '%${discountPercentage.toStringAsFixed(0)} İNDİRİM',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Icon(Icons.star_rounded, color: Colors.amber, size: 55.sp),
            SizedBox(width: 6.w),
            Text(
              '${product.rating.toStringAsFixed(1)} ',
              style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '(${product.reviews.length} Yorum)',
              style: TextStyle(fontSize: 45.sp, color: Colors.grey),
            ),
            const Spacer(),
            Text(
              product.availabilityStatus == 'In Stock'
                  ? '✅ Stokta (${product.stock})'
                  : '❌ Tükendi',
              style: TextStyle(
                  fontSize: 45.sp,
                  color: product.availabilityStatus == 'In Stock'
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ],
    );
  }
}