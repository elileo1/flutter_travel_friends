import 'dart:io';

///create by elileo on 2018/12/18
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:travel_friend/pages/ApplicationPage.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        primaryColor: GlobalConfig.colorPrimary,
        primaryColorBrightness: Brightness.dark
      ),
      home: new ApplicationPage(),
    );
  }
}
