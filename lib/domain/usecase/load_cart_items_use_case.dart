import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/add_product_to_cart_error.dart';
import 'package:jpc/core/error_handling/load_cart_items_error.dart';
import 'package:jpc/data/datasource/remote/products_data/firestore_products_remote_data_source.dart';
import 'package:jpc/data/datasource/remote/users_data/firestore_users_remote_data_source.dart';
import 'package:jpc/data/models/cart_item.dart';

import '../../core/use_case/use_case.dart';



class LoadCartItemsUseCase implements UseCase<LoadCartItemsError,List<CartItem>>{
  final FirestoreProductsRemoteDataSource firestoreProductsRemoteDataSource;
  final String uid;

  LoadCartItemsUseCase({
    required this.firestoreProductsRemoteDataSource,
    required this.uid,
  });

  @override
  Future<Either<LoadCartItemsError, List<CartItem>>> execute() async{
    Either<LoadCartItemsError,List<CartItem>> result = await firestoreProductsRemoteDataSource.fetchCartItems(uid: uid);

    return result;
  }
}