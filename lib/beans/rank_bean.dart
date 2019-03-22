import 'dart:convert' show json;
import 'package:eyepetizer_flutter/beans/home_bean.dart';
class RankBean {

  String nextPageUrl;
  int count;
  int total;
  bool adExist;
  List<ItemListListBean> itemList;

  RankBean.fromParams({this.nextPageUrl, this.count, this.total, this.adExist, this.itemList});

  factory RankBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RankBean.fromJson(json.decode(jsonStr)) : new RankBean.fromJson(jsonStr);

  RankBean.fromJson(jsonRes) {
    nextPageUrl = jsonRes['nextPageUrl'];
    count = jsonRes['count'];
    total = jsonRes['total'];
    adExist = jsonRes['adExist'];
//    itemList = jsonRes['itemList'] == null ? null : [];
    itemList = ItemListListBean.fromMapList(jsonRes['itemList']);
  }

  @override
  String toString() {
    return '{"nextPageUrl": ${nextPageUrl != null?'${json.encode(nextPageUrl)}':'null'},"count": $count,"total": $total,"adExist": $adExist,"itemList": $itemList}';
  }
}
