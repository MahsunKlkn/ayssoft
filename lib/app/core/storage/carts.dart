import 'package:ayssoft/app/data/model/HiveModel/cart.dart';
import 'package:hive/hive.dart';

class CartManager {
  static const String _boxName = 'cartBox';
  static const String _cartKey = 'myCart';

  late Box<Cart> _box;

  Future<void> init() async {
    _box = await Hive.openBox<Cart>(_boxName);
  }

  Cart? getCart() {
    return _box.get(_cartKey);
  }

  Future<void> saveCart(Cart cart) async {
    await _box.put(_cartKey, cart);
  }

  Future<void> deleteCart() async {
    await _box.delete(_cartKey);
  }
}
