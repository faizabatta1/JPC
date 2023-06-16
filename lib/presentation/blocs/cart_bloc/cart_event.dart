part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class LoadCartItems extends CartEvent{
  final String uid;
  const LoadCartItems({ required this.uid });

  @override
  List<Object?> get props => [uid];
}

class IncreaseQuantityEvent extends CartEvent{
  final String uid;
  final int productId;

  const IncreaseQuantityEvent({ required this.productId, required this.uid });

  @override
  List<Object?> get props => [uid,productId];
}

class DecreaseQuantityEvent extends CartEvent{
  final String uid;
  final int productId;

  const DecreaseQuantityEvent({ required this.uid, required this.productId });

  @override
  List<Object?> get props => [uid,productId];
}

class DeleteCartItemEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}

class DeleteAllCartItemsEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}