import 'package:ayssoft/app/data/model/HiveModel/cart.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';

abstract class ICartBaseRepository {
  Future<void> init();
  Cart? getCart();
  Future<void> addProduct(CartProduct product);
  Future<void> removeProduct(int productId);
  Future<void> clearCart();
  Future<void> updateProductQuantity(int productId, int newQuantity);
}