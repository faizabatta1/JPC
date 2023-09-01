
class Product{
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final bool hasDiscount;
  final int discount;
  final int id;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.hasDiscount,
    required this.discount,
    required this.id
  });
  
  factory Product.fromSnapshot(Map data){

    return Product(
      name: data['name'],
      description: data['description'],
      price: data['price'],
      imageUrl: data['imageUrl'],
      hasDiscount: data['hasDiscount'],
      discount: data['discount'],
      id: data['id']
    );
  }

  factory Product.fromMap(Map map){
    return Product(
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      hasDiscount: map['hasDiscount'],
      discount: map['discount'],
      id: map['id']
    );
  }

  toMap(){
    return{
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'hasDiscount': hasDiscount,
      'discount':discount,
      'id': id
    };
  }
}