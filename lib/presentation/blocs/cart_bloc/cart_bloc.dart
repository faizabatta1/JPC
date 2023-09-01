import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/core/error_handling/decrease_cart_item_error.dart';
import 'package:jpc/core/error_handling/increase_cart_item_error.dart';
import 'package:jpc/data/datasource/remote/cart_data/firebase_cart_remote_data_source.dart';
import 'package:jpc/data/datasource/remote/products_data/firestore_products_remote_data_source.dart';
import 'package:jpc/data/models/cart_item.dart';
import 'package:jpc/domain/usecase/decrease_cart_item_use_case.dart';
import 'package:jpc/domain/usecase/increase_cart_item_use_case.dart';
import 'package:jpc/domain/usecase/load_cart_items_use_case.dart';

import '../../../core/error_handling/load_cart_items_error.dart';
import '../../../data/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCartItems>((event, emit) async{
      // emit(CartLoading());

      LoadCartItemsUseCase loadCartItemsUseCase = LoadCartItemsUseCase(
          firestoreProductsRemoteDataSource: FirestoreProductsRemoteDataSource(),
          uid: event.uid
      );

      Either<LoadCartItemsError,List<CartItem>> result = await loadCartItemsUseCase.execute();
      result.fold(
              (error) => emit(CartLoadFail(message: error.message)),
              (products){
                if(products.isEmpty){
                  emit(CartIsEmpty(message: 'no items yet go shopping now'));
                }else{
                  emit(CartLoadSuccess(cartItems: products));
                }
              }
      );
    });

    on<IncreaseQuantityEvent>((event,emit) async{
      IncreaseCartItemUseCase increaseCartItemUseCase = IncreaseCartItemUseCase(
        firestoreCartRemoteDataSource: FirestoreCartRemoteDataSource(),
        productId: event.productId,
        uid: ''
      );

      Either<IncreaseCartItemError,bool> response = await increaseCartItemUseCase.execute();

      response.fold(
              (increaseError){
                emit(CartItemIncreaseError(message: increaseError.message));
                add(LoadCartItems(uid: ''));
              },
              (success){
                add(LoadCartItems(uid: ''));
              }
      );
    });

    on<DecreaseQuantityEvent>((event,emit) async{
      DecreaseCartItemUseCase decreaseCartItemUseCase = DecreaseCartItemUseCase(
        firestoreCartRemoteDataSource: FirestoreCartRemoteDataSource(),
        uid: '',
        productId: event.productId
      );

      Either<DecreaseCartItemError,bool> response = await decreaseCartItemUseCase.execute();

      response.fold(
              (increaseError){
                emit(CartDecreaseItemError(message: increaseError.message));
                add(LoadCartItems(uid: ''));
              },
              (success){
                add(LoadCartItems(uid: ''));
              }
      );
    });

    on<DeleteAllCartItemsEvent>((event,emit) async{
      return emit(CartIsEmpty(message: 'Your Cart Is Empty'));
    });
  }
}
