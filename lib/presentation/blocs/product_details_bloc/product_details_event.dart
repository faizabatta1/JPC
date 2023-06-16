part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
}

class AddToCartEvent extends ProductDetailsEvent{
  final CartItem cartItem;
  const AddToCartEvent({ required this.cartItem });

  @override
  List<Object?> get props => [cartItem];
}