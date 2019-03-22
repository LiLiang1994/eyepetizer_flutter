import 'package:eyepetizer_flutter/views/video_page.dart';
import 'package:flutter/material.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class VideoList extends StatelessWidget {
  final ItemListListBean item;

  const VideoList({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            Image.network(
              item.data.cover.feed,
              height: 200.0,
              fit: BoxFit.fill,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image.network(
                    item.data.author.icon,
                    height: 30.0,
                    width: 30.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        item.data.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "FZLanTingHeiS",
                            fontSize: 15,
                            color: Colors.grey),
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "发布于 ${item.data.category}/${(item.data.duration ~/ 60) < 10 ? ("0" + (item.data.duration ~/ 60).toString()) : (item.data.duration ~/ 60)}:${item.data.duration % 60}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "FZLanTingHeiS",
                            fontStyle: FontStyle.italic,
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                    )
                  ],
                )),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        SharedPreferences.getInstance().then((prefs) {
          List<String> list = prefs.getStringList("record");
          String itemString = item.toString();
          if (list == null) {
            list = [];
            list.add(itemString);
          } else {
            if (!list.contains(itemString)) list.add(itemString);
          }
          prefs.setStringList("record", list);
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return VideoPage(
            item: item,
          );
        }));
      },
    );
  }
}
