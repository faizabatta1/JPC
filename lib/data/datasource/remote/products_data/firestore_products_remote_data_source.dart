
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/add_product_to_cart_error.dart';
import 'package:jpc/core/error_handling/load_cart_items_error.dart';
import 'package:jpc/data/datasource/remote/products_data/products_remote_data_source.dart';
import 'package:jpc/data/models/cart_item.dart';
import 'package:jpc/data/models/product.dart';

class FirestoreProductsRemoteDataSource implements ProductsRemoteDataSource{

  @override
  Future<Either<AddProductToCartError,bool>> addToCart({required String uid, required CartItem cartItem}) async{
    try{

      List currentProducts = [];
      if(currentProducts.isEmpty){

        return Right(true);
      }

      List matches = currentProducts.where((element) => element['id'] == cartItem.product.id).toList(growable: true);
      if(matches.isEmpty){
        currentProducts.add(cartItem.toMap());

      }else{
        Map match = matches.first;
        CartItem currentCartItem = CartItem.fromMap(match);
        int totalQuantity = currentCartItem.quantity + cartItem.quantity;
        currentCartItem.quantity = totalQuantity;
        currentProducts.removeWhere((element) => element['id'] == cartItem.product.id);
        currentProducts.add(currentCartItem.toMap());

      }

      return Right(true);
    }catch (error){
      return Left(AddProductToCartError('something went wrong while adding product to cart'));
    }
  }

  @override
  Future<void> getProducts(int offset, int limit) {
    throw UnimplementedError();
  }

  @override
  Future<Either<LoadCartItemsError, List<CartItem>>> fetchCartItems({required String uid}) async{
    try{

      if(true){
        return Right([]);
      }else{
        return Left(LoadCartItemsError('something went wrong no cart found'));
      }
    }catch(error){
      print('error');
      return Left(LoadCartItemsError('something went wrong while loading cart items, please try again later'));
    }
  }



}