import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:ayssoft/app/data/model/product.dart';
import 'package:ayssoft/app/manager/provider/cart.dart' show cartNotifierProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingBottomBar extends StatelessWidget {
  final Product product;
  final WidgetRef ref;

  const FloatingBottomBar({required this.product, required this.ref});

  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h), 
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -6),
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Toplam Fiyat',
                  style: TextStyle(fontSize: 40.sp, color: Colors.grey.shade600),
                ),
                Text(
                  '\$${discountedPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 75.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary),
                ),
              ],
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: SizedBox(
                height: 150.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  icon: Icon(Icons.shopping_cart, size: 60.sp),
                  label: Text(
                    'Sepete Ekle',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    final cartProduct = CartProduct(
                      id: product.id,
                      title: product.title,
                      price: product.price,
                      quantity: 1,
                      total: product.price,
                      discountPercentage: product.discountPercentage,
                      discountedTotal: discountedPrice,
                      thumbnail: product.thumbnail,
                    );
                    await cartNotifier.addProduct(cartProduct);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${product.title} sepete eklendi"),
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
    );
  }
}