import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:ayssoft/app/manager/riverpod/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteEmptyWidget extends StatelessWidget {
  final FavoriteNotifier notifier;

  const FavoriteEmptyWidget({super.key, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 180.sp,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 40.h),
          Text(
            'Favori listeniz boş.',
            style: TextStyle(
              fontSize: 48.sp,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 75.h),
          _buildTestButton(notifier),
        ],
      ),
    );
  }

  Widget _buildTestButton(FavoriteNotifier notifier) {
    return ElevatedButton.icon(
      onPressed: () {
        final randomId = DateTime.now().millisecondsSinceEpoch;
        final testProduct = FavoriteProduct(
          id: randomId,
          title: 'Test Ürünü #$randomId',
          price: 99.99,
          thumbnail: 'https://placehold.co/600x400/FF5733/FFFFFF?text=Product',
          addedToFavoritesAt: DateTime.now(),
          rating: 4.5,
        );
        notifier.addFavorite(testProduct);
      },
      icon: Icon(
        Icons.add,
        size: 55.sp,
      ),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
        child: Text(
          'Sahte Favori Ekle (Test)',
          style: TextStyle(fontSize: 42.sp),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w),
        ),
        minimumSize: Size(400.w, 100.h),
      ),
    );
  }
}