import 'package:dartz/dartz.dart';
import 'package:jpc/core/error_handling/add_product_to_cart_error.dart';
import 'package:jpc/core/error_handling/decrease_cart_item_error.dart';
import 'package:jpc/core/error_handling/increase_cart_item_error.dart';
import 'package:jpc/core/error_handling/load_cart_items_error.dart';
import 'package:jpc/data/datasource/remote/cart_data/firebase_cart_remote_data_source.dart';
import 'package:jpc/data/datasource/remote/products_data/firestore_products_remote_data_source.dart';
import 'package:jpc/data/datasource/remote/users_data/firestore_users_remote_data_source.dart';
import 'package:jpc/data/models/cart_item.dart';
import '../../core/use_case/use_case.dart';



class DecreaseCartItemUseCase implements UseCase<DecreaseCartItemError,bool>{
  final FirestoreCartRemoteDataSource firestoreCartRemoteDataSource;
  final String uid;
  final int productId;

  DecreaseCartItemUseCase({
    required this.firestoreCartRemoteDataSource,
    required this.uid,
    required this.productId
  });

  @override
  Future<Either<DecreaseCartItemError, bool>> execute() async{
    Either<DecreaseCartItemError,bool> result = await firestoreCartRemoteDataSource.decreaseCartItemQuantity(uid: uid,productId: productId);

    return result;
  }
}