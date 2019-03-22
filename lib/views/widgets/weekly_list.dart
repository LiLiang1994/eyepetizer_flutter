import 'package:eyepetizer_flutter/views/video_page.dart';
import 'package:flutter/material.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankList extends StatelessWidget {
  final ItemListListBean item;

  const RankList({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          height: 200.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(item.data.cover.feed),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                item.data.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: "FZLanTingHeiS",
                    fontSize: 18,
                    color: Colors.white),
                maxLines: 1,
              ),
              Text(
                " ${item.data.category}/${(item.data.duration ~/ 60) < 10 ? ("0" + (item.data.duration ~/ 60).toString()) : (item.data.duration ~/ 60)}:${item.data.duration % 60}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: "FZLanTingHeiS",
                    fontSize: 13,
                    color: Colors.white),
              ),
            ],
          )),
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
    ;
  }
}
