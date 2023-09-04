import 'dart:convert';

import 'package:jpc/core/constants/app_constants.dart';
import 'package:jpc/data/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryData {
  static Future<List<Category>> getAllCategories() async{
    try{
      final Uri uri = Uri.parse("$baseUrl/categories");
      final response = await http.get(uri);
      List results = jsonDecode(response.body);

      List<Category> categories = results.map((e) => Category.fromJson(e)).toList();
      return categories;
    }catch(error){
      return [];
    }
  }
}