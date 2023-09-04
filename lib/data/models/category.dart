class Category{
  final String name;
  final String? image;

  const Category({ required this.name, required this.image });

  factory Category.fromJson(Map data){
    return Category(name: data['name'], image: data['image']);
  }
}