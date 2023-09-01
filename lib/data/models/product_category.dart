
class ProductCategory{
  final String name;
  String? id;

  ProductCategory({ required this.name , this.id});

  factory ProductCategory.fromSnapshot(Map snapshot){
    return ProductCategory(name: snapshot['name'],id: snapshot['id']);
  }
}