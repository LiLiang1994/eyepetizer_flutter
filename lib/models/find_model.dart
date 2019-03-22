import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:eyepetizer_flutter/api/Api.dart';
import 'package:flutter/material.dart';
import 'package:eyepetizer_flutter/beans/find_bean.dart';

class FindModel extends ChangeNotifier {
  List<CategoryBean> list = [];
  String nextPage;
  //todo 一次性加载所有的种类
  getFindDate() {
    Api().get("http://baobab.kaiyanapp.com/api/v4/discovery/category", (data) {
      FindBean findBean = FindBean(data);
      nextPage=findBean.nextPageUrl;
      findBean.itemList.forEach((item) {
        if (item != null) list.add(item);
      });
//      while(nextPage!=null){
//        Api().get(nextPage, (data) {
//          FindBean findBean = FindBean(data);
//          nextPage=findBean.nextPageUrl;
//          findBean.itemList.forEach((item) {
//            list.add(item);
//          });
//        }, (error) {}, () {});
//      }
      notifyListeners();
    }, (error) {}, () {});
  }
  getNextFindDate(Function success,Function error){
    if(nextPage!=null){
      print("next$nextPage");
      Api().get(nextPage, (data) {
        FindBean findBean = FindBean(data);
        nextPage=findBean.nextPageUrl;
        findBean.itemList.forEach((item) {
          if (item != null) list.add(item);
        });
        print(list.length);
        success();
        notifyListeners();
      }, (error) {}, () {});
    }else{
      error();
    }

  }
}
