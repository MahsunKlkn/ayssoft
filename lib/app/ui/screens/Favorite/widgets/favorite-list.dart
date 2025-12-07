import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:ayssoft/app/manager/riverpod/favorite.dart';
import 'package:ayssoft/app/ui/screens/Favorite/widgets/favorite-item.dart';
import 'package:flutter/material.dart';

class FavoriteListWidget extends StatelessWidget {
  final List<FavoriteProduct> favorites;
  final FavoriteNotifier notifier;

  const FavoriteListWidget({
    super.key,
    required this.favorites,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final product = favorites[index];
        return FavoriteItemCard(
          product: product,
          onRemove: (id) {
            notifier.removeFavorite(id);
            // Kullanıcıya geri bildirim verme
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} favorilerden kaldırıldı.'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}