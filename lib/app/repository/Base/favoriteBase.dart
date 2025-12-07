import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';

abstract class IFavoriteBaseRepository {
  Future<void> init();
  Future<void> addFavorite(FavoriteProduct product);
  Future<void> removeFavorite(int productId);
  bool isFavorite(int productId);
  List<FavoriteProduct> getAllFavorites();
  Future<void> clearFavorites();
}