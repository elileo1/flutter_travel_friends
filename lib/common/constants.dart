///create by elileo on 2018/12/18
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_friend/common/TextResources.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String txt){
  Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Color(0xAA000000),
      textColor: Colors.white
  );
}

///正在加载
Widget buildLoadingIndicator() {
  return new Center(
    child: new CupertinoActivityIndicator(),
  );
}

///网络出错
Widget buildNetBroken(tips, clickRetry){
  return new Center(
    child: GestureDetector(
      onTap: clickRetry,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/bg_center_cat.png", width: 196, height: 124),
          Container(padding: const EdgeInsets.only(top: 8),),
          Text(tips, style: TextStyle(color: GlobalConfig.color666666, fontSize: 14))
        ],
      ),
    ),
  );
}

//加载更多
Widget buildLoadMore() {
  return new Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new CupertinoActivityIndicator(),
        new Text(TextResources.loadMoreTips)
      ],
    ),
  );
}
