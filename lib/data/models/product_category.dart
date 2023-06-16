import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategory{
  final String name;
  String? id;

  ProductCategory({ required this.name , this.id});

  factory ProductCategory.fromSnapshot(QueryDocumentSnapshot snapshot){
    return ProductCategory(name: snapshot.get('name'),id: snapshot.id);
  }
}