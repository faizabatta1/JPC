import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/data/models/product_category.dart';

import '../../../data/datasource/remote/products_data/firestore_products_remote_data_source.dart';
import '../../../data/models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductState> {
  final int maxProductsPerFrame = 20;
  ProductsBloc() : super(const ProductState()) {

    FirestoreProductsRemoteDataSource firestoreProductsRemoteDataSource = FirestoreProductsRemoteDataSource();


    on<LoadProductsEvent>((event, emit) async{
      emit(state.copyWith(status:  ProductsStatus.loading));
      return await Future.delayed(Duration(seconds: 3),()async{
        QuerySnapshot data = await FirebaseFirestore.instance
            .collection('products-categories')
            .doc(event.categoryId)
            .collection('products')
            .get();
        List<QueryDocumentSnapshot> docs = data.docs;
        List<Product> products = docs.map((e) => Product.fromSnapshot(e)).toList();

        if(products.isEmpty){
          return emit(
              state.copyWith(status: ProductsStatus.empty)
          );
        }
        return emit(state.copyWith(
            products: products,
            status: ProductsStatus.success,
          categoryId: event.categoryId
        ));
      });
    });

    on<SearchProductsEvent>((event,emit) async{
      emit(state.copyWith(status: ProductsStatus.loading));

      List<Product> results = state.products.where((element) => element.name.toLowerCase().contains(event.query.toLowerCase())).toList();
      QuerySnapshot data = await FirebaseFirestore.instance
          .collection('products-categories')
          .doc(state.categoryId)
          .collection('products')
          .get();
      List<QueryDocumentSnapshot> docs = data.docs;
      List<Product> products = docs.map((e) => Product.fromSnapshot(e)).toList();

      if(event.query.isEmpty) return emit(state.copyWith(products: products,status: ProductsStatus.success));
      if(results.isEmpty){
        return emit(
          state.copyWith(status: ProductsStatus.emptySearch)
        );
      }

      return emit(state.copyWith(products: results,status: ProductsStatus.success));
    });
  }
}
