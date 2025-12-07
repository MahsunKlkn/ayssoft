import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:hive/hive.dart';

class FavoriteManager {
  // Hive kutusu için benzersiz bir isim
  static const String _boxName = 'favoriteProductsBox';

  late Box<FavoriteProduct> _box;

  Future<void> init() async {
    _box = await Hive.openBox<FavoriteProduct>(_boxName);
  }

  Future<void> addFavorite(FavoriteProduct product) async {
    await _box.put(product.id, product);
  }

  Future<void> removeFavorite(int productId) async {
    await _box.delete(productId);
  }

  bool isFavorite(int productId) {
    return _box.containsKey(productId);
  }

  List<FavoriteProduct> getAllFavorites() {
    return _box.values.toList();
  }

  Future<void> clearFavorites() async {
    await _box.clear();
  }
}