import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:ayssoft/app/manager/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

class CartItemCompact extends ConsumerWidget { 
  final CartProduct product;
  final Color primaryColor;
  final VoidCallback onRemove; 

  const CartItemCompact({
    super.key,
    required this.product,
    required this.primaryColor,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final currentQuantity = product.quantity; 
    

    final bool hasDiscount = product.total != product.discountedTotal;
    final double finalPrice = product.discountedTotal;
    final primary = AppColors.primary;

    void incrementQuantity() {
      cartNotifier.updateProductQuantity(product.id, currentQuantity + 1);
    }

    void decrementQuantity() {
      cartNotifier.updateProductQuantity(product.id, currentQuantity - 1);
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h), 
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 180.w, 
                      height: 180.w, 
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: product.thumbnail.isNotEmpty
                            ? Image.network(
                                product.thumbnail, 
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return child; 
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.broken_image, color: Colors.grey, size: 90.sp);
                                },
                              )
                            : Icon(Icons.shopping_bag, color: primary, size: 90.sp),
                      ),
                    ),
                    SizedBox(width: 25.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 48.sp), 
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Stok Kodu: ${product.id}",
                            style: TextStyle(fontSize: 40.sp, color: Colors.grey[600]), 
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Azaltma Butonu
                              _QuantityButton(
                                icon: Icons.remove,
                                onPressed: decrementQuantity,
                                isEnabled: currentQuantity > 0, 
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "${currentQuantity}",
                                  style: TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Artırma Butonu
                              _QuantityButton(
                                icon: Icons.add,
                                onPressed: incrementQuantity,
                                isEnabled: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (hasDiscount) 
                          Text(
                            "${product.total.toStringAsFixed(2)} TL",
                            style: TextStyle(
                              fontSize: 38.sp, 
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey,
                            ),
                          ),
                        Text(
                          "${finalPrice.toStringAsFixed(2)} TL",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp, color: primary), 
                        ),
                        SizedBox(height: 10.h),
                        IconButton(
                          onPressed: onRemove,
                          icon: Icon(Icons.delete_outline, color: Colors.red, size: 60.sp),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1.h, thickness: 1.w, indent: 25.w, endIndent: 25.w, color: AppColors.grey50),
        ],
      ),
    );
  }
}

// Miktar butonu için yardımcı widget
class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isEnabled;

  const _QuantityButton({
    required this.icon,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      customBorder: const CircleBorder(),
      // İYİLEŞTİRME 2: Butona basıldığında oluşan mavi sıçrama (splash) efektini iptal ediyoruz.
      splashColor: Colors.transparent, 
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primary.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 40.sp,
          color: isEnabled ? AppColors.primary : Colors.grey,
        ),
      ),
    );
  }
}