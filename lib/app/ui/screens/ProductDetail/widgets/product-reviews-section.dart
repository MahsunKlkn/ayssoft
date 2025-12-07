import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/data/model/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductReviewsSection extends StatelessWidget {
  final List<Review> reviews;
  const ProductReviewsSection({required this.reviews, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Text(
          'Bu ürün için henüz yorum yapılmamış.',
          style: TextStyle(fontSize: 40.sp, color: Colors.grey),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Müşteri Yorumları (${reviews.length})',
          style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.h),
        ...reviews.take(3).map((review) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Card(
              color: Colors.grey.shade50,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review.reviewerName,
                          style: TextStyle(
                              fontSize: 45.sp, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < review.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 45.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      review.comment,
                      style: TextStyle(
                          fontSize: 40.sp, color: Colors.grey.shade800),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      review.date.substring(0, 10),
                      style: TextStyle(fontSize: 35.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        if (reviews.length > 3)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: TextButton(
              onPressed: () {
              },
              child: Text(
                'Tüm ${reviews.length} yorumu gör',
                style: TextStyle(
                    fontSize: 45.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}