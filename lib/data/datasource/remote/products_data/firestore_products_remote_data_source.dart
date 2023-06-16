
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/add_product_to_cart_error.dart';
import 'package:jpc/core/error_handling/load_cart_items_error.dart';
import 'package:jpc/data/datasource/remote/products_data/products_remote_data_source.dart';
import 'package:jpc/data/models/cart_item.dart';
import 'package:jpc/data/models/product.dart';

class FirestoreProductsRemoteDataSource implements ProductsRemoteDataSource{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Either<AddProductToCartError,bool>> addToCart({required String uid, required CartItem cartItem}) async{
    try{
      DocumentSnapshot snapshot = await firestore.collection('cart').doc(uid).get();

      List currentProducts = snapshot.get('products') as List;
      if(currentProducts.isEmpty){
        await firestore.collection('cart').doc(uid).set({
          'products': [cartItem.toMap()]
        });

        return Right(true);
      }

      List matches = currentProducts.where((element) => element['id'] == cartItem.product.id).toList(growable: true);
      if(matches.isEmpty){
        currentProducts.add(cartItem.toMap());
        await firestore.collection('cart').doc(uid).update({
          'products': currentProducts
        });
      }else{
        Map match = matches.first;
        CartItem currentCartItem = CartItem.fromMap(match);
        int totalQuantity = currentCartItem.quantity + cartItem.quantity;
        currentCartItem.quantity = totalQuantity;
        currentProducts.removeWhere((element) => element['id'] == cartItem.product.id);
        currentProducts.add(currentCartItem.toMap());

        await firestore.collection('cart').doc(uid).update({
          'products': currentProducts
        });
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
      DocumentSnapshot snapshot = await firestore.collection('cart').doc(uid).get();

      if(snapshot.data() != null){
        List items = snapshot.get('products');
        List<CartItem> cartItems = items.map((item){
          return CartItem.fromMap(item);
        }).toList();
        return Right(cartItems);
      }else{
        return Left(LoadCartItemsError('something went wrong no cart found'));
      }
    }catch(error){
      print('error');
      return Left(LoadCartItemsError('something went wrong while loading cart items, please try again later'));
    }
  }



}