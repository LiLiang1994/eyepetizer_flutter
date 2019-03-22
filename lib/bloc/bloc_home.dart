import 'package:eyepetizer_flutter/repository/home_repository.dart';

import 'bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:eyepetizer_flutter/beans//home_bean.dart';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'dart:io';

class BlocHome implements BlocBase {
  PublishSubject<List<ItemListListBean>> homeSubject =
      PublishSubject<List<ItemListListBean>>();

  Sink<List<ItemListListBean>> get homeSink => homeSubject.sink;

  Stream<List<ItemListListBean>> get homeStream => homeSubject.stream;

  BlocHome(){
    getHomeData();
    print("blochome");
  }

  @override
  void dispose() {
    homeSubject.close();
  }

  HomeRepository _homeRepository = new HomeRepository();

  Future getHomeData() async {
    Dio dio = new Dio(new BaseOptions(
        baseUrl: "http://baobab.kaiyanapp.com/api/v4",
        headers: {
          "user-agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:65.0) Gecko/20100101 Firefox/65.0"
        },
        contentType: ContentType.parse("application/json"),
        responseType: ResponseType.json));
    Response response = await dio.get("/tabs/selected");
    HomeBean homeMode = HomeBean.fromMap(response.data);
    List<ItemListListBean> list=[];
    homeMode.itemList.forEach((item){
      if(item!=null)
        list.add(item);
    });
    homeSink.add(list);
//    }).catchError((error){
//    _homeRepository.getVideoList().then((list){
//      print(list.length);
//      homeSink.add(UnmodifiableListView<ItemListListBean>(list));
//    }).catchError((error){
//
//    });
  }
}
