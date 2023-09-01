import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/core/error_handling/add_product_to_cart_error.dart';
import 'package:jpc/data/datasource/remote/products_data/firestore_products_remote_data_source.dart';
import 'package:jpc/data/models/cart_item.dart';

import '../../../data/models/product.dart';
import '../../../domain/usecase/add_to_cart_use_case.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<AddToCartEvent>((event, emit) async {
      emit(ProductLoading());
      AddToCartUseCase addToCartUseCase = AddToCartUseCase(
        cartItem: event.cartItem,
        uid: '',
        firestoreProductsRemoteDataSource: FirestoreProductsRemoteDataSource()
      );

      Either<AddProductToCartError,void> result = await addToCartUseCase.execute();
      result.fold(
              (l){
                return emit(ProductAddToCartFailed(message: l.message));
              },
              (r) => emit(ProductAddToCartSuccess(message: '${event.cartItem.product.name} was added to cart!'))
      );
    });
  }
}
