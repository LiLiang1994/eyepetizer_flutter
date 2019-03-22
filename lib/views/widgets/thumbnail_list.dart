import 'package:eyepetizer_flutter/models/download_model.dart';
import 'package:eyepetizer_flutter/models/record_model.dart';
import 'package:flutter/material.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:eyepetizer_flutter/views/video_page.dart';
import 'package:provide/provide.dart';

class ThumbList extends StatelessWidget {
  final ItemListListBean item;
  final isRecordList;

  const ThumbList({Key key, this.item, this.isRecordList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Image.network(item.data.cover.feed),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.data.title,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "FZLanTingHeiS",
                          color: Colors.black45),
                      maxLines: 2,
                    ),
                    Text(
                      "${item.data.category}/${(item.data.duration ~/ 60) < 10 ? ("0" + (item.data.duration ~/ 60).toString()) : (item.data.duration ~/ 60)}:${item.data.duration % 60}",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "FZLanTingHeiS",
                          color: Colors.black45),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return VideoPage(
            item: item,
          );
        }));
      },
      onLongPress: () {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("是否删除记录"),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.check), onPressed: (){
                if(isRecordList){
                  Provide.value<RecordModel>(context).deleteRecord(item.toString());
                }else{
                  Provide.value<DownloadModel>(context).deleteDownload(item);
                }
                Navigator.of(context).pop();
              }),
              IconButton(icon: Icon(Icons.clear), onPressed: (){
                Navigator.of(context).pop();
              })
            ],
          );
        });
      },
    );
  }
}
