import 'dart:convert' show json;

import 'package:eyepetizer_flutter/beans/home_bean.dart';

class FindBean {

  int count;
  int total;
  bool adExist;
  String nextPageUrl;
  List<CategoryBean> itemList;

  FindBean.fromParams({this.count, this.total, this.adExist, this.nextPageUrl, this.itemList});

  factory FindBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new FindBean.fromJson(json.decode(jsonStr)) : new FindBean.fromJson(jsonStr);

  FindBean.fromJson(jsonRes) {
    count = jsonRes['count'];
    total = jsonRes['total'];
    adExist = jsonRes['adExist'];
    nextPageUrl = jsonRes['nextPageUrl'];
    itemList = jsonRes['itemList'] == null ? null : [];

    for (var itemListItem in itemList == null ? [] : jsonRes['itemList']){
      itemList.add(itemListItem == null ? null : new CategoryBean.fromJson(itemListItem));
    }
  }

  @override
  String toString() {
    return '{"count": $count,"total": $total,"adExist": $adExist,"nextPageUrl": ${nextPageUrl != null?'${json.encode(nextPageUrl)}':'null'},"itemList": $itemList}';
  }
}

class CategoryBean {

  String tag;
  int adIndex;
  int id;
  String type;
  DataBean data;

  CategoryBean.fromParams({this.tag, this.adIndex, this.id, this.type, this.data});

  CategoryBean.fromJson(jsonRes) {
    tag = jsonRes['tag'];
    adIndex = jsonRes['adIndex'];
    id = jsonRes['id'];
    type = jsonRes['type'];
    data = jsonRes['data'] == null ? null : new DataBean.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"tag": ${tag != null?'${json.encode(tag)}':'null'},"adIndex": $adIndex,"id": $id,"type": ${type != null?'${json.encode(type)}':'null'},"data": $data}';
  }
}

class DataBean {

  String adTrack;
  String footer;
  int count;
  String dataType;
  List<ItemListListBean> itemList;
  HeaderBean header;

  DataBean.fromParams({this.adTrack, this.footer, this.count, this.dataType, this.itemList, this.header});

  DataBean.fromJson(jsonRes) {
    adTrack = jsonRes['adTrack'];
    footer = jsonRes['footer'];
    count = jsonRes['count'];
    dataType = jsonRes['dataType'];
    itemList = ItemListListBean.fromMapList(jsonRes['itemList']);
    header = jsonRes['header'] == null ? null : new HeaderBean.fromJson(jsonRes['header']);
  }

  @override
  String toString() {
    return '{"adTrack": ${adTrack != null?'${json.encode(adTrack)}':'null'},"footer": ${footer != null?'${json.encode(footer)}':'null'},"count": $count,"dataType": ${dataType != null?'${json.encode(dataType)}':'null'},"itemList": $itemList,"header": $header}';
  }
}

class HeaderBean {

  String cover;
  String label;
  String labelList;
  String rightText;
  String subTitleFont;
  int id;
  String actionUrl;
  String font;
  String subTitle;
  String textAlign;
  String title;
  CategoryFollowBean follow;

  HeaderBean.fromParams({this.cover, this.label, this.labelList, this.rightText, this.subTitleFont, this.id, this.actionUrl, this.font, this.subTitle, this.textAlign, this.title, this.follow});

  HeaderBean.fromJson(jsonRes) {
    cover = jsonRes['cover'];
    label = jsonRes['label'];
    labelList = jsonRes['labelList'];
    rightText = jsonRes['rightText'];
    subTitleFont = jsonRes['subTitleFont'];
    id = jsonRes['id'];
    actionUrl = jsonRes['actionUrl'];
    font = jsonRes['font'];
    subTitle = jsonRes['subTitle'];
    textAlign = jsonRes['textAlign'];
    title = jsonRes['title'];
    follow = jsonRes['follow'] == null ? null : new CategoryFollowBean.fromJson(jsonRes['follow']);
  }

  @override
  String toString() {
    return '{"cover": ${cover != null?'${json.encode(cover)}':'null'},"label": ${label != null?'${json.encode(label)}':'null'},"labelList": ${labelList != null?'${json.encode(labelList)}':'null'},"rightText": ${rightText != null?'${json.encode(rightText)}':'null'},"subTitleFont": ${subTitleFont != null?'${json.encode(subTitleFont)}':'null'},"id": $id,"actionUrl": ${actionUrl != null?'${json.encode(actionUrl)}':'null'},"font": ${font != null?'${json.encode(font)}':'null'},"subTitle": ${subTitle != null?'${json.encode(subTitle)}':'null'},"textAlign": ${textAlign != null?'${json.encode(textAlign)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"follow": $follow}';
  }
}

class CategoryFollowBean {

  int itemId;
  bool followed;
  String itemType;

  CategoryFollowBean.fromParams({this.itemId, this.followed, this.itemType});

  CategoryFollowBean.fromJson(jsonRes) {
    itemId = jsonRes['itemId'];
    followed = jsonRes['followed'];
    itemType = jsonRes['itemType'];
  }

  @override
  String toString() {
    return '{"itemId": $itemId,"followed": $followed,"itemType": ${itemType != null?'${json.encode(itemType)}':'null'}}';
  }
}




