import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:flutter/foundation.dart';

/// Favori ürünlerin durumunu tutar
@immutable
class FavoriteState {
  final bool isLoading;
  final String? error;
  final List<FavoriteProduct> favorites;

  const FavoriteState({
    this.isLoading = false,
    this.error,
    this.favorites = const [],
  });

  /// Durumu kopyalamak ve güncellemek için kullanılan metot
  FavoriteState copyWith({
    bool? isLoading,
    String? error,
    List<FavoriteProduct>? favorites,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      error: error, // Hata mesajı null olabilir
      favorites: favorites ?? this.favorites,
    );
  }

  // Debugging için toString
  @override
  String toString() {
    return 'FavoriteState(isLoading: $isLoading, error: $error, favoritesCount: ${favorites.length})';
  }
}