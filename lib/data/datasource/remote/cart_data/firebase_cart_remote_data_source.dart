import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/decrease_cart_item_error.dart';
import 'package:jpc/core/error_handling/increase_cart_item_error.dart';
import 'package:jpc/data/datasource/remote/cart_data/cart_remote_data_source.dart';

import '../../../models/cart_item.dart';

class FirestoreCartRemoteDataSource implements CartRemoteDataSource{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Either<DecreaseCartItemError,bool>> decreaseCartItemQuantity({required String uid, required int productId}) async{
    try{
      DocumentSnapshot snapshot = await firestore.collection('cart').doc(uid).get();
      List currentProducts = snapshot.get('products');
      List matches = currentProducts.where((element) => element['id'] == productId).toList(growable: true);
      Map match = matches.first;
      CartItem currentCartItem = CartItem.fromMap(match);
      if(currentCartItem.quantity > 1){
        int totalQuantity = currentCartItem.quantity - 1;
        currentCartItem.quantity = totalQuantity;
        currentProducts.removeWhere((element) => element['id'] == productId);
        currentProducts.add(currentCartItem.toMap());

        await firestore.collection('cart').doc(uid).update({
          'products': currentProducts
        });
      }else{
        return Left(DecreaseCartItemError("you can't decrease anymore"));
      }

      return Right(true);

    }catch(decreaseError){
      return Left(DecreaseCartItemError('failed to decrease cart item'));
    }
  }

  @override
  Future<void> deleteAllCartItems({required String uid}) async{
    DocumentReference snapshot = firestore.collection('cart').doc(uid);
    await snapshot.update({
      'products': []
    });
  }

  @override
  Future<void> deleteCartItem({required String uid, required int productId}) async{
    DocumentSnapshot snapshot = await firestore.collection('cart').doc(uid).get();
    List currentProducts = snapshot.get('products');
    currentProducts.removeWhere((element) => element['id'] == productId);

    await firestore.collection('cart').doc(uid).update({
      'products': currentProducts
    });
  }

  @override
  Future<Either<IncreaseCartItemError,bool>> increaseCartItemQuantity({required String uid, required int productId}) async{
    try{
      DocumentSnapshot snapshot = await firestore.collection('cart').doc(uid).get();
      List currentProducts = snapshot.get('products');
      List matches = currentProducts.where((element) => element['id'] == productId).toList(growable: true);
      Map match = matches.first;
      CartItem currentCartItem = CartItem.fromMap(match);
      int totalQuantity = currentCartItem.quantity + 1;
      currentCartItem.quantity = totalQuantity;
      currentProducts.removeWhere((element) => element['id'] == productId);
      currentProducts.add(currentCartItem.toMap());

      await firestore.collection('cart').doc(uid).update({
        'products': currentProducts
      });


      // QuerySnapshot cart = await firestore.collection('cart').get();
      // List<QueryDocumentSnapshot> docs = cart.docs;
      // List<CartItem> cartItems = docs.map((e) => CartItem.fromSnapshot(e)).toList();
      return Right(true);
    }catch(increaseError){
      return Left(IncreaseCartItemError('failed to increase cart item'));
    }
  }

}