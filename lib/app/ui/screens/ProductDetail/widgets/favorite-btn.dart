import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:ayssoft/app/data/model/product.dart';
import 'package:ayssoft/app/manager/riverpod/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteButton extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final FavoriteNotifier favoriteNotifier;

  const FavoriteButton({
    required this.product,
    required this.isFavorite,
    required this.favoriteNotifier,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        iconSize: 85.sp,
        padding: EdgeInsets.all(8.r),
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
          final action =
              favoriteNotifier.isFavorite(product.id) ? "eklendi" : "çıkarıldı";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${product.title} favorilerden $action."),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}