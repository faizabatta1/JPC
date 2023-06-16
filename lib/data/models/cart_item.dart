import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jpc/data/models/product.dart';

class CartItem{
  final Product product;
  int quantity = 0;

  CartItem({
    required this.product,
    required this.quantity
  });

  factory CartItem.fromMap(Map map){
    return CartItem(
      product: Product.fromMap(map),
      quantity: map['quantity']
    );
  }

  factory CartItem.fromSnapshot(QueryDocumentSnapshot snapshot){
    return CartItem(
        product: Product.fromSnapshot(snapshot),
        quantity: snapshot.get('quantity')
    );
  }

  toMap(){
    return{
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'hasDiscount': product.hasDiscount,
      'discount':product.discount,
      'quantity': quantity,
      'id':product.id
    };
  }
}