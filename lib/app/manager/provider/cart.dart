import 'package:ayssoft/app/core/storage/carts.dart';
import 'package:ayssoft/app/manager/riverpod/cart.dart';
import 'package:ayssoft/app/manager/state/cartState.dart';
import 'package:ayssoft/app/repository/Base/cartBase.dart';
import 'package:ayssoft/app/repository/cartRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final cartRepositoryProvider = Provider<ICartBaseRepository>((ref) {
  return CartRepository(CartManager());
});

final cartNotifierProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return CartNotifier(repository);
});

final cartTotalQuantityProvider = Provider<int>((ref) {
  return ref.watch(cartNotifierProvider.select((state) => state.cart?.totalQuantity ?? 0));
});

final cartTotalDiscountedProvider = Provider<double>((ref) {
  return ref.watch(cartNotifierProvider.select((state) => state.cart?.discountedTotal ?? 0.0));
});

final cartIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(cartNotifierProvider.select((state) => state.isLoading));
});