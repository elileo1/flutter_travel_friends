///create by elileo on 2018/12/19
import 'package:flutter/material.dart';
import 'package:travel_friend/common/TextResources.dart';
class ChatPage extends StatefulWidget{
  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Text(TextResources.homeChatTitle);
  }

  @override
  bool get wantKeepAlive => true;

}