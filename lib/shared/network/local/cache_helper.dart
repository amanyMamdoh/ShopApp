import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper {
  static  SharedPreferences? shared;
  static init()async  {
    shared = await SharedPreferences.getInstance();
}
  static Future <bool> putData({
    required String key,
    required bool value})async
  {
    return await shared!.setBool(key, value);
  }


  static Future<bool> saveData({
  required String key,
    required dynamic value
})async{
    if(value is String) return await shared!.setString(key, value);
    if(value is int) return await shared!.setInt(key, value);
    if(value is bool) return await shared!.setBool(key, value);

      return await shared!.setDouble(key, value);
  }
  static dynamic? getData({
  required String key
}){
    return shared!.get(key);
}
  static bool? getBooleanData({
    required String key
  }) {
    return shared!.getBool(key);
  }
  static int? getIntData({
    required String key
  }) {
    return shared!.getInt(key);
  }
  static String? getStringData({
    required String key
  }) {
    return shared!.getString(key);
  }
  static double? getDoubleData({
    required String key
  }) {
    return shared!.getDouble(key);
  }
  static Future<bool> removeData({
  required String key
})async{
     return await shared!.remove(key);
  }
}