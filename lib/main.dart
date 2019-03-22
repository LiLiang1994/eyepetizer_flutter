import 'package:eyepetizer_flutter/models/download_model.dart';
import 'package:eyepetizer_flutter/models/rank_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/splash_screen.dart';
import 'models/home_model.dart';
import 'package:provide/provide.dart';
import 'package:permission_handler/permission_handler.dart';
import 'models/find_model.dart';
import 'models/record_model.dart';

void main() {
  final HomeModel homeModel = HomeModel();
  final FindModel findModel = FindModel();
  final RankModel rankModel = RankModel();
  final RecordModel recordModel = RecordModel();
  final DownloadModel downloadModel=DownloadModel();
  var providers = Providers();
  providers
    ..provide(Provider<HomeModel>.value(homeModel))
    ..provide(Provider<FindModel>.value(findModel))
    ..provide(Provider<RankModel>.value(rankModel))
    ..provide(Provider<RecordModel>.value(recordModel))
    ..provide(Provider<DownloadModel>.value(downloadModel))
  ;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  PermissionHandler()
      .checkPermissionStatus(PermissionGroup.storage)
      .then((status) {
    if (status == PermissionStatus.denied) {
      PermissionHandler()
          .requestPermissions([PermissionGroup.storage]).then((value) {
        if (value[PermissionGroup.storage] == PermissionStatus.granted) {
          runApp(ProviderNode(child: MyApp(), providers: providers));
        }
      });
    } else {
      runApp(ProviderNode(child: MyApp(), providers: providers));
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
