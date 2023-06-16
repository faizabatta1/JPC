import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/add_product_to_cart_error.dart';
import 'package:jpc/data/models/product.dart';

import '../../../../core/error_handling/load_cart_items_error.dart';
import '../../../models/cart_item.dart';

abstract class ProductsRemoteDataSource{
  Future<void> getProducts(int offset,int limit);
  Future<Either<AddProductToCartError,bool>> addToCart({ required String uid,required CartItem cartItem });
  Future<Either<LoadCartItemsError,List<CartItem>>> fetchCartItems({ required String uid });
}