import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:eyepetizer_flutter/api/Api.dart';

class HomeRepository {
  // ignore: missing_return
  Future<List<ItemListListBean>> getVideoList() async {
    Api().get("/tabs/selected", (data) {

      HomeBean homeMode = HomeBean.fromMap(data);
      return homeMode.itemList;
    }, (error) {}, () {});
  }
}
