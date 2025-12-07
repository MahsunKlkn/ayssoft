import 'package:ayssoft/app/core/storage/carts.dart';
import 'package:ayssoft/app/data/model/HiveModel/cart.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:ayssoft/app/repository/Base/cartBase.dart';

class CartRepository implements ICartBaseRepository {
  final CartManager _manager;

  CartRepository(this._manager);

  @override
  Future<void> init() async {
    await _manager.init();
  }

  @override
  Cart? getCart() {
    return _manager.getCart();
  }

  @override
  Future<void> addProduct(CartProduct product) async {
    final cart = _manager.getCart();

    if (cart == null) {
      final newCart = Cart(
        id: DateTime.now().millisecondsSinceEpoch,
        products: [product],
        total: product.total,
        discountedTotal: product.discountedTotal,
        userId: 0,
        totalProducts: 1,
        totalQuantity: product.quantity,
      );

      await _manager.saveCart(newCart);
      return;
    }

    final products = List<CartProduct>.from(cart.products);

    final index = products.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final existing = products[index];
      final updatedQuantity = existing.quantity + product.quantity;

      products[index] = CartProduct(
        id: existing.id,
        title: existing.title,
        price: existing.price,
        quantity: updatedQuantity,
        total: existing.price * updatedQuantity,
        discountPercentage: existing.discountPercentage,
        discountedTotal: (existing.price * updatedQuantity) *
            (1 - existing.discountPercentage / 100),
        thumbnail: existing.thumbnail,
      );
    } else {
      products.add(product);
    }

    await _manager.saveCart(
      _recalculateCart(cart.id, cart.userId, products),
    );
  }

  @override
  Future<void> updateProductQuantity(int productId, int newQuantity) async {
    final cart = _manager.getCart();
    if (cart == null) return;

    final products = List<CartProduct>.from(cart.products);

    final index = products.indexWhere((p) => p.id == productId);

    if (index == -1) return;

    final existing = products[index];

    final total = existing.price * newQuantity;
    final discountedTotal =
        total * (1 - existing.discountPercentage / 100);

    products[index] = CartProduct(
      id: existing.id,
      title: existing.title,
      price: existing.price,
      quantity: newQuantity,
      total: total,
      discountPercentage: existing.discountPercentage,
      discountedTotal: discountedTotal,
      thumbnail: existing.thumbnail,
    );

    await _manager.saveCart(
      _recalculateCart(cart.id, cart.userId, products),
    );
  }

  @override
  Future<void> removeProduct(int productId) async {
    final cart = _manager.getCart();
    if (cart == null) return;

    final products =
        cart.products.where((p) => p.id != productId).toList();

    await _manager.saveCart(
      _recalculateCart(cart.id, cart.userId, products),
    );
  }

  @override
  Future<void> clearCart() async {
    await _manager.deleteCart();
  }

  // -------------------------
  // 🔥 Ortak hesaplama fonksiyonu
  // -------------------------
  Cart _recalculateCart(int id, int userId, List<CartProduct> products) {
    return Cart(
      id: id,
      products: products,
      total: products.fold(0.0, (sum, p) => sum + p.total),
      discountedTotal:
          products.fold(0.0, (sum, p) => sum + p.discountedTotal),
      userId: userId,
      totalProducts: products.length,
      totalQuantity:
          products.fold(0, (sum, p) => sum + p.quantity),
    );
  }
}
