part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoaded extends ProductsState{
  final List<Product> products;
  const ProductsLoaded({required this.products});

  @override
  List<Object?> get props => [];
}

class ProductsAreEmpty extends ProductsState{
  @override
  List<Object?> get props => [];
}

enum FilterType {ascending,descending}
enum ProductsStatus {initial,loading,success,error,empty,emptySearch}

class ProductState extends Equatable{
  final ProductsStatus status;
  final FilterType filter;
  final List<Product> products;
  final String error;
  final bool hasReachedMax;
  final String category;
  final String categoryId;

  const ProductState({
    this.status = ProductsStatus.initial,
    this.filter = FilterType.ascending,
    this.products = const [],
    this.error = "",
    this.hasReachedMax = false,
    this.category = 'any',
    this.categoryId = ''
  });

  ProductState copyWith({
    ProductsStatus? status,
    FilterType? filter,
    String? category,
    List<Product>? products,
    String? error,
    bool? hasReachedMax,
    String? categoryId
  }){
    return ProductState(
      filter: filter?? this.filter,
      status: status?? this.status,
      products: products?? this.products,
      error: error?? this.error,
      hasReachedMax: hasReachedMax?? this.hasReachedMax,
      category: category?? this.category,
      categoryId: categoryId?? this.categoryId,
    );
  }
  @override
  List<Object?> get props => [filter,status,products,error,hasReachedMax,category];
}