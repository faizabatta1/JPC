import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/add_product_to_cart_error.dart';
import 'package:jpc/data/datasource/remote/products_data/firestore_products_remote_data_source.dart';
import 'package:jpc/data/datasource/remote/users_data/firestore_users_remote_data_source.dart';
import 'package:jpc/data/models/cart_item.dart';

import '../../core/use_case/use_case.dart';
import 'package:jpc/core/error_handling/user_login_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/use_case/use_case_params.dart';
import '../../data/entities/user_auth_credentials.dart';
import '../../data/models/product.dart';
import '../../data/repositories/user_authentication_repository_impl.dart';



class AddToCartUseCase implements UseCase<AddProductToCartError,void>{
  final FirestoreProductsRemoteDataSource firestoreProductsRemoteDataSource;
  final String uid;
  final CartItem cartItem;

  AddToCartUseCase({
    required this.firestoreProductsRemoteDataSource,
    required this.uid,
    required this.cartItem
  });

  @override
  Future<Either<AddProductToCartError, void>> execute() async{
    Either<AddProductToCartError,void> result = await firestoreProductsRemoteDataSource.addToCart(
        uid: uid, cartItem: cartItem);

    return result;
  }
}