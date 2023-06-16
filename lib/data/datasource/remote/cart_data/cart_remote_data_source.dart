import 'package:dartz/dartz.dart';

import '../../../../core/error_handling/decrease_cart_item_error.dart';
import '../../../../core/error_handling/increase_cart_item_error.dart';
import '../../../models/cart_item.dart';

abstract class CartRemoteDataSource{
  Future<Either<IncreaseCartItemError,bool>> increaseCartItemQuantity({ required String uid, required int productId});
  Future<Either<DecreaseCartItemError,bool>> decreaseCartItemQuantity({required String uid, required int productId});

  Future<void> deleteCartItem({required String uid, required int productId});
  Future<void> deleteAllCartItems({required String uid});
}