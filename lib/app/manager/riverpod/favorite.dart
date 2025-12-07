import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:ayssoft/app/manager/provider/favorite.dart';
import 'package:ayssoft/app/manager/state/favoriteState.dart';
import 'package:ayssoft/app/repository/Base/favoriteBase.dart';
import 'package:flutter_riverpod/legacy.dart';
class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final IFavoriteBaseRepository _repository;

  FavoriteNotifier(this._repository) : super(const FavoriteState()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.init();
      final favorites = _repository.getAllFavorites();
      state = state.copyWith(favorites: favorites, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Favoriler yüklenirken hata oluştu: $e');
    }
  }

  Future<void> toggleFavorite(FavoriteProduct product) async {
    final isAlreadyFavorite = _repository.isFavorite(product.id);

    if (isAlreadyFavorite) {
      await removeFavorite(product.id);
    } else {
      await addFavorite(product);
    }
  }

  Future<void> addFavorite(FavoriteProduct product) async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.addFavorite(product);
      final updatedFavorites = _repository.getAllFavorites();
      state = state.copyWith(favorites: updatedFavorites, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Favori eklenirken hata oluştu: $e');
    }
  }

  Future<void> removeFavorite(int productId) async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.removeFavorite(productId);
      final updatedFavorites = _repository.getAllFavorites();
      state = state.copyWith(favorites: updatedFavorites, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Favori silinirken hata oluştu: $e');
    }
  }

  bool isFavorite(int productId) {
    return _repository.isFavorite(productId);
  }

  Future<void> clearFavorites() async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.clearFavorites();
      state = state.copyWith(favorites: [], isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Favoriler temizlenirken hata oluştu: $e');
    }
  }
}

final favoriteNotifierProvider = StateNotifierProvider<FavoriteNotifier, FavoriteState>((ref) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return FavoriteNotifier(repository);
});