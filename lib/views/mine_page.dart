import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:eyepetizer_flutter/models/download_model.dart';
import 'package:eyepetizer_flutter/models/record_model.dart';
import 'package:eyepetizer_flutter/views/widgets/thumbnail_list.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Opacity(
            opacity: 0.5,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/landing_countdown_background.png",
                  height: 100,
                  width: 100,
                ),
                Image.asset(
                  "assets/images/ic_launcher.png",
                  height: 67,
                  width: 67,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Text(
            "我的下载",
            style: TextStyle(
                fontSize: 14, fontFamily: "FZLanTingHeiS", color: Colors.grey),
          ),
          onTap: () {
            Provide.value<DownloadModel>(context).getDownloaded();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Provide<DownloadModel>(
                builder: (context, child, downloadModel) {
                  return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(
                        "我的下载",
                        style: TextStyle(
                          inherit: false,
                          color: Colors.grey,
                          fontFamily: "FZLanTingHeiS",
                        ),
                      ),
                      backgroundColor: Colors.white,
                      iconTheme: IconThemeData(color: Colors.grey),
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.clear_all),
                            onPressed: () {
                              downloadModel.clearAll();
                            })
                      ],
                    ),
                    body: ListView.builder(
                      itemBuilder: (context, index) {
                        return ThumbList(item: downloadModel.list[index],isRecordList: false,);
                      },
                      itemCount: downloadModel.list.length,
                    ),
                  );
                },
              );
            }));
          },
        ),
        GestureDetector(
          child: Text(
            "观看记录",
            style: TextStyle(
                fontSize: 14, fontFamily: "FZLanTingHeiS", color: Colors.grey),
          ),
          onTap: () {
            Provide.value<RecordModel>(context).getRecord();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Provide<RecordModel>(
                builder: (context, child, recordModel) {
                  return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(
                        "观看记录",
                        style: TextStyle(
                            inherit: false,
                            color: Colors.grey,
                            fontFamily: "FZLanTingHeiS",
                            ),
                      ),
                      backgroundColor: Colors.white,
                      iconTheme: IconThemeData(color: Colors.grey),
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.clear_all),
                            onPressed: () {
                              recordModel.clearRecord();
                            })
                      ],
                    ),
                    body: ListView.builder(
                      itemBuilder: (context, index) {
                        return ThumbList(item: recordModel.itemList[index],isRecordList: true,);
                      },
                      itemCount: recordModel.itemList.length,
                    ),
                  );
                },
              );
            }));
          },
        )
      ],
    );
  }
}
