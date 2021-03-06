import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio dio;
  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/' ,

        receiveDataWhenStatusError: true,

      ),
    );



  }
  static Future<Response> getData({String token,String lang='en',@required String url, Map<String,dynamic> query}) async
  {
    dio.options.headers=
         {
           'Content-Type':'application/json',
          'lang':lang,
          'Authorization':token?? '',

        };
   return await dio.get(url,queryParameters: query);
  }


  static Future<Response> postData({String token,String lang='en',@required String url, Map<String,dynamic> query,@required Map<String,dynamic> data})async
  {
    dio.options.headers=
  {
    'Content-Type':'application/json',
    'lang':lang,
    'Authorization':token??'',

  };
    return await dio.post(url,data: data);
  }




  static Future<Response> updateData({String token,String lang='en',@required String url, Map<String,dynamic> query,@required Map<String,dynamic> data})async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',

    };
    return await dio.put(url,data: data);
  }
}