import 'package:eyepetizer_flutter/models/home_model.dart';
import 'package:eyepetizer_flutter/views/widgets/video_list.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'widgets/refresh_scaffold.dart';

bool isFirst = true;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentHomeData = Provide.value<HomeModel>(context);
    RefreshController controller = RefreshController();
    if (isFirst) {
      isFirst = false;
      currentHomeData.getHomeData(() {
      }, () {});
    }
//    curentHomeData.getHomeData();
//    return Provide<HomeModel>(
//      builder: (context, child, homeModel) {
//        return ListView.builder(
//          itemBuilder: (context, index) {
//            if (homeModel.itemList.isNotEmpty) {
//              return ListTile(
//                title: Text(homeModel.itemList[index].data.title),
//              );
//            }
//            return Center(
//              child: Text("---"),
//            );
//          },
//          itemCount: homeModel.itemList.length,
//        );
//      },
//    );
//    return Provide<HomeModel>(
//      builder: (context, child, homeModel) {
//        print(homeModel.itemList.length);
//        return RefreshScaffold(
//          isLoading: homeModel==null,
//          controller: controller,
//          onLoadMore: (up){
//            homeModel.getHomeData();
//          },
//          itemBuilder: (context, index) {
//            return ListTile(
//              title: Text(homeModel.itemList[index].data.title),
//            );
//          },
//          onRefresh: (){
//           return homeModel.getHomeData();
//          },
//          itemCount: homeModel.itemList.length,
//        );
//      },
//    );

    void _onRefresh(bool up) {
      if (up) {
        currentHomeData.itemList.clear();
        currentHomeData.getHomeData(() {
          controller.sendBack(true, RefreshStatus.completed);
          controller.sendBack(false, RefreshStatus.canRefresh);
        }, () {
          controller.sendBack(true, RefreshStatus.noMore);
        });
      } else {
        currentHomeData.refreshHomeData(() {
          controller.sendBack(false, RefreshStatus.idle);
        }, () {
          controller.sendBack(false, RefreshStatus.noMore);
        });
      }
    }

//    return StreamBuilder(
//      initialData: currentHomeData,
//      stream: Provide.stream<HomeModel>(context),
//      builder: (context, AsyncSnapshot<HomeModel> snapshot) {
//        return SmartRefresher(
//          child: ListView.builder(
//            itemBuilder: (context, index) {
//              return ListTile(
//                title: Text(snapshot.data.itemList[index].data.title),
//              );
//            },
//            itemCount: snapshot.data.itemList.length,
//          ),
//          enablePullDown: true,
//          enablePullUp: true,
//          controller: controller,
//          onRefresh: _onRefresh,
//        );
//      },
//    );
    return StreamBuilder(
      initialData: currentHomeData,
      stream: Provide.stream<HomeModel>(context),
      builder: (context, AsyncSnapshot<HomeModel> snapshot) {
        return SmartRefresher(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return VideoList(item:snapshot.data.itemList[index]);
            },
            itemCount: snapshot.data.itemList.length,
          ),
          enablePullDown: true,
          enablePullUp: true,
          controller: controller,
          onRefresh: _onRefresh,
        );
      },
    );
  }
}
