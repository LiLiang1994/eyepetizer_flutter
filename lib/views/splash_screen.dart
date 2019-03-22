import 'package:eyepetizer_flutter/models/home_model.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:provide/provide.dart';
import 'package:eyepetizer_flutter/beans/home_bean.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: .0, end: 1.0).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyHomePage()),
              (route) => route == null);
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/landing_background.jpg"),
        fit: BoxFit.fill,
      )),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          FadeTransition(
            opacity: _animationController,
            child: Image.asset(
              "assets/images/ic_action_focus_white_no_margin.png",
              width: 61.0,
              height: 42.0,
            ),
          ),
          Align(
            child: Text(
              "Eyepetizer",
              style: TextStyle(
                  fontSize: 25, fontFamily: 'Lobster', color: Colors.white,inherit: false),
            ),
            alignment: const Alignment(0.0, 0.15),
          ),
          Align(
            child: Text(
              "开眼",
              style: TextStyle(fontSize: 18, fontFamily: 'FZLanTingHeiS',color: Colors.white,inherit: false),
            ),
            alignment: const Alignment(0.0, 0.3),
          ),
          Align(
            child: Text(
              "Daily appetizers for your eyes，Bon eyepetit",
              style: TextStyle(fontSize: 15, fontFamily: 'Lobster',color: Colors.white,inherit: false),
            ),
            alignment: const Alignment(0.0, 0.8),
          ),
          Align(
            child: Text(
              "每日精选视频推介，让你大开眼界。",
              style: TextStyle(fontSize: 14, fontFamily: 'FZLanTingHeiS',color: Colors.white,inherit: false),
            ),
            alignment:const Alignment(0.0, 0.9),
          ),
        ],
      ),
    );
  }
}
