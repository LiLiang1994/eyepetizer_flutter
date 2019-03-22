import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:eyepetizer_flutter/api/Api.dart';

class HomeModel extends ChangeNotifier {
  List<ItemListListBean> itemList = List<ItemListListBean>();
  String nextUrl;
  getHomeData(Function success,Function error) async{
    HomeBean homeBean = HomeBean();
    Api().get("http://baobab.kaiyanapp.com/api/v4/tabs/selected", (data) {
      homeBean = HomeBean.fromMap(data);
      nextUrl=homeBean.nextPageUrl;
      homeBean.itemList.forEach((item) {
        if (item != null) itemList.add(item);
      });
      success();
      notifyListeners();
    }, (error) {
      print(error);
    }, () {});
  }
  refreshHomeData(Function success,Function error) async{
    HomeBean homeBean = HomeBean();
    if(nextUrl!=null){
      Api().get(nextUrl, (data) {
        homeBean = HomeBean.fromMap(data);
        nextUrl=homeBean.nextPageUrl;
        homeBean.itemList.forEach((item) {
          if (item != null&&item.type=='video') itemList.add(item);
        });
        success();
        notifyListeners();
      }, (error) {
        print("erro $error");
      }, () {});
    }else{
      error();
    }
  }
}
