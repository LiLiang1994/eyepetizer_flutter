import 'package:eyepetizer_flutter/views/widgets/video_list.dart';
import 'package:flutter/material.dart';
import 'package:eyepetizer_flutter/beans/find_bean.dart';

class FindList extends StatelessWidget {
  final CategoryBean bean;

  const FindList({Key key, @required this.bean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String bgUrl;
    bean.data.itemList[0].data.tags.forEach((tag) {
      if (tag.name == bean.data.header.title) {
        bgUrl = tag.bgPicture;
      }
    });
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: bgUrl!=null?NetworkImage(bgUrl):AssetImage("assets/images/landing_background.jpg"), fit: BoxFit.cover)),
        child: Text(
          bean.data.header.title,
          style: TextStyle(
              color: Colors.white, fontFamily: "FZLanTingHeiS", fontSize: 20),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(bean.data.header.title,style: TextStyle(inherit: false, color: Colors.grey, fontFamily:"FZLanTingHeiS",letterSpacing: 5),),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return VideoList(item: bean.data.itemList[index]);
              },
              itemCount: bean.data.itemList.length,
            ),
          );
        }));
      },
    );
  }
}
