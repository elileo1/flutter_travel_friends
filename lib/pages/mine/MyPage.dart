///create by elileo on 2018/12/19
import 'package:flutter/material.dart';
import 'package:travel_friend/common/TextResources.dart';
class MyPage extends StatefulWidget{
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Text(TextResources.homeMyTitle);
  }

  @override
  bool get wantKeepAlive => true;
}