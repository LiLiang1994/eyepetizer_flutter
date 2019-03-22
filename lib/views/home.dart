import 'package:flutter/material.dart';
import 'home_page.dart';
import 'find_page.dart';
import 'hot_page.dart';
import 'mine_page.dart';

bool showTabView = false;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List weeks = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _last;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xfafafafa),
            title: Text(
              weeks[DateTime.now().weekday],
              style: TextStyle(
                  inherit: false, color: Colors.grey, fontFamily: 'Lobster'),
            ),
           elevation: showTabView?0:1,
          ),
          body: IndexedStack(
            children: <Widget>[HomePage(), FindPage(), HotPage(), MinePage()],
            index: _selectedIndex,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(const IconData(0xe621,
                      fontFamily: 'BottomBarIcon', matchTextDirection: true)),
                  title: Text(
                    '首页',
                    style: TextStyle(fontSize: 12.0),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(const IconData(0xe62c,
                      fontFamily: 'BottomBarIcon', matchTextDirection: true)),
                  title: Text('发现', style: TextStyle(fontSize: 12.0))),
              BottomNavigationBarItem(
                  icon: Icon(const IconData(0xe60b,
                      fontFamily: 'BottomBarIcon', matchTextDirection: true)),
                  title: Text('热门', style: TextStyle(fontSize: 12.0))),
              BottomNavigationBarItem(
                  icon: Icon(const IconData(0xe8a0,
                      fontFamily: 'BottomBarIcon', matchTextDirection: true)),
                  title: Text('我的', style: TextStyle(fontSize: 12.0))),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.black,
            onTap: _onItemTapped,
            iconSize: 20,
          ),
        ),
        onWillPop: () async {
          if (_last == null ||
              DateTime.now().difference(_last) > Duration(seconds: 1)) {
            _last = DateTime.now();
            return false;
          }
          return true;
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        showTabView = true;
      } else {
        showTabView = false;
      }
    });
  }
}
