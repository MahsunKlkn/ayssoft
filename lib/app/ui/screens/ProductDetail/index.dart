import 'package:ayssoft/app/data/model/product.dart';
import 'package:ayssoft/app/manager/provider/favorite.dart';
import 'package:ayssoft/app/ui/screens/ProductDetail/widgets/additional-info.dart';
import 'package:ayssoft/app/ui/screens/ProductDetail/widgets/favorite-btn.dart';
import 'package:ayssoft/app/ui/screens/ProductDetail/widgets/floating-bottom-bar.dart';
import 'package:ayssoft/app/ui/screens/ProductDetail/widgets/product-image-carousel.dart';
import 'package:ayssoft/app/ui/screens/ProductDetail/widgets/product-info-section.dart';
import 'package:ayssoft/app/ui/screens/ProductDetail/widgets/product-reviews-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsPage extends ConsumerWidget {
  final Product product;

  const ProductDetailsPage({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(
      favoriteNotifierProvider.select(
        (state) => state.favorites.any((fav) => fav.id == product.id),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          product.brand,
          style: TextStyle(
            fontSize: 55.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FavoriteButton(
            product: product,
            isFavorite: isFavorite,
            favoriteNotifier: ref.read(favoriteNotifierProvider.notifier),
          ),
          SizedBox(width: 16.w),
        ],
      ),

      body: Stack(
        children: [
          SafeArea(
            top: false,
            bottom: true,
            child: ListView(
              padding: EdgeInsets.only(
                bottom: 140.h,
              ),
              children: [
                ProductImageCarousel(images: product.images),
                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductInfoSection(product: product),
                      Divider(height: 40.h),

                      Text(
                        'Ürün Açıklaması',
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),

                      Divider(height: 40.h),
                      AdditionalInfo(product: product),
                      Divider(height: 40.h),
                      ProductReviewsSection(reviews: product.reviews),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: FloatingBottomBar(
              product: product,
              ref: ref,
            ),
          ),
        ],
      ),
    );
  }
}
