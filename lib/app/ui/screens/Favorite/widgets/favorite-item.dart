import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteItemCard extends StatelessWidget {
  final FavoriteProduct product;
  final ValueChanged<int> onRemove;

  const FavoriteItemCard({
    super.key,
    required this.product,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ürün Resmi Bölümü
              _buildProductImage(product.thumbnail),
              SizedBox(width: 25.w),

              // Ürün Bilgileri Bölümü
              Expanded(
                child: _buildProductDetails(product),
              ),

              // Silme Butonu Bölümü
              _buildRemoveButton(),
            ],
          ),
        ),
        Divider(
            height: 1.h,
            thickness: 1.w,
            indent: 25.w,
            endIndent: 25.w,
            color: AppColors.grey50),
      ],
    );
  }

  // Ürün Resmi Bölümü (Alt Widget)
  Widget _buildProductImage(String thumbnailUrl) {
    return Container(
      width: 180.w,
      height: 180.w,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: thumbnailUrl.isNotEmpty
            ? Image.network(
                thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                      child: CircularProgressIndicator(color: AppColors.primary));
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, color: Colors.grey, size: 90.sp);
                },
              )
            : Icon(Icons.shopping_bag, color: AppColors.primary, size: 90.sp),
      ),
    );
  }

  // Ürün Detayları Bölümü (Alt Widget)
  Widget _buildProductDetails(FavoriteProduct product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 48.sp),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10.h),
        Text(
          "Fiyat: ${product.price.toStringAsFixed(2)} TL",
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 46.sp, color: AppColors.primary),
        ),
        SizedBox(height: 10.h),
        // Rating bilgisi
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 40.sp),
            SizedBox(width: 5.w),
            Text(
              product.rating?.toStringAsFixed(1) ?? 'N/A',
              style: TextStyle(fontSize: 40.sp, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        // Favoriye eklenme tarihi
        Text(
          'Eklenme: ${product.addedToFavoritesAt.day}.${product.addedToFavoritesAt.month}.${product.addedToFavoritesAt.year}',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 36.sp),
        ),
      ],
    );
  }

  // Kaldırma Butonu Bölümü (Alt Widget)
  Widget _buildRemoveButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          // onRemove'u burada çağırıyoruz, ana onRemove(product.id) metodu üst katmanda tanımlı
          onPressed: () => onRemove(product.id), 
          icon: Icon(Icons.delete_outline, color: Colors.red, size: 60.sp),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        SizedBox(height: 100.h),
      ],
    );
  }
}