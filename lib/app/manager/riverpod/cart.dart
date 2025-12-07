import 'package:ayssoft/app/manager/state/cartState.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:ayssoft/app/repository/Base/cartBase.dart';
import 'package:flutter_riverpod/legacy.dart';

class CartNotifier extends StateNotifier<CartState> {
  final ICartBaseRepository _repository;

  CartNotifier(this._repository) : super( CartState()) { 
    _loadCart();
  }

  Future<void> _loadCart() async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.init();
      final cart = _repository.getCart();
      state = state.copyWith(cart: cart, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> addProduct(CartProduct product) async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.addProduct(product);
      final cart = _repository.getCart();
      state = state.copyWith(cart: cart, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> removeProduct(int productId) async {
  try {
    await _repository.removeProduct(productId);
    final cart = _repository.getCart();
    state = state.copyWith(cart: cart); 
  } catch (e) {
    // Hata işleme
  }
}

  Future<void> updateProductQuantity(int productId, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeProduct(productId);
      return;
    }

    try {
      await _repository.updateProductQuantity(productId, newQuantity);
      final cart = _repository.getCart();
      state = state.copyWith(cart: cart); 
      
    } catch (e) {
      // Hata işleme ekleyebilirsiniz
    }
  }

  Future<void> clearCart() async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.clearCart();
      state = state.copyWith(cart: null, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}