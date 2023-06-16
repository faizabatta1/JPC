part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class LoadProductsEvent extends ProductsEvent{
  final String categoryId;
  const LoadProductsEvent({ required this.categoryId });

  @override
  List<Object?> get props => [categoryId];
}


class SearchProductsEvent extends ProductsEvent{
  final String query;
  const SearchProductsEvent({ required this.query });

  @override
  List<Object?> get props => [query];
}