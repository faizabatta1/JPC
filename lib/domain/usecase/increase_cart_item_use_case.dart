import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/add_product_to_cart_error.dart';
import 'package:jpc/core/error_handling/increase_cart_item_error.dart';
import 'package:jpc/core/error_handling/load_cart_items_error.dart';
import 'package:jpc/data/datasource/remote/cart_data/firebase_cart_remote_data_source.dart';
import 'package:jpc/data/datasource/remote/products_data/firestore_products_remote_data_source.dart';
import 'package:jpc/data/datasource/remote/users_data/firestore_users_remote_data_source.dart';
import 'package:jpc/data/models/cart_item.dart';
import '../../core/use_case/use_case.dart';



class IncreaseCartItemUseCase implements UseCase<IncreaseCartItemError,bool>{
  final FirestoreCartRemoteDataSource firestoreCartRemoteDataSource;
  final String uid;
  final int productId;

  IncreaseCartItemUseCase({
    required this.firestoreCartRemoteDataSource,
    required this.uid,
    required this.productId
  });

  @override
  Future<Either<IncreaseCartItemError, bool>> execute() async{
    Either<IncreaseCartItemError,bool> result = await firestoreCartRemoteDataSource.increaseCartItemQuantity(uid: uid,productId: productId);

    return result;
  }
}