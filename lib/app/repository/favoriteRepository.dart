// app/data/repository/hive_favorite_repository.dart (Güncellenmiş)
import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:ayssoft/app/repository/Base/favoriteBase.dart'; 
import 'package:hive/hive.dart';

class HiveFavoriteRepository implements IFavoriteBaseRepository {
  static const String _boxName = 'favoriteProductsBox';

  late Box<FavoriteProduct> _box;

  @override
  Future<void> init() async {
    try {
      _box = await Hive.openBox<FavoriteProduct>(_boxName);
    } catch (e) {
      print('Hive init hatası: $e'); 
      rethrow; 
    }
  }

  @override
  Future<void> addFavorite(FavoriteProduct product) async {
    try {
      await _box.put(product.id, product);
    } catch (e) {
      print('Favori ekleme hatası: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFavorite(int productId) async {
    try {
      await _box.delete(productId);
    } catch (e) {
      print('Favori silme hatası: $e');
      rethrow;
    }
  }

  @override
  bool isFavorite(int productId) {
    try {
      return _box.containsKey(productId);
    } catch (e) {
      print('Favori kontrol hatası: $e');
      return false; 
    }
  }

  @override
  List<FavoriteProduct> getAllFavorites() {
    try {
      return _box.values.toList();
    } catch (e) {
      print('Tüm favorileri getirme hatası: $e');
      return []; 
    }
  }

  @override
  Future<void> clearFavorites() async {
    try {
      await _box.clear();
    } catch (e) {
      print('Favorileri temizleme hatası: $e');
      rethrow;
    }
  }
}