part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadSuccess extends CartState{
  final List<CartItem> cartItems;
  const CartLoadSuccess({ required this.cartItems });

  @override
  List<Object?> get props => [cartItems];
}

class CartLoadFail extends CartState{
  final String message;
  const CartLoadFail({ required this.message });

  @override
  List<Object?> get props => [message];
}

class CartLoading extends CartState{
  @override
  List<Object?> get props => [];
}

class CartIsEmpty extends CartState{
  final String message;
  const CartIsEmpty({ required this.message });

  @override
  List<Object?> get props => [];
}

class CartItemIncreaseError extends CartState{
  final String message;
  const CartItemIncreaseError({ required this.message });

  @override
  List<Object?> get props => [message];
}

class CartDecreaseItemError extends CartState{
  final String message;
  const CartDecreaseItemError({ required this.message });

  @override
  List<Object?> get props => [message];
}

class CartIncreaseItemSuccess extends CartState{
  @override
  List<Object?> get props => [];
}

class CartDecreaseItemSuccess extends CartState{
  @override
  List<Object?> get props => [];
}