part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
}

class ProductDetailsInitial extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductDetailsState{
  @override
  List<Object?> get props => [];
}

class ProductAddToCartFailed extends ProductDetailsState{
  final String message;
  const ProductAddToCartFailed({ required this.message });

  @override
  List<Object?> get props => [message];
}

class ProductAddToCartSuccess extends ProductDetailsState{
  final String message;
  const ProductAddToCartSuccess({ required this.message });

  @override
  List<Object?> get props => [message];
}