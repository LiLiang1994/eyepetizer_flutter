import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provide/provide.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DownloadModel extends ChangeNotifier {
  List<ItemListListBean> list = new List();

  getDownloaded() {
    list = [];
    SharedPreferences.getInstance().then((prefs) {
      List<String> downloadList = prefs.getStringList("download");
      if (downloadList == null) return;
      if (downloadList.isNotEmpty) {
        getExternalStorageDirectory().then((dir) {
          downloadList.forEach((item) {
            var itemBean = ItemListListBean.fromMap(json.decode(item));
            File(dir.path + "/eyepetizer_download" + "/${itemBean.data.id}")
                .exists()
                .then((exits) {
              if (exits) {
                list.add(itemBean);
                notifyListeners();
              } else {
                downloadList.remove(item);
              }
            });
          });
          prefs.setStringList("download", downloadList);
        });
      }
    });
  }

  clearAll() {
    SharedPreferences.getInstance().then((prefs) {
      var stringList = prefs.getStringList("download");
      stringList = [];
      prefs.setStringList("download", stringList);
      list = [];
      getExternalStorageDirectory().then((dir) async {
        var directory = Directory(dir.path + "/eyepetizer_download");
        var exists = await directory.exists();
        if (exists) {
          var list = directory.list(recursive: false, followLinks: false);
          list.forEach((file) {
            file.delete();
          });
        }
      });
      notifyListeners();
    });
  }

  deleteDownload(ItemListListBean item) {
    SharedPreferences.getInstance().then((prefs){
      var stringlist=prefs.getStringList("download");
      stringlist.remove(item.toString());
      prefs.setStringList("download", stringlist);
      list.remove(item);
      notifyListeners();
    });
  }
}
