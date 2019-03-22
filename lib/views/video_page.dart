import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

ItemListListBean itemListListBean;

class VideoPage extends StatefulWidget {
  final ItemListListBean item;

  const VideoPage({Key key, this.item}) : super(key: key);

  @override
  VideoPageState createState() {
    itemListListBean = item;
    return VideoPageState();
  }
}

class VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  bool isPressPlay = false;
  String appPath;
  bool isDownloaded = false;

  @override
  void initState() {
    _prepare().then((_) {
      SharedPreferences.getInstance().then((prefs) {
        List<String> list = prefs.getStringList("download");

        if (list != null) {
          File(appPath+"/${itemListListBean.data.id}").exists().then((exist){
            if (list.contains(itemListListBean.toString())&&exist) {
              print("$appPath/${itemListListBean.data.id}");
              isDownloaded = true;
            }else if(list.contains(itemListListBean.toString())&&!exist){
              print("file not exist");
              list.remove(itemListListBean.toString());
              prefs.setStringList("download",list);
            }
          });

        }
        setState(() {
          print("isdownloaded:$isDownloaded");
          _controller = isDownloaded
              ? VideoPlayerController.file(
                  File("$appPath/${itemListListBean.data.id}"))
              : VideoPlayerController.network(itemListListBean.data.playUrl);
        });
      });
    });

    FlutterDownloader.registerCallback((id, status, progress) {
      print("id:$id,status:$status,progress:$progress");
      if (status == DownloadTaskStatus.complete) {
        SharedPreferences.getInstance().then((prefs) {
          List<String> list = prefs.getStringList("download");
          if (list == null) {
            list = [];
            list.add(itemListListBean.toString());
          } else {
            if (!list.contains(itemListListBean.toString()))
              list.add(itemListListBean.toString());
          }
          prefs.setStringList("download", list);
        });
        setState(() {
          isDownloaded=true;
        });
      }
    });
    super.initState();

//      ..initialize().then((_) {
//        setState(() {});
//      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _controller!=null?Chewie(
                controller: ChewieController(
                    videoPlayerController: _controller,
                    showControls: true,
                    allowMuting: true,
                    placeholder: Image.network(
                      itemListListBean.data.cover.feed,
                      fit: BoxFit.fill,
                    ),
                    autoPlay: true),
              ):Container(),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              NetworkImage(itemListListBean.data.cover.blurred),
                          fit: BoxFit.fill)),
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                itemListListBean.data.title,
                                style: TextStyle(
                                    inherit: false,
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: "FZLanTingHeiS"),
                                softWrap: true,
                              ),
                              Text(
                                "发布于 ${itemListListBean.data.category}/${(itemListListBean.data.duration ~/ 60) < 10 ? ("0" + (itemListListBean.data.duration ~/ 60).toString()) : (itemListListBean.data.duration ~/ 60)}:${itemListListBean.data.duration % 60}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    inherit: false,
                                    fontFamily: "FZLanTingHeiS",
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                              Text(
                                itemListListBean.data.description,
                                style: TextStyle(
                                    inherit: false,
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: "FZLanTingHeiS"),
                                softWrap: true,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      Text(
                                        itemListListBean
                                            .data.consumption.collectionCount
                                            .toString(),
                                        style: TextStyle(
                                            inherit: false,
                                            fontFamily: "FZLanTingHeiS",
                                            fontStyle: FontStyle.italic,
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      Text(
                                        itemListListBean
                                            .data.consumption.collectionCount
                                            .toString(),
                                        style: TextStyle(
                                            inherit: false,
                                            fontFamily: "FZLanTingHeiS",
                                            fontStyle: FontStyle.italic,
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.message,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      Text(
                                        itemListListBean
                                            .data.consumption.collectionCount
                                            .toString(),
                                        style: TextStyle(
                                            inherit: false,
                                            fontFamily: "FZLanTingHeiS",
                                            fontStyle: FontStyle.italic,
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                isDownloaded?Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.assignment_turned_in,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      Text(
                                        '已下载',
                                        style: TextStyle(
                                            inherit: false,
                                            fontFamily: "FZLanTingHeiS",
                                            fontStyle: FontStyle.italic,
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ):GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.file_download,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          '下载',
                                          style: TextStyle(
                                              inherit: false,
                                              fontFamily: "FZLanTingHeiS",
                                              fontStyle: FontStyle.italic,
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    _requestDownload();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    FlutterDownloader.registerCallback(null);
  }

  Future _prepare() async {
    Directory appDir = await getExternalStorageDirectory();
    appPath = appDir.path+"/eyepetizer_download";
    var directory = Directory(appPath);
    var exists =await directory.exists();
    if(!exists){
      await directory.create(recursive: false);
    }
  }

  void _requestDownload() async {
    await FlutterDownloader.enqueue(
        url: itemListListBean.data.playUrl,
        fileName: "${itemListListBean.data.id}",
        savedDir: appPath,
        showNotification: true,
        openFileFromNotification: true);
  }
}
