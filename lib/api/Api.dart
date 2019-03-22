import 'dart:io';

import 'package:dio/dio.dart';

class Api {
  void get(String url, Function success, Function error, Function empty) async {
    Dio dio = new Dio(new BaseOptions(
//        baseUrl: "http://baobab.kaiyanapp.com/api/v4",
        headers: {
          "user-agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:65.0) Gecko/20100101 Firefox/65.0"
        },
        contentType: ContentType.parse("application/json"),
        responseType: ResponseType.json));
    Response response = await dio.get(url).catchError((error){
      print("dio error $error");
    });
    int code = response.statusCode;
    if (code >= 200 && code <= 300) {
      Map<String, dynamic> data = response.data;
      if (data.isNotEmpty) {
        success(data);
      } else {
        empty();
      }
    } else {
      error("请求失败:$code");
    }
  }
}
