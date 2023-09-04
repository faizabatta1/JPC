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
      product: Product.fromJson(map),
      quantity: map['quantity']
    );
  }

  factory CartItem.fromSnapshot(Map json){
    return CartItem(
        product: Product.fromJson(json),
        quantity: json['quantity']
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