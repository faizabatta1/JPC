// import 'package:flutter/material.dart';
// import 'package:jpc/core/constants/app_themes.dart';
// import 'package:jpc/domain/cache_manager/cache_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeCacheManager implements CacheManager<ThemeData>{
//   final SharedPreferences sharedPreferences;
//   final String _defaultThem = 'NORMAL_THEME';
//   const ThemeCacheManager({required this.sharedPreferences});
//
//   @override
//   Future<bool> contains(String key) async{
//     return sharedPreferences.containsKey(key);
//   }
//
//   @override
//   Future<bool> delete(String key) async{
//     if(await contains(key)){
//       await sharedPreferences.remove(key);
//
//       return true;
//     }
//
//     return false;
//   }
//
//   @override
//   Future<ThemeData> get(String key) async{
//     String storedTheme = sharedPreferences.getString(key) ?? _defaultThem;
//     return appThemeData[storedTheme] as ThemeData;
//   }
//
//   @override
//   Future<bool> put(String key, ThemeData value) {
//     // TODO: implement put
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<bool> putString(String key, String value) async{
//     return await sharedPreferences.setString('current_theme', value);
//   }
//
// }