import 'dart:convert';

import 'package:jpc/core/constants/app_constants.dart';
import 'package:jpc/data/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsData{
  static Future<List<Product>> getAllProductsByCategory(String categoryId) async{
    try{
      final Uri uri = Uri.parse("$baseUrl/products/category/$categoryId");
      final response = await http.get(uri);
      return (jsonDecode(response.body) as List<Map<String,dynamic>>).map((e){
        return Product.fromJson(e);
      }).toList();
    }catch(error){
      return [];
    }
  }
}