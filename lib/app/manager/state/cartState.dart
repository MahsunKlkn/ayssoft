import 'package:ayssoft/app/data/model/HiveModel/cart.dart';
class CartState {
  final Cart? cart;
  final bool isLoading;
  final String? errorMessage;

  CartState({
    this.cart,
    this.isLoading = false,
    this.errorMessage,
  });

  CartState copyWith({
    Cart? cart,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
