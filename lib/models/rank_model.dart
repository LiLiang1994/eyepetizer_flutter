import 'package:eyepetizer_flutter/api/Api.dart';
import 'package:eyepetizer_flutter/beans/rank_bean.dart';
import 'package:flutter/material.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';

class RankModel extends ChangeNotifier {
  List<ItemListListBean> weeklyItemList = List();
  List<ItemListListBean> mothItemList = List();
  List<ItemListListBean> allItemList = List();

  getWeeklyData() async {
    Api().get(
        "http://baobab.kaiyanapp.com/api/v3/ranklist?num=20&strategy=weekly&udid=26868b32e808498db32fd51fb422d00175e179df&vc=83",
        (data) {
      RankBean rankBean = RankBean(data);
      rankBean.itemList.forEach((item) {
        if (item != null) weeklyItemList.add(item);
      });
      notifyListeners();
    }, (error) {}, () {});
  }

  getMothData() async {
    Api().get(
        "http://baobab.kaiyanapp.com/api/v3/ranklist?num=20&strategy=monthly&udid=26868b32e808498db32fd51fb422d00175e179df&vc=83",
        (data) {
      RankBean rankBean = RankBean(data);
      rankBean.itemList.forEach((item) {
        if (item != null) mothItemList.add(item);
      });
      notifyListeners();
    }, (error) {}, () {});
  }

  getAllData() async {
    Api().get(
        "http://baobab.kaiyanapp.com/api/v3/ranklist?num=20&strategy=historical&udid=26868b32e808498db32fd51fb422d00175e179df&vc=83",
        (data) {
      RankBean rankBean = RankBean(data);
      rankBean.itemList.forEach((item) {
        if (item != null) allItemList.add(item);
      });
      notifyListeners();
    }, (error) {}, () {});
  }
}
