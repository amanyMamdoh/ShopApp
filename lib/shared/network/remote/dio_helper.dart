
import 'dart:io';

import 'package:dio/dio.dart';


class DioHelper{
  static  late Dio dio;

  static init(){
     dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,

      )
    );
  }

 static Future<Response> getData(
     {
     required String path,
      Map <String,dynamic>? query,
       String token=''
     }
    ) async {
    dio.options.headers={
      'lang':"en",
      'Authorization':token,
      'Content-Type':'application/json'
    };

    return await dio.get(path,queryParameters: query??null);
}
static Future<Response> postData({
  required String url,
  required Map<String,dynamic> data,
  Map <String,dynamic>? query,
  String token=''
}) async{
  dio.options.headers={
    'lang':"en",
    'Authorization':token,
    'Content-Type':'application/json'
  };
    return await dio.post(
      url,
      data: data,
      queryParameters: query
    );
}

}