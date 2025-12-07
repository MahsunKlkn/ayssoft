import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:ayssoft/app/data/model/product.dart';
import 'package:ayssoft/app/manager/provider/cart.dart';
import 'package:ayssoft/app/manager/provider/favorite.dart';
import 'package:ayssoft/app/ui/screens/ProductDetail/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteNotifier = ref.read(favoriteNotifierProvider.notifier);
    final isFavorite = ref.watch(
      favoriteNotifierProvider.select(
        (state) => state.favorites.any((fav) => fav.id == product.id),
      ),
    );

    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product),
            ),
          );
        },
        borderRadius: BorderRadius.circular(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.r),
                    ),
                    child: Image.network(
                      product.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(strokeWidth: 2.w),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 40.w,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 72.sp,
                        padding: EdgeInsets.all(4.r),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red.shade700 : Colors.red,
                        ),
                        onPressed: () async {
                          final favProduct = FavoriteProduct(
                            id: product.id,
                            title: product.title,
                            price: product.price,
                            thumbnail: product.thumbnail,
                            rating: product.rating,
                            addedToFavoritesAt: DateTime.now(),
                          );
                          await favoriteNotifier.toggleFavorite(favProduct);

                          final isFavorite = favoriteNotifier.isFavorite(
                            product.id,
                          );
                          final action = isFavorite ? "eklendi" : "çıkarıldı";

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${product.title} favorilerden $action.",
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 36.sp,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${product.price.toStringAsFixed(2)} \TL',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w900,
                                fontSize: 36.sp,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 36.sp,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  product.rating.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 48.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 100.h,
                              width: 250.w,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                ),
                                icon: Icon(Icons.shopping_cart, size: 36.sp),
                                label: Text(
                                  'Sepete Ekle',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  final cartProduct = CartProduct(
                                    id: product.id,
                                    title: product.title,
                                    price: product.price,
                                    quantity: 1,
                                    total: product.price,
                                    // Not: discountedTotal hesaplaması CartProduct modelinize göre ayarlanmalıdır
                                    discountPercentage:
                                        product.discountPercentage,
                                    discountedTotal:
                                        product.price *
                                        (1 -
                                            product.discountPercentage /
                                                100), // Basit bir hesaplama ekledim
                                    thumbnail: product.thumbnail,
                                  );
                                  await cartNotifier.addProduct(cartProduct);

                                  // Snackbar bildirim
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${product.title} sepete eklendi",
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
