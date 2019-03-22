import 'package:eyepetizer_flutter/models/find_model.dart';
import 'package:eyepetizer_flutter/views/widgets/find_list.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

bool isFirst = true;

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() {
    return _FindPageState();
  }
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    final currentFindData = Provide.value<FindModel>(context);
    RefreshController controller = RefreshController();
    if (isFirst) {
      currentFindData.getFindDate();
      isFirst = false;
    }
    return Provide<FindModel>(builder: (context, child, findModel) {
      return SmartRefresher(
        enablePullUp: true,
        enablePullDown: false,
        controller: controller,
        onRefresh: (up) {
          if (!up) {
            findModel.getNextFindDate(() {
              controller.sendBack(false, RefreshStatus.idle);
            }, () {
              controller.sendBack(false, RefreshStatus.noMore);
            });
          }
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.8, mainAxisSpacing: 2),
          itemBuilder: (context, index) {
            return FindList(
              bean: findModel.list[index],
            );
          },
          itemCount: findModel.list.length,
        ),
      );
    });
  }
}
