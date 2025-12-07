import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/manager/provider/favorite.dart';
import 'package:ayssoft/app/manager/riverpod/favorite.dart' hide favoriteNotifierProvider;
import 'package:ayssoft/app/manager/state/favoriteState.dart';
import 'package:ayssoft/app/ui/screens/Favorite/widgets/favorite-empty.dart';
import 'package:ayssoft/app/ui/screens/Favorite/widgets/favorite-error.dart';
import 'package:ayssoft/app/ui/screens/Favorite/widgets/favorite-list.dart';
import 'package:ayssoft/app/ui/screens/Favorite/widgets/favorite-loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState = ref.watch(favoriteNotifierProvider);
    final favoriteNotifier = ref.read(favoriteNotifierProvider.notifier);

    return Scaffold(
      appBar: _buildAppBar(context, favoriteState, favoriteNotifier),
      body: _buildBodyContent(favoriteState, favoriteNotifier, context),
    );
  }

  // AppBar Metodu
  PreferredSizeWidget _buildAppBar(
      BuildContext context, FavoriteState state, FavoriteNotifier notifier) {
    return AppBar(
      title: const Text('Favori Ürünlerim', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      backgroundColor: AppColors.primary,
      actions: [
        if (state.favorites.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            tooltip: 'Tümünü Temizle',
            onPressed: () {
              _showClearConfirmation(context, notifier);
            },
          ),
      ],
    );
  }

  // Body İçerik Yönetimi Metodu
  Widget _buildBodyContent(
      FavoriteState state, FavoriteNotifier notifier, BuildContext context) {
    if (state.isLoading) {
      return const FavoriteLoadingWidget();
    }

    if (state.error != null) {
      return FavoriteErrorWidget(error: state.error!);
    }

    if (state.favorites.isEmpty) {
      return FavoriteEmptyWidget(notifier: notifier);
    }

    return FavoriteListWidget(
      favorites: state.favorites,
      notifier: notifier,
    );
  }

  // Onay Diyaloğu Metodu
  void _showClearConfirmation(
      BuildContext context, FavoriteNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tümünü Temizle'),
        content: const Text('Tüm favorilerinizi silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              notifier.clearFavorites();
              Navigator.of(context).pop();
            },
            child: const Text('Sil', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}