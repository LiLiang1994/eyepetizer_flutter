import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordModel extends ChangeNotifier {
  List<ItemListListBean> itemList = List();

  getRecord() {
    itemList = [];
    SharedPreferences.getInstance().then((prefs) {
      List<String> list = prefs.getStringList("record");
      if(list==null) return;
      if (list.isNotEmpty) {
        list.forEach((item) {
          itemList.add(ItemListListBean.fromMap(json.decode(item)));
        });
        notifyListeners();
      }
    });
  }

  clearRecord() {
    SharedPreferences.getInstance().then((prefs) {
      var stringList = prefs.getStringList("record");
      stringList = [];
      prefs.setStringList("record", stringList);
      itemList = [];
      notifyListeners();
    });
  }

  deleteRecord(String item) {
    itemList=[];
    SharedPreferences.getInstance().then((prefs) {
      var stringList = prefs.getStringList("record");
      if (stringList.contains(item)) {
        stringList.remove(item);
      }
      prefs.setStringList("record", stringList);
      if (stringList.isNotEmpty) {
        stringList.forEach((item) {
          itemList.add(ItemListListBean.fromMap(json.decode(item)));
        });
      }

      notifyListeners();
    });
  }
}
