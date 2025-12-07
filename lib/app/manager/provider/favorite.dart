import 'package:ayssoft/app/manager/riverpod/favorite.dart';
import 'package:ayssoft/app/manager/state/favoriteState.dart';
import 'package:ayssoft/app/repository/Base/favoriteBase.dart';
import 'package:ayssoft/app/repository/favoriteRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
final favoriteRepositoryProvider = Provider<IFavoriteBaseRepository>((ref) {
  return HiveFavoriteRepository();
});
final favoriteNotifierProvider = StateNotifierProvider<FavoriteNotifier, FavoriteState>((ref) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return FavoriteNotifier(repository);
});


final favoriteListProvider = Provider<List<int>>((ref) {
  return ref.watch(favoriteNotifierProvider.select((state) => state.favorites.map((p) => p.id).toList()));
});

final favoriteIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(favoriteNotifierProvider.select((state) => state.isLoading));
});