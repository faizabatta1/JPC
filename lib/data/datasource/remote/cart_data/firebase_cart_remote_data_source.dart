import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/decrease_cart_item_error.dart';
import 'package:jpc/core/error_handling/increase_cart_item_error.dart';
import 'package:jpc/data/datasource/remote/cart_data/cart_remote_data_source.dart';

import '../../../models/cart_item.dart';

class FirestoreCartRemoteDataSource implements CartRemoteDataSource{

  @override
  Future<Either<DecreaseCartItemError,bool>> decreaseCartItemQuantity({required String uid, required int productId}) async{
    try{
      return Right(true);

    }catch(decreaseError){
      return Left(DecreaseCartItemError('failed to decrease cart item'));
    }
  }

  @override
  Future<void> deleteAllCartItems({required String uid}) async{

  }

  @override
  Future<void> deleteCartItem({required String uid, required int productId}) async{

  }

  @override
  Future<Either<IncreaseCartItemError,bool>> increaseCartItemQuantity({required String uid, required int productId}) async{
    try{
      return Right(true);
    }catch(increaseError){
      return Left(IncreaseCartItemError('failed to increase cart item'));
    }
  }

}