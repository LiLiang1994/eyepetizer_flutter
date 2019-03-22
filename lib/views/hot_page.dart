import 'package:eyepetizer_flutter/models/rank_model.dart';
import 'package:eyepetizer_flutter/views/widgets/video_list.dart';
import 'package:eyepetizer_flutter/views/widgets/weekly_list.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

bool isFirst = true;

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() {
    return _HotPageState();
  }
}

class _HotPageState extends State<HotPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            Provide.value<RankModel>(context).getWeeklyData();
            break;
          case 1:
            Provide.value<RankModel>(context).getMothData();
            break;
          case 2:
            Provide.value<RankModel>(context).getAllData();
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      Provide.value<RankModel>(context).getWeeklyData();
      isFirst = false;
    }
    return Container(
      child: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "周排行",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Tab(
                child: Text(
                  "月排行",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Tab(
                child: Text(
                  "总排行",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
            indicatorColor: Colors.grey,
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  child: Provide<RankModel>(
                    builder: (context, child, rankModel) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return RankList(
                              item: rankModel.weeklyItemList[index]);
                        },
                        itemCount: rankModel.weeklyItemList.length,
                      );
                    },
                  ),
                ),
                Container(
                  child: Provide<RankModel>(
                    builder: (context, child, rankModel) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return RankList(
                              item: rankModel.mothItemList[index]);
                        },
                        itemCount: rankModel.mothItemList.length,
                      );
                    },
                  ),
                ),
                Container(
                  child: Provide<RankModel>(
                    builder: (context, child, rankModel) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return RankList(
                              item: rankModel.mothItemList[index]);
                        },
                        itemCount: rankModel.mothItemList.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
